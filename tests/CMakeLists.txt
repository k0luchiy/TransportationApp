#cmake_minimum_required(VERSION 3.5)

#project(Tests LANGUAGES CXX)

#enable_testing()

#find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Test)
#find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Test)

#set(CMAKE_AUTOUIC ON)
#set(CMAKE_AUTOMOC ON)
#set(CMAKE_AUTORCC ON)

#set(CMAKE_CXX_STANDARD 11)
#set(CMAKE_CXX_STANDARD_REQUIRED ON)

#add_executable(Tests tst_databasetest.cpp)
#add_test(NAME DatabaseTest COMMAND DatabaseTest)

#add_subdirectory("../../src")


#target_link_libraries(Tests
#    PRIVATE Qt${QT_VERSION_MAJOR}::Test
#)



#add_executable(Tests DatabaseTests/tst_databasetest.cpp)
#add_test(NAME DatabaseTest COMMAND DatabaseTest)
#target_link_libraries(Tests PRIVATE Qt::Test PRIVATE Qt6::Sql)







add_subdirectory(DatabaseTests)
add_subdirectory(UserModelsTests)
add_subdirectory(ModelsTests)

