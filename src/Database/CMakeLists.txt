
find_package(Qt6 6.5 REQUIRED COMPONENTS Sql)

qt_add_library(databaseLib STATIC
    database.h database.cpp
)

add_subdirectory(tests)

target_link_libraries(databaseLib PRIVATE Qt6::Core PRIVATE Qt6::Sql)
target_include_directories(databaseLib INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})


