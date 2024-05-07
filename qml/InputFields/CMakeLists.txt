
qt_add_library(InputFieldsLib STATIC)

set_target_properties(InputFieldsLib PROPERTIES AUTOMOC ON)
target_link_libraries(InputFieldsLib
    PRIVATE Qt6::Quick
    PRIVATE ColorsLibplugin
    PRIVATE ButtonsLibplugin
)

qt_add_qml_module(InputFieldsLib
    URI InputFields
    VERSION 1.0
    RESOURCE_PREFIX /TransportationApp.com/qml
    QML_FILES TextInputField.qml
)
