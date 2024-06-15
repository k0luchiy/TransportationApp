qt_add_library(
    ComponentsClassesLib STATIC
    user.h user.cpp
    order.h order.cpp
    car.h car.cpp
    driver.h driver.cpp
    delivery.h delivery.cpp
    deliveryorderlist.h deliveryorderlist.cpp
    settings.h settings.cpp
    translationhandler.h translationhandler.cpp
)

find_package(Qt6 COMPONENTS Core Sql Gui REQUIRED)

target_link_libraries(
    ComponentsClassesLib
    PRIVATE Qt6::Core
    PRIVATE Qt6::Sql
    PRIVATE Qt6::Gui
)

target_include_directories(
    ComponentsClassesLib 
    INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
)
