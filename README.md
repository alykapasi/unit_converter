# Unit Converter

A command-line unit conversion tool that uses DFS (Depth-First Search) to find conversion paths between units.

## Features

- Supports multiple unit categories:
  - Distance (m, km, mi, yd, in, cm)
  - Speed (mph, kph, m/s, ft/s)
  - Temperature (C, F, K)
  - Mass (kg, lb, g, oz)
  - Force (N, lbf)
  - Pressure (Pa, psi)
- Automatic conversion path finding using DFS
- Special handling for temperature conversions
- Easy to extend with new units

## Project Structure

```
unit_converter/
├── include/           # Header files
│   └── unit_converter.hpp
├── src/              # Source files
│   ├── main.cpp
│   └── unit_converter.cpp
├── test/             # Test files
│   └── unit_converter_test.cpp
├── build/            # Compiled object files
├── bin/              # Executable files
└── Makefile
```

## Building

```bash
# Build the program
make

# Run tests
make test

# Install globally
sudo make install

# Uninstall
sudo make uninstall

# Clean build files
make clean
```

## Usage

```bash
# Basic usage
unit_converter <value> <from_unit> <to_unit>

# Examples
unit_converter 100 km m     # Convert 100 kilometers to meters
unit_converter 32 f c       # Convert 32 Fahrenheit to Celsius
unit_converter 1 kg lb      # Convert 1 kilogram to pounds
unit_converter 10 m yd      # Convert 10 meters to yards

# Show help
unit_converter --help
```

## Supported Units

- Distance
  - m (meters)
  - km (kilometers)
  - mi (miles)
  - yd (yards)
  - in (inches)
  - cm (centimeters)

- Speed
  - mph (miles per hour)
  - kph (kilometers per hour)
  - m_s (meters per second)
  - ft_s (feet per second)

- Temperature
  - c (Celsius)
  - f (Fahrenheit)
  - k (Kelvin)

- Mass
  - kg (kilograms)
  - lb (pounds)
  - g (grams)
  - oz (ounces)

- Force
  - N (Newtons)
  - lbf (pound-force)

- Pressure
  - Pa (Pascal)
  - psi (pounds per square inch)

## License

MIT License 