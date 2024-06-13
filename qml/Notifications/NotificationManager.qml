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
        anchors.margins: 10
        verticalLayoutDirection: ListView.BottomToTop
        orientation: ListView.Vertical
        spacing: 10
        model: manager.notifications

        delegate: Notification {
            anchors.right: parent.right
            anchors.rightMargin: 0
            enabled: true

            notificationType: modelData.notificationType
            message: modelData.message
            duration: modelData.duration
            onDismissed: {
                manager.notifications.splice(index, 1)
                listView.model = manager.notifications;
            }
        }
    }


    function showNotification(notificationType, message, duration = 3500) {
        manager.notifications.push({
           notificationType: notificationType,
           message: message,
           duration: duration
       });
        listView.model = manager.notifications;
    }
}
