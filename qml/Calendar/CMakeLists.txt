
qt_add_library(CalendarLib STATIC)

set_target_properties(CalendarLib PROPERTIES AUTOMOC ON)
target_link_libraries(CalendarLib
    PRIVATE Qt6::Quick
    PRIVATE ColorsLibplugin
    PRIVATE ButtonsLibplugin
    PRIVATE UtilsLibplugin
)

qt_add_qml_module(CalendarLib
    URI Calendar
    VERSION 1.0
    RESOURCE_PREFIX /TransportationApp.com/qml
    QML_FILES Calendar.qml
    QML_FILES DateRangePicker.qml
    QML_FILES AdditionalButton.qml
    QML_FILES DatePicker.qml
)
