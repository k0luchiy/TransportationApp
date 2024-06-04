
qt_add_library(InputFieldsLib STATIC)

set_target_properties(InputFieldsLib PROPERTIES AUTOMOC ON)
target_link_libraries(InputFieldsLib
    PRIVATE Qt6::Quick
    PRIVATE ColorsLibplugin
    PRIVATE ButtonsLibplugin
    PRIVATE CalendarLibplugin
    PRIVATE UtilsLibplugin
)

qt_add_qml_module(InputFieldsLib
    URI InputFields
    VERSION 1.0
    RESOURCE_PREFIX /TransportationApp.com/qml
    QML_FILES TextInputField.qml
    QML_FILES NumberInputField.qml
    QML_FILES ComboBoxControl.qml
    QML_FILES ComboBoxInputField.qml
    QML_FILES DateInputField.qml
    QML_FILES DateRangeInputField.qml
)
