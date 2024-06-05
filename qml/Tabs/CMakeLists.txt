
qt_add_library(TabsLib STATIC)

set_target_properties(TabsLib PROPERTIES AUTOMOC ON)
target_link_libraries(TabsLib
    PRIVATE Qt6::Quick
    PRIVATE ColorsLibplugin
    PRIVATE ButtonsLibplugin
    PRIVATE InputFieldsLibplugin
    PRIVATE TabControlsLibplugin
    PRIVATE TablesLibplugin
    PRIVATE UtilsLibplugin
    PRIVATE CalendarLibplugin
)

qt_add_qml_module(TabsLib
    URI Tabs
    VERSION 1.0
    RESOURCE_PREFIX /TransportationApp.com/qml
    QML_FILES OrderTableTab.qml
    QML_FILES OrderInfoTab.qml
    QML_FILES CarTableTab.qml
    QML_FILES CarInfoTab.qml
)
