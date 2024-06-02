qt_add_library(NotificationsLib STATIC)

set_target_properties(NotificationsLib PROPERTIES AUTOMOC ON)
target_link_libraries(NotificationsLib
    PRIVATE Qt6::Quick
    PRIVATE ColorsLibplugin
    PRIVATE ButtonsLibplugin
)

list(
    APPEND
    MODULE_QML_FILES
    NotificationTypes.qml
)

set_source_files_properties(${MODULE_QML_FILES} PROPERTIES
    QT_QML_SINGLETON_TYPE  TRUE
)

qt_add_qml_module(
    NotificationsLib
    URI Notifications
    VERSION 1.0
    RESOURCE_PREFIX /TransportationApp.com/qml
    QML_FILES ${MODULE_QML_FILES}
    QML_FILES Notification.qml
    QML_FILES NotificationManager.qml
)


