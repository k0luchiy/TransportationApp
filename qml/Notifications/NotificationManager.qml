import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    id: manager
    width: 500
    height: 480

    property var notifications: []

    ListView {
        id: listView
        anchors.fill: parent
        spacing: 10
        model: manager.notifications

        delegate: Notification {
            notificationType: modelData.notificationType
            message: modelData.message
            duration: modelData.duration
            onDismissed: {
                manager.notifications.splice(index, 1)
                //listView.model = notifications;
            }
        }
    }


    function showNotification(notificationType, message, duration = 2000) {
        manager.notifications.push({
           notificationType: notificationType,
           message: message,
           duration: duration
       });
        listView.model = manager.notifications;
    }
}
