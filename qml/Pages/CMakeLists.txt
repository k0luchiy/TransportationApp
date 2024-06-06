
qt_add_library(PagesLib STATIC)

set_target_properties(PagesLib PROPERTIES AUTOMOC ON)
target_link_libraries(PagesLib
    PRIVATE Qt6::Quick
    PRIVATE ColorsLibplugin
    PRIVATE ButtonsLibplugin
    PRIVATE InputFieldsLibplugin
    PRIVATE TabControlsLibplugin
    PRIVATE TablesLibplugin
    PRIVATE TabsLibplugin
)

qt_add_qml_module(PagesLib
    URI Pages
    VERSION 1.0
    RESOURCE_PREFIX /TransportationApp.com/qml
    QML_FILES OrderPage.qml
    QML_FILES CarPage.qml
    QML_FILES LoginPage.qml
    QML_FILES MainPage.qml
    QML_FILES SignUpPage.qml
)
