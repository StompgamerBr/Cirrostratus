CC = gcc
CXX = g++

SRC_PATH = src
BUILD_PATH = build
BIN_PATH = $(BUILD_PATH)/bin

COMPILE_FLAGS = -Wall -ggdb -O3
LINK_FLAGS = -lglfw3 -lopengl32 -lglu32 -lgdi32

glfw = d:/external/glfw-3.1
glfw_inc = $(glfw)/include
glfw_lib = $(glfw)/lib64

INCLUDES = -I$(glfw_inc) -I$(glad_inc)
LIBRARIES = -L$(glfw_lib)

cpp_files = main.cpp
objects = $(cpp_files:.cpp=.o)
headers =

.PHONY: default_target
default_target: release

.PHONY: release
release: dirs
	@$(MAKE) all

.PHONY: dirs
dirs:
	@echo "Creating directories"
	@mkdir -p $(dir $(OBJECTS))
	@mkdir -p $(BIN_PATH)

.PHONY: clean
clean:
	@echo "Deleting $(BIN_NAME) symlink"
	@$(RM) $(BIN_NAME)
	@echo "Deleting directories"
	@$(RM) -r $(BUILD_PATH)
	@$(RM) -r $(BIN_PATH)

# checks the executable and symlinks to the output
.PHONY: all
all: $(BIN_PATH)/$(BIN_NAME)
	@echo "Making symlink: $(BIN_NAME) -> $<"
	@$(RM) $(BIN_NAME)
	@ln -s $(BIN_PATH)/$(BIN_NAME) $(BIN_NAME)

# Creation of the executable
$(BIN_PATH)/$(BIN_NAME): $(OBJECTS)
	@echo "Linking: $@"
	$(CXX) $(OBJECTS) -o $@ ${LIBS}

# Add dependency files, if they exist
-include $(DEPS)

# Source file rules
# After the first compilation they will be joined with the rules from the
# dependency files to provide header dependencies
$(BUILD_PATH)/%.o: $(SRC_PATH)/%.$(SRC_EXT)
	@echo "Compiling: $< -> $@"

	$(CXX) $(COMPILE_FLAGS) $(INCLUDES) -MP -MMD -c $< -o $@ $(LINK_FLAGS)


