import QtQuick 2.15
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import Colors
import Buttons

Rectangle {
    property var    notificationType//: NotificationTypes.success
    property int    titleFontSize   : 12
    property int    fontSize        : 10
    property int    iconSize        : 20
    property color  bgColor         : Themes.colors.neutral.neutral0
    property color  contentColor    : Themes.colors.neutral.neutral900
    property color  titleColor      : Themes.colors.neutral.neutral950
    property string titleText       //: notificationRoot.notificationType.titleText
    property string message         : "Success notification content"
    property int    duration        : 2000

    signal dismissed

    id: notificationRoot
    height: 70
    width: 440
    radius: 5
    border.width: 1
    border.color: Themes.colors.neutral.neutral100
    color: notificationRoot.bgColor

    RowLayout{
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Image {
            fillMode: Image.PreserveAspectFit
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.preferredHeight: notificationRoot.iconSize
            Layout.preferredWidth: notificationRoot.iconSize
            sourceSize.height: notificationRoot.iconSize
            sourceSize.width: notificationRoot.iconSize
            source: notificationRoot.notificationType.iconSource
        }

        ColumnLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            RowLayout{
                Layout.preferredHeight: 20
                Layout.fillWidth: true
                Text{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    font.pointSize: notificationRoot.titleFontSize
                    color: notificationRoot.titleColor
                    text: notificationRoot.notificationType.titleText
                }
                IconButton{
                    Layout.preferredHeight: notificationRoot.iconSize
                    Layout.preferredWidth: notificationRoot.iconSize
                    iconSize: notificationRoot.iconSize
                    iconSource: "qrc:/assets/icons/Outline/close.svg"
                    onClicked: {
                        notificationRoot.dismissed()
                        //notificationRoot.visible = !notificationRoot.visible
                    }
                }
            }
            Text{
                Layout.fillHeight: true
                Layout.fillWidth: true
                font.pointSize: notificationRoot.fontSize
                color: notificationRoot.contentColor
                text: notificationRoot.message
            }
        }
    }

    InnerShadow {
        anchors.fill: notificationRoot
        cached: true
        radius: 0
        samples: 16
        horizontalOffset: 4
        color: notificationRoot.notificationType.typeColor
        source: notificationRoot
    }

    Timer {
        interval: notificationRoot.duration
        running: true
        repeat: false
        onTriggered: notificationRoot.dismissed()
    }
}
