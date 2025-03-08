# define the compiler to use
CXX 		= g++
CC 			= gcc
LD 			= $(CXX)

# define any compile-time flags
CXXFLAGS	= -Wfatal-errors -Wall -Wextra -Wconversion -Wshadow
CFLAGS		= $(CXXFLAGS)
LFLAGS 		= $(CXXFLAGS)

# Final binary
BIN			= main

# define output directory
OUTPUT		= bin

# define source directory
SRC			= src

# define include directory
INCLUDE		= include

# define lib directory
#LIB		= lib

# define object directory
OBJ			= build

LIBRARIES	= -lglfw -lGL -lX11 -lpthread -lXrandr -lXi -ldl
SOURCEDIRS	:= $(shell find $(SRC) -type d)
INCLUDEDIRS	:= $(shell find $(INCLUDE) -type d)
#LIBDIRS	:= $(shell find $(LIB) -type d)

# define any directories containing header files other than /usr/include
INCLUDES	:= $(patsubst %,-I%, $(INCLUDEDIRS:%/=%))

# define the local libs
#LIBS		:= $(patsubst %,-L%, $(LIBDIRS:%/=%))

# define the source files
C_SOURCES	:= $(wildcard $(patsubst %,%/*.c, $(SOURCEDIRS)))
CPP_SOURCES	:= $(wildcard $(patsubst %,%/*.cpp, $(SOURCEDIRS)))

# define the object files
C_OBJECTS	:= $(C_SOURCES:$(SRC)/%.c=$(OBJ)/%.o)
CPP_OBJECTS	:= $(CPP_SOURCES:$(SRC)/%.cpp=$(OBJ)/%.o)

# define the dependency files
C_DEPS		:= $(C_OBJECTS:%.o=%.d)
CPP_DEPS	:= $(CPP_OBJECTS:%.o=%.d)

# define some utilities
RM 			= rm -f
RMD 		= rm -rf
MD			= mkdir -p


#
# Makefile targets start from here
#

# Default target named after the binary.
.SILENT:
$(BIN) : $(OUTPUT)/$(BIN)

# Actual target of the binary - depends on all .o files.
$(OUTPUT)/$(BIN) : $(C_OBJECTS) $(CPP_OBJECTS)
	$(MD) $(@D)
	@echo "Linking"
	$(LD) $(LFLAGS) $(INCLUDES) -o $@ $^ $(LIBS) $(LIBRARIES)
	@echo "Done"

# Include all .d files
-include $(C_DEPS) $(CPP_DEPS)

$(C_OBJECTS): $(C_SOURCES)
	$(MD) $(@D)
	@echo "Compiling $<"
	$(CC) $(CFLAGS) $(INCLUDES) -MMD -c $< -o $@

$(CPP_OBJECTS): $(CPP_SOURCES)
	$(MD) $(@D)
	@echo "Compiling $<"
	$(CXX) $(CXXFLAGS) $(INCLUDES) -MMD -c $< -o $@

.PHONY: clean
clean:
	$(RMD) $(OUTPUT) $(OBJ)
