qt_add_library(
    FilterModelsLib STATIC
    carsfiltermodel.h carsfiltermodel.cpp
    driversfiltermodel.h driversfiltermodel.cpp
    ordersfiltermodel.h ordersfiltermodel.cpp
    deliveriesfiltermodel.h deliveriesfiltermodel.cpp
)


target_link_libraries(
    FilterModelsLib 
    PRIVATE Qt6::Core
    PRIVATE Qt6::Sql
    PRIVATE ModelsLib
)

target_include_directories(
    FilterModelsLib 
    INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
)
