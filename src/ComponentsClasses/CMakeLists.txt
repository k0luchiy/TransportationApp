qt_add_library(
    ComponentsClassesLib STATIC
    user.h user.cpp
    order.h order.cpp
    car.h car.cpp

)


target_link_libraries(
    ComponentsClassesLib
    PRIVATE Qt6::Core
    PRIVATE Qt6::Sql
)

target_include_directories(
    ComponentsClassesLib 
    INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
)
