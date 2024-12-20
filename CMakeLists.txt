cmake_minimum_required(VERSION 3.20)

# Set the project name and version
project(MyProject VERSION 1.0.0 LANGUAGES CXX)

# Specify the C++ standard
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)


set(SYS_COMPILE_FLAGS 
    -Wall
    -Wextra
    -Werror
    -Wshadow
    -pedantic-errors
    -Wpedantic 
    -Wconversion
    -Wsign-conversion
    -Wcast-qual
    -Wcast-align
    -Wnon-virtual-dtor
    -Woverloaded-virtual 
    -Wdouble-promotion
    -Wunused 
    -Wold-style-cast
    -fstack-protector-strong
    -m32
)

set(SYS_LINKER_FLAGS 
    -m32
)

find_package(Threads REQUIRED)
add_library(threads STATIC thread.cpp)
target_compile_options(threads PRIVATE ${SYS_COMPILE_FLAGS})
target_link_options(threads PRIVATE ${SYS_LINKER_FLAGS})
target_link_libraries(threads PRIVATE Threads::Threads)


#################################################################

add_executable(${PROJECT_NAME} main.cpp)
target_compile_options(${PROJECT_NAME} PRIVATE ${SYS_COMPILE_FLAGS})
target_link_libraries(${PROJECT_NAME} PRIVATE threads)
target_link_options(${PROJECT_NAME} PRIVATE ${SYS_LINKER_FLAGS})

#################################################################

Include(FetchContent)
FetchContent_Declare(
  Catch2
  GIT_REPOSITORY https://github.com/catchorg/Catch2.git
  GIT_TAG        v3.7.1
)

FetchContent_MakeAvailable(Catch2)

add_executable(tests tests/t_thread.cpp)
target_link_libraries(tests PRIVATE Catch2::Catch2WithMain)
target_link_libraries(tests PRIVATE threads)

include(CTest)
include(Catch)

catch_discover_tests(tests)
