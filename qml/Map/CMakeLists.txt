
qt_add_library(MapLib STATIC)

set_target_properties(MapLib PROPERTIES AUTOMOC ON)
target_link_libraries(MapLib
    PRIVATE Qt6::Quick
    PRIVATE Qt6::Positioning
    PRIVATE Qt6::Location
    PRIVATE ColorsLibplugin
    PRIVATE ButtonsLibplugin
)

qt_add_qml_module(MapLib
    URI Map
    VERSION 1.0
    RESOURCE_PREFIX /TransportationApp.com/qml
    QML_FILES MapComponent.qml
)
