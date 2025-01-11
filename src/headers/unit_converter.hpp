#ifndef UNIT_CONVERTER_HPP
#define UNIT_CONVERTER_HPP

#include <string>
#include <unordered_map>
#include <stdexcept>
#include <vector>
#include <set>
#include <sqlite3.h>
#include <memory>

class UnitConverter {
public:
    UnitConverter();
    ~UnitConverter();
    double convert(const std::string& from_unit, const std::string& to_unit, double value) const;

private:
    struct SQLiteDeleter {
        void operator()(sqlite3* db) { sqlite3_close(db); }
    };
    
    std::unordered_map<std::string, std::unique_ptr<sqlite3, SQLiteDeleter>> databases;
    
    // Helper methods for conversion
    double convert_temperature(const std::string& from_unit, const std::string& to_unit, double value) const;
    bool is_temperature_unit(const std::string& unit) const;
    
    // Methods for finding conversion paths
    std::vector<std::string> get_connected_units(const std::string& unit, const std::string& db_name) const;
    bool find_conversion_path(const std::string& current, const std::string& target,
                            std::vector<std::string>& path, std::set<std::string>& visited,
                            const std::string& db_name) const;
    double apply_conversion_path(const std::vector<std::string>& path, double value,
                               const std::string& db_name) const;
    
    // Database methods
    void init_database(const std::string& category);
    double get_conversion_factor(const std::string& from_unit, const std::string& to_unit,
                               const std::string& db_name) const;
    std::string determine_category(const std::string& unit) const;
    bool unit_exists(const std::string& unit, const std::string& db_name) const;
};

#endif // UNIT_CONVERTER_HPP 