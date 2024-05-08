
qt_add_library(TablesLib STATIC)

set_target_properties(TablesLib PROPERTIES AUTOMOC ON)
target_link_libraries(TablesLib
    PRIVATE Qt6::Quick
    PRIVATE ColorsLibplugin
    PRIVATE ButtonsLibplugin
)

qt_add_qml_module(TablesLib
    URI Tables
    VERSION 1.0
    RESOURCE_PREFIX /TransportationApp.com/qml
)
