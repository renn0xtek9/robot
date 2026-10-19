cmake_minimum_required(VERSION 4.4)
project(HardwareInTheLoopHarness VERSION 1.0.0 LANGUAGES CXX DESCRIPTION "Tools for hardware in the loop bench test")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../cmake")
add_executable(hiloworld main.cpp)
