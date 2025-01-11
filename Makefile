CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -Werror -I$(SRC_DIR)/headers -I/usr/local/include \
           -DINSTALL_PATH=\"$(INSTALL_PATH)\"
LDFLAGS = -L/usr/local/lib -lsqlite3

# Directories
SRC_DIR = src
TEST_DIR = test
BUILD_DIR = build
BIN_DIR = bin
DATA_DIR = data

# Source files
SRCS = $(wildcard $(SRC_DIR)/*.cpp)
TEST_SRCS = $(wildcard $(TEST_DIR)/*.cpp)
MAIN_SRC = $(SRC_DIR)/main.cpp
LIB_SRCS = $(filter-out $(MAIN_SRC),$(SRCS))

# Object files
MAIN_OBJ = $(MAIN_SRC:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o)
LIB_OBJS = $(LIB_SRCS:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o)
TEST_OBJS = $(TEST_SRCS:$(TEST_DIR)/%.cpp=$(BUILD_DIR)/%.o)

# Targets
TARGET = $(BIN_DIR)/unit_converter
TEST_TARGET = $(BIN_DIR)/run_tests

# Installation path
INSTALL_PATH = /usr/local/bin

# Create build directory if it doesn't exist
$(shell mkdir -p $(BUILD_DIR) $(BIN_DIR))

.PHONY: all clean test install uninstall clean-obj init-db

all: init-db $(TARGET) clean-obj

$(TARGET): $(MAIN_OBJ) $(LIB_OBJS)
	@echo "Linking $@..."
	@$(CXX) $^ -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@echo "Compiling $<..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: $(TEST_DIR)/%.cpp
	@echo "Compiling $<..."
	@$(CXX) $(CXXFLAGS) -c $< -o $@

test: init-db $(TEST_TARGET)
	@echo "Running tests..."
	@./$(TEST_TARGET)
	@$(MAKE) clean-obj

$(TEST_TARGET): $(TEST_OBJS) $(LIB_OBJS)
	@echo "Linking $@..."
	@$(CXX) $^ -o $@ $(LDFLAGS)

init-db:
	@echo "Initializing databases..."
	@chmod +x $(DATA_DIR)/init_databases.sh
	@$(DATA_DIR)/init_databases.sh

install: $(TARGET)
	@echo "Installing to $(INSTALL_PATH)..."
	@cp $(TARGET) $(INSTALL_PATH)/unit_converter
	@chmod 755 $(INSTALL_PATH)/unit_converter
	@mkdir -p $(INSTALL_PATH)/../share/unit_converter
	@cp -r $(DATA_DIR)/*.db $(INSTALL_PATH)/../share/unit_converter/

uninstall:
	@echo "Uninstalling from $(INSTALL_PATH)..."
	@rm -f $(INSTALL_PATH)/unit_converter
	@rm -rf $(INSTALL_PATH)/../share/unit_converter

clean-obj:
	@echo "Cleaning object files..."
	@rm -f $(BUILD_DIR)/*.o
	@rm -f *.o

clean:
	@echo "Cleaning all build artifacts..."
	@rm -rf $(BUILD_DIR)
	@rm -rf $(BIN_DIR)
	@rm -f *.o
