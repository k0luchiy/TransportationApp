find_package(Qt6 REQUIRED COMPONENTS QuickTest)

add_executable(ModelsTest
    tst_modelstest.cpp
)

add_test(NAME ModelsTest COMMAND ModelsTest)

target_link_libraries(ModelsTest
    PRIVATE Qt::Test
    PRIVATE Qt6::Sql
    PRIVATE ModelsLib
)

