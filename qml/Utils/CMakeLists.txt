
qt_add_library(UtilsLib STATIC)

set_target_properties(UtilsLib PROPERTIES AUTOMOC ON)
target_link_libraries(UtilsLib PRIVATE Qt6::Quick)

qt_add_qml_module(UtilsLib
    URI Utils
    VERSION 1.0
    RESOURCE_PREFIX /TransportationApp.com/qml
    QML_FILES DateUtils.js
)
