#include <iostream>
#include <string>
#include <sstream>
#include <iomanip>
#include <limits>
#include "unit_converter.hpp"

void print_type_help(const std::string& type) {
    if (type == "distance") {
        std::cout << "Distance Units:\n"
                  << "  m  (meters)\n"
                  << "  km (kilometers)\n"
                  << "  mi (miles)\n"
                  << "  yd (yards)\n"
                  << "  in (inches)\n"
                  << "  cm (centimeters)\n\n"
                  << "Example: 100 km m\n";
    } else if (type == "speed") {
        std::cout << "Speed Units:\n"
                  << "  mph   (miles per hour)\n"
                  << "  kph   (kilometers per hour)\n"
                  << "  m_s   (meters per second)\n"
                  << "  ft_s  (feet per second)\n\n"
                  << "Example: 60 mph kph\n";
    } else if (type == "temperature") {
        std::cout << "Temperature Units:\n"
                  << "  c (Celsius)\n"
                  << "  f (Fahrenheit)\n"
                  << "  k (Kelvin)\n\n"
                  << "Example: 32 f c\n";
    } else if (type == "mass") {
        std::cout << "Mass Units:\n"
                  << "  kg (kilograms)\n"
                  << "  lb (pounds)\n"
                  << "  g  (grams)\n"
                  << "  oz (ounces)\n\n"
                  << "Example: 1 kg lb\n";
    } else if (type == "force") {
        std::cout << "Force Units:\n"
                  << "  N   (Newtons)\n"
                  << "  lbf (Pound-force)\n\n"
                  << "Example: 10 N lbf\n";
    } else if (type == "pressure") {
        std::cout << "Pressure Units:\n"
                  << "  Pa  (Pascal)\n"
                  << "  psi (Pounds per square inch)\n\n"
                  << "Example: 100 Pa psi\n";
    }
}

void print_usage() {
    std::cout << "Usage:\n"
              << "  unit_converter <value> <from_unit> <to_unit>    # Direct conversion\n"
              << "  unit_converter -t <type>                        # Interactive mode\n\n"
              << "Available types:\n"
              << "  distance     (m, km, mi, yd, in, cm)\n"
              << "  speed       (mph, kph, m/s, ft/s)\n"
              << "  temperature (C, F, K)\n"
              << "  mass        (kg, lb, g, oz)\n"
              << "  force       (N, lbf)\n"
              << "  pressure    (Pa, psi)\n\n"
              << "Examples:\n"
              << "  unit_converter 100 km m          # Convert 100 kilometers to meters\n"
              << "  unit_converter -t distance       # Enter interactive mode for distance\n"
              << "  unit_converter --help            # Show this help\n";
}

void interactive_mode(const std::string& type) {
    UnitConverter converter;
    std::cout << "Interactive " << type << " converter (type 'help' for units, 'exit' to quit)\n";
    
    while (true) {
        std::cout << "> ";
        std::string input;
        std::getline(std::cin, input);
        
        if (input == "exit" || input == "quit") {
            break;
        }
        
        if (input == "help") {
            print_type_help(type);
            continue;
        }
        
        // Parse input
        std::istringstream iss(input);
        std::string value_str, from_unit, to_unit;
        
        if (!(iss >> value_str >> from_unit >> to_unit)) {
            std::cout << "Invalid input. Format: <value> <from_unit> <to_unit>\n";
            std::cout << "Type 'help' for available units\n";
            continue;
        }
        
        try {
            double value = std::stod(value_str);
            double result = converter.convert(from_unit, to_unit, value);
            std::cout << std::fixed << std::setprecision(4);
            std::cout << value << " " << from_unit << " = " << result << " " << to_unit << std::endl;
        } catch (const std::invalid_argument&) {
            std::cout << "Error: Invalid number format '" << value_str << "'\n";
        } catch (const std::runtime_error& e) {
            std::cout << "Error: " << e.what() << "\n";
            std::cout << "Type 'help' to see available units\n";
        } catch (const std::exception& e) {
            std::cout << "Error: " << e.what() << "\n";
        }
    }
}

int main(int argc, char* argv[]) {
    if (argc == 2 && (std::string(argv[1]) == "-h" || std::string(argv[1]) == "--help")) {
        print_usage();
        return 0;
    }
    
    if (argc == 3 && std::string(argv[1]) == "-t") {
        std::string type = argv[2];
        if (type == "distance" || type == "speed" || type == "temperature" || 
            type == "mass" || type == "force" || type == "pressure") {
            interactive_mode(type);
            return 0;
        } else {
            std::cerr << "Error: Invalid type '" << type << "'\n";
            print_usage();
            return 1;
        }
    }

    if (argc != 4) {
        std::cerr << "Error: Invalid number of arguments\n\n";
        print_usage();
        return 1;
    }

    try {
        double value = std::stod(argv[1]);
        std::string from_unit = argv[2];
        std::string to_unit = argv[3];

        UnitConverter converter;
        double result = converter.convert(from_unit, to_unit, value);
        
        std::cout << std::fixed << std::setprecision(4);
        std::cout << value << " " << from_unit << " = " << result << " " << to_unit << std::endl;
    } catch (const std::invalid_argument&) {
        std::cerr << "Error: Invalid number format '" << argv[1] << "'\n";
        return 1;
    } catch (const std::runtime_error& e) {
        std::cerr << "Error: " << e.what() << "\n";
        std::cerr << "Use -h or --help to see available units\n";
        return 1;
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << "\n";
        return 1;
    }

    return 0;
}
