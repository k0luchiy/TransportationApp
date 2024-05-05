qt_add_library(ButtonsLib STATIC)

set_target_properties(ButtonsLib PROPERTIES AUTOMOC ON)
target_link_libraries(ButtonsLib
    PRIVATE Qt6::Quick
)

list(
    APPEND
    MODULE_QML_FILES
    ButtonSizes.qml
)

set_source_files_properties(${MODULE_QML_FILES} PROPERTIES
    QT_QML_SINGLETON_TYPE  TRUE
)

qt_add_qml_module(
    ButtonsLib
    URI Buttons
    VERSION 1.0
    RESOURCE_PREFIX /TransportationApp.com/qml
    QML_FILES Button.qml
    QML_FILES ${MODULE_QML_FILES}
    QML_FILES PrimaryButton.qml
    QML_FILES SecondaryButton.qml
    QML_FILES IconButton.qml
)


#qt_add_qml_module(
#    ButtonsLib
#    URI Buttons
#    VERSION 1.0
#    QML_FILES Button.qml
#    QML_FILES ButtonSize.qml
#    QML_FILES ButtonSizes.qml
#)


