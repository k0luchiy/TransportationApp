find_package(Qt6 REQUIRED COMPONENTS QuickTest)

add_executable(UserModelsTest
    tst_usermodelstest.cpp
)

add_test(NAME UserModelsTest COMMAND UserModelsTest)

target_link_libraries(UserModelsTest
    PRIVATE Qt::Test
    PRIVATE Qt6::Sql
    PRIVATE ComponentsClassesLib
)

add_executable(UserTest
    tst_usertest.cpp
    tst_usertest.qml
)

#qt_add_qml_module(UserTest
#    URI UserTest
#    VERSION 1.0
#    QML_FILES tst_usertest.qml
#)

add_test(NAME UserTest COMMAND UserTest)

target_link_libraries(UserTest
    PRIVATE Qt::Test
    PRIVATE Qt6::Quick
    PRIVATE Qt6::QuickTest
    #PRIVATE UserModelsLib
    PRIVATE ComponentsClassesLib
)
