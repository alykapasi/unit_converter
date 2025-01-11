#include "headers/unit_converter.hpp"
#include <cmath>
#include <algorithm>
#include <filesystem>
#include <iostream>

namespace fs = std::filesystem;

UnitConverter::UnitConverter() {
    // Initialize databases for each category
    init_database("distance");
    init_database("temperature");
    init_database("mass");
    init_database("speed");
    init_database("force");
    init_database("pressure");
    init_database("currency");
}

UnitConverter::~UnitConverter() {
    databases.clear();
}

void UnitConverter::init_database(const std::string& category) {
    sqlite3* db;
    std::string db_path;
#ifdef INSTALL_PATH
    db_path = (fs::path(INSTALL_PATH) / ".." / "share" / "unit_converter" / (category + ".db")).string();
    if (!fs::exists(db_path)) {
#endif
        db_path = "data/" + category + ".db";
#ifdef INSTALL_PATH
    }
#endif
    
    int rc = sqlite3_open_v2(db_path.c_str(), &db, SQLITE_OPEN_READONLY, nullptr);
    if (rc) {
        std::string error = sqlite3_errmsg(db);
        sqlite3_close(db);
        throw std::runtime_error("Can't open database: " + error);
    }
    
    databases[category] = std::unique_ptr<sqlite3, SQLiteDeleter>(db);
}

double UnitConverter::convert(const std::string& from_unit, const std::string& to_unit, double value) const {
    std::string category = determine_category(from_unit);
    if (category != determine_category(to_unit)) {
        throw std::runtime_error("Cannot convert between different unit categories");
    }
    
    if (category == "temperature") {
        return convert_temperature(from_unit, to_unit, value);
    }
    
    std::vector<std::string> path;
    std::set<std::string> visited;
    if (find_conversion_path(from_unit, to_unit, path, visited, category)) {
        return apply_conversion_path(path, value, category);
    }
    
    throw std::runtime_error("No conversion path found from " + from_unit + " to " + to_unit);
}

std::vector<std::string> UnitConverter::get_connected_units(const std::string& unit, const std::string& db_name) const {
    std::vector<std::string> connected;
    sqlite3_stmt* stmt;
    
    const char* sql = "SELECT u2.symbol FROM conversions c "
                     "JOIN units u1 ON c.from_unit = u1.id "
                     "JOIN units u2 ON c.to_unit = u2.id "
                     "WHERE u1.symbol = ?";
    
    auto it = databases.find(db_name);
    if (it == databases.end()) {
        throw std::runtime_error("Database not found: " + db_name);
    }
    
    int rc = sqlite3_prepare_v2(it->second.get(), sql, -1, &stmt, nullptr);
    if (rc != SQLITE_OK) {
        throw std::runtime_error(sqlite3_errmsg(it->second.get()));
    }
    
    sqlite3_bind_text(stmt, 1, unit.c_str(), -1, SQLITE_STATIC);
    
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        const unsigned char* to_unit = sqlite3_column_text(stmt, 0);
        connected.push_back(reinterpret_cast<const char*>(to_unit));
    }
    
    sqlite3_finalize(stmt);
    return connected;
}

bool UnitConverter::find_conversion_path(const std::string& current, const std::string& target,
                                       std::vector<std::string>& path, std::set<std::string>& visited,
                                       const std::string& db_name) const {
    if (current == target) {
        return true;
    }
    
    visited.insert(current);
    path.push_back(current);
    
    std::vector<std::string> connected = get_connected_units(current, db_name);
    for (const std::string& next : connected) {
        if (visited.find(next) == visited.end()) {
            if (find_conversion_path(next, target, path, visited, db_name)) {
                return true;
            }
        }
    }
    
    path.pop_back();
    return false;
}

