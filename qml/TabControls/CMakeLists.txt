
qt_add_library(TabControlsLib STATIC)

set_target_properties(TabControlsLib PROPERTIES AUTOMOC ON)
target_link_libraries(TabControlsLib
    PRIVATE Qt6::Quick
    PRIVATE ColorsLibplugin
    PRIVATE ButtonsLibplugin
)

qt_add_qml_module(TabControlsLib
    URI TabControls
    VERSION 1.0
    RESOURCE_PREFIX /TransportationApp.com/qml
    QML_FILES LeftMenuTabButton.qml
    QML_FILES LeftMenuTabPannel.qml
)
