cmake_minimum_required(VERSION 3.16)

project(TransportationApp VERSION 0.1 LANGUAGES CXX)

#set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Sql Positioning Location Test)

enable_testing(true)

qt_standard_project_setup()

#qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(TransportationApp
    main.cpp
)

qt_add_qml_module(TransportationApp
    URI TransportationApp
    VERSION 1.0
    QML_FILES Main.qml
    RESOURCE_PREFIX /TransportationApp.com/qml
    RESOURCES docs/config/Doxyfile
    RESOURCES qrc.qrc
)

add_subdirectory(qml)
add_subdirectory(src)
add_subdirectory(tests)
add_subdirectory(docs)

list(APPEND QML_DIRS "${CMAKE_BINARY_DIR}/qml")
set(
    QML_IMPORT_PATH "${QML_DIRS}"
    CACHE STRING "Qt Creator 4.1 extra qml import paths"
    FORCE
)

#list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
#include(Doxygen)
#Doxygen(src "docs/html")

#find_library(MYSQL_LIBRARY NAMES mysql PATHS "C:\\Program Files\\MySQL\\MySQL Server 8.0\\lib\\libmysql.lib")
##include_directories("C:\\Users\\antos\\Documents\\MySQL Server 8.0\\include")
#target_link_libraries(TransportationApp PRIVATE ${MYSQL_LIBRARY})

##target_link_libraries(TransportationApp PRIVATE "C:\\Program Files\\MySQL\\MySQL Server 8.0\\lib")

#set(MySQL_INCLUDE_DIR "C:/Program Files/MySQL/MySQL Server 8.0/include")
#set(MySQL_LIBRARY_DIR "C:/Program Files/MySQL/MySQL Server 8.0/lib")
#set(MySQL_LIBRARIES "C:/Program Files/MySQL/MySQL Server 8.0/libmysql.dll")

## Find MySQL
#find_path(MySQL_INCLUDE_DIR NAMES mysql.h PATHS ${MySQL_INCLUDE_DIR})
#find_library(MySQL_LIBRARY NAMES mysqlclient PATHS ${MySQL_LIBRARY_DIR})

#if (MySQL_INCLUDE_DIR AND MySQL_LIBRARY)
#    include_directories(${MySQL_INCLUDE_DIR})
#    link_directories(${MySQL_LIBRARY_DIR})
#    set(EXTRA_LIBS ${EXTRA_LIBS} ${MySQL_LIBRARY})
#else()
#    message(FATAL_ERROR "Could not find MySQL")
#endif()


# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(TransportationApp PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appTransportationApp
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    #WIN32_EXECUTABLE TRUE # to show console
)

target_link_libraries(TransportationApp
    PRIVATE Qt6::Quick
    PRIVATE Qt6::Sql
    PRIVATE Qt::Test
    PRIVATE ModelsLib
    PRIVATE FilterModelsLib
    PRIVATE ComponentsClassesLib
    PRIVATE ColorsLibplugin
    PRIVATE ButtonsLibplugin
    PRIVATE InputFieldsLibplugin
    PRIVATE TabControlsLibplugin
    PRIVATE TablesLibplugin
    PRIVATE CalendarLibplugin
    PRIVATE NotificationsLibplugin
    PRIVATE PagesLibplugin
    PRIVATE TabsLibplugin
)

include(GNUInstallDirs)
install(TARGETS TransportationApp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
