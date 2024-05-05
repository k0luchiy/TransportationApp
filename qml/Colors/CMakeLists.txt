
qt_add_library(ColorsLib STATIC)

set_target_properties(ColorsLib PROPERTIES AUTOMOC ON)
target_link_libraries(ColorsLib PRIVATE Qt6::Quick PRIVATE ColorsLibplugin)

list(APPEND MODULE_QML_FILES Colors.qml Themes.qml)

set_source_files_properties(${MODULE_QML_FILES} PROPERTIES
    QT_QML_SINGLETON_TYPE  TRUE
)

qt_add_qml_module(ColorsLib
    URI Colors
    VERSION 1.0
    RESOURCE_PREFIX /TransportationApp.com/qml
    QML_FILES ${MODULE_QML_FILES}
    #QML_FILES Themes.qml
)
