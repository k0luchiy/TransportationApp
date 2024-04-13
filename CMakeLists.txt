cmake_minimum_required(VERSION 3.16)

project(TransportationApp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Sql Test)
#find_package(QT NAMES Qt5 Qt6 CONFIG REQUIRED COMPONENTS Quick Sql Test)
#find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Quick Sql Test)

enable_testing(true)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(TransportationApp
    main.cpp
)

qt_add_qml_module(TransportationApp
    URI TransportationApp
    VERSION 1.0
    QML_FILES Main.qml
)

add_subdirectory(qml)
add_subdirectory(src)
add_subdirectory(tests)


# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(TransportationApp PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appTransportationApp
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(TransportationApp
    PRIVATE Qt6::Quick
    PRIVATE Qt6::Sql
    PRIVATE Qt::Test
    PRIVATE databaseLib
    PRIVATE userModels
)

include(GNUInstallDirs)
install(TARGETS TransportationApp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
