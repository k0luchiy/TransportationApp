qt_add_library(databaseLib STATIC
    database.h database.cpp
)

target_link_libraries(databaseLib PRIVATE Qt6::Core PRIVATE Qt6::Sql)
target_include_directories(databaseLib INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})


