
qt_add_library(PopupsLib STATIC)

set_target_properties(PopupsLib PROPERTIES AUTOMOC ON)
target_link_libraries(PopupsLib
    PRIVATE Qt6::Quick
    PRIVATE ColorsLibplugin
    PRIVATE ButtonsLibplugin
    PRIVATE InputFieldsLibplugin
)

qt_add_qml_module(PopupsLib
    URI Popups
    VERSION 1.0
    RESOURCE_PREFIX /TransportationApp.com/qml
    QML_FILES Settings.qml
    QML_FILES AboutPopup.qml
)