double UnitConverter::apply_conversion_path(const std::vector<std::string>& path, double value,
                                          const std::string& db_name) const {
    if (path.size() < 2) {
        return value;
    }
    
    double result = value;
    for (size_t i = 0; i < path.size() - 1; ++i) {
        result *= get_conversion_factor(path[i], path[i + 1], db_name);
    }
    
    return result;
}

double UnitConverter::get_conversion_factor(const std::string& from_unit, const std::string& to_unit,
                                          const std::string& db_name) const {
    sqlite3_stmt* stmt;
    const char* sql = "SELECT factor FROM conversions c "
                     "JOIN units u1 ON c.from_unit = u1.id "
                     "JOIN units u2 ON c.to_unit = u2.id "
                     "WHERE u1.symbol = ? AND u2.symbol = ?";
    
    auto it = databases.find(db_name);
    if (it == databases.end()) {
        throw std::runtime_error("Database not found: " + db_name);
    }
    
    int rc = sqlite3_prepare_v2(it->second.get(), sql, -1, &stmt, nullptr);
    if (rc != SQLITE_OK) {
        throw std::runtime_error(sqlite3_errmsg(it->second.get()));
    }
    
    sqlite3_bind_text(stmt, 1, from_unit.c_str(), -1, SQLITE_STATIC);
    sqlite3_bind_text(stmt, 2, to_unit.c_str(), -1, SQLITE_STATIC);
    
    double factor = 0.0;
    if (sqlite3_step(stmt) == SQLITE_ROW) {
        factor = sqlite3_column_double(stmt, 0);
    }
    
    sqlite3_finalize(stmt);
    
    if (factor == 0.0) {
        throw std::runtime_error("No conversion factor found from " + from_unit + " to " + to_unit);
    }
    
    return factor;
}

std::string UnitConverter::determine_category(const std::string& unit) const {
    static const std::vector<std::string> categories = {
        "distance", "temperature", "mass", "speed", "force", "pressure", "currency"
    };
    
    for (const auto& category : categories) {
        if (unit_exists(unit, category)) {
            return category;
        }
    }
    
    throw std::runtime_error("Unknown unit: " + unit);
}

bool UnitConverter::unit_exists(const std::string& unit, const std::string& db_name) const {
    sqlite3_stmt* stmt;
    const char* sql = "SELECT 1 FROM units WHERE symbol = ?";
    
    auto it = databases.find(db_name);
    if (it == databases.end()) {
        return false;
    }
    
    int rc = sqlite3_prepare_v2(it->second.get(), sql, -1, &stmt, nullptr);
    if (rc != SQLITE_OK) {
        return false;
    }
    
    sqlite3_bind_text(stmt, 1, unit.c_str(), -1, SQLITE_STATIC);
    
    bool exists = sqlite3_step(stmt) == SQLITE_ROW;
    sqlite3_finalize(stmt);
    
    return exists;
}

bool UnitConverter::is_temperature_unit(const std::string& unit) const {
    return unit_exists(unit, "temperature");
}

double UnitConverter::convert_temperature(const std::string& from_unit, const std::string& to_unit, double value) const {
    if (!is_temperature_unit(from_unit) || !is_temperature_unit(to_unit)) {
        throw std::runtime_error("Invalid temperature units: " + from_unit + " to " + to_unit);
    }
    
    // Convert to Celsius first
    double celsius;
    if (from_unit == "c") {
        celsius = value;
    } else if (from_unit == "f") {
        celsius = (value - 32.0) * 5.0 / 9.0;
    } else if (from_unit == "k") {
        celsius = value - 273.15;
    } else {
        throw std::runtime_error("Invalid temperature unit: " + from_unit);
    }
    
    // Convert from Celsius to target unit
    if (to_unit == "c") {
        return celsius;
    } else if (to_unit == "f") {
        return celsius * 9.0 / 5.0 + 32.0;
    } else if (to_unit == "k") {
        return celsius + 273.15;
    } else {
        throw std::runtime_error("Invalid temperature unit: " + to_unit);
    }
}

