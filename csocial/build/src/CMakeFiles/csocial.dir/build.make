# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/user/Bureau/atmproject/mycuda01/cppmysql1/csocial

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/user/Bureau/atmproject/mycuda01/cppmysql1/csocial/build

# Include any dependencies generated for this target.
include src/CMakeFiles/csocial.dir/depend.make

# Include the progress variables for this target.
include src/CMakeFiles/csocial.dir/progress.make

# Include the compile flags for this target's objects.
include src/CMakeFiles/csocial.dir/flags.make

src/CMakeFiles/csocial.dir/main.o: src/CMakeFiles/csocial.dir/flags.make
src/CMakeFiles/csocial.dir/main.o: ../src/main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/user/Bureau/atmproject/mycuda01/cppmysql1/csocial/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object src/CMakeFiles/csocial.dir/main.o"
	cd /home/user/Bureau/atmproject/mycuda01/cppmysql1/csocial/build/src && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/csocial.dir/main.o -c /home/user/Bureau/atmproject/mycuda01/cppmysql1/csocial/src/main.cpp

src/CMakeFiles/csocial.dir/main.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/csocial.dir/main.i"
	cd /home/user/Bureau/atmproject/mycuda01/cppmysql1/csocial/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/user/Bureau/atmproject/mycuda01/cppmysql1/csocial/src/main.cpp > CMakeFiles/csocial.dir/main.i

src/CMakeFiles/csocial.dir/main.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/csocial.dir/main.s"
	cd /home/user/Bureau/atmproject/mycuda01/cppmysql1/csocial/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/user/Bureau/atmproject/mycuda01/cppmysql1/csocial/src/main.cpp -o CMakeFiles/csocial.dir/main.s

# Object files for target csocial
csocial_OBJECTS = \
"CMakeFiles/csocial.dir/main.o"

# External object files for target csocial
csocial_EXTERNAL_OBJECTS =

src/csocial: src/CMakeFiles/csocial.dir/main.o
src/csocial: src/CMakeFiles/csocial.dir/build.make
src/csocial: src/liblibserver.a
src/csocial: src/infrastructure/liblibidgenerator.a
src/csocial: src/infrastructure/liblibstudentcontroller.a
src/csocial: src/infrastructure/liblibstudentrepository.a
src/csocial: src/domain/liblibstudent.a
src/csocial: src/CMakeFiles/csocial.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/user/Bureau/atmproject/mycuda01/cppmysql1/csocial/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable csocial"
	cd /home/user/Bureau/atmproject/mycuda01/cppmysql1/csocial/build/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/csocial.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/CMakeFiles/csocial.dir/build: src/csocial

.PHONY : src/CMakeFiles/csocial.dir/build

src/CMakeFiles/csocial.dir/clean:
	cd /home/user/Bureau/atmproject/mycuda01/cppmysql1/csocial/build/src && $(CMAKE_COMMAND) -P CMakeFiles/csocial.dir/cmake_clean.cmake
.PHONY : src/CMakeFiles/csocial.dir/clean

src/CMakeFiles/csocial.dir/depend:
	cd /home/user/Bureau/atmproject/mycuda01/cppmysql1/csocial/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/user/Bureau/atmproject/mycuda01/cppmysql1/csocial /home/user/Bureau/atmproject/mycuda01/cppmysql1/csocial/src /home/user/Bureau/atmproject/mycuda01/cppmysql1/csocial/build /home/user/Bureau/atmproject/mycuda01/cppmysql1/csocial/build/src /home/user/Bureau/atmproject/mycuda01/cppmysql1/csocial/build/src/CMakeFiles/csocial.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/CMakeFiles/csocial.dir/depend

