qt_add_library(
    ModelsLib STATIC
    abstractsqlquerymodel.h abstractsqlquerymodel.cpp
    usermodel.h usermodel.cpp
    rolesmodel.h rolesmodel.cpp
    drivermodel.h drivermodel.cpp
    carsmodel.h carsmodel.cpp
    orderstatusmodel.h orderstatusmodel.cpp
    drivingcategoriesmodel.h drivingcategoriesmodel.cpp
    ordersmodel.h ordersmodel.cpp
)


target_link_libraries(
    ModelsLib 
    PRIVATE Qt6::Core
    PRIVATE Qt6::Sql
)

target_include_directories(
    ModelsLib 
    INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
)
