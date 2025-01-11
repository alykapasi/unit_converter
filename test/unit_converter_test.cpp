#include <iostream>
#include <cassert>
#include <cmath>
#include "unit_converter.hpp"

// Helper function to check if two doubles are approximately equal
bool approx_equal(double a, double b, double epsilon = 0.0001) {
    return std::fabs(a - b) < epsilon;
}

void test_distance_conversions() {
    std::cout << "\nTesting distance conversions..." << std::endl;
    UnitConverter converter;
    
    assert(approx_equal(converter.convert("km", "m", 1), 1000));
    assert(approx_equal(converter.convert("m", "km", 1000), 1));
    assert(approx_equal(converter.convert("mi", "km", 1), 1.60934));
    std::cout << "✓ Basic distance conversions passed" << std::endl;
    
    // Test chained conversions
    assert(approx_equal(converter.convert("km", "in", 1), 39370.0787));
    assert(approx_equal(converter.convert("in", "km", 39370.0787), 1));
    assert(approx_equal(converter.convert("in", "m", 1), 0.0254));
    std::cout << "✓ Chained distance conversions passed" << std::endl;
}

void test_temperature_conversions() {
    std::cout << "\nTesting temperature conversions..." << std::endl;
    UnitConverter converter;
    
    assert(approx_equal(converter.convert("c", "f", 0), 32));
    assert(approx_equal(converter.convert("f", "c", 32), 0));
    assert(approx_equal(converter.convert("c", "k", 0), 273.15));
    std::cout << "✓ Temperature conversions passed" << std::endl;
}

void test_mass_conversions() {
    std::cout << "\nTesting mass conversions..." << std::endl;
    UnitConverter converter;
    
    assert(approx_equal(converter.convert("kg", "lb", 1), 2.20462));
    assert(approx_equal(converter.convert("g", "oz", 100), 3.5274));
    std::cout << "✓ Mass conversions passed" << std::endl;
}

void test_invalid_conversions() {
    std::cout << "\nTesting invalid conversions..." << std::endl;
    UnitConverter converter;
    
    try {
        converter.convert("invalid", "unit", 1);
        assert(false && "Should have thrown an exception");
    } catch (const std::runtime_error& e) {
        std::cout << "✓ Successfully caught invalid conversion: " << e.what() << std::endl;
    }
}

int main() {
    std::cout << "Running unit converter tests..." << std::endl;
    
    try {
        test_distance_conversions();
        test_temperature_conversions();
        test_mass_conversions();
        test_invalid_conversions();
        
        std::cout << "\n✓ All tests passed!" << std::endl;
        return 0;
    } catch (const std::exception& e) {
        std::cerr << "\n✗ Test failed: " << e.what() << std::endl;
        return 1;
    }
} 