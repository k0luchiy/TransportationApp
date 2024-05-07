import QtQuick 2.15
import Qt5Compat.GraphicalEffects

import Colors

Rectangle {
    id: buttonRoot
    property color bgColor : Themes.colors.elementary.transparent
    property color iconColor : Themes.colors.neutral.neutral950
    property url iconSource : "qrc:/assets/icons/Outline/filter.svg"
    property int iconSize : 15

    signal clicked()

    color: bgColor
    width: 25
    height: 25
    opacity: mouseArea.containsMouse ? 0.85 : 1

    Image {
        id: icon
        anchors.verticalCenter: parent.verticalCenter
        sourceSize.height: buttonRoot.iconSize
        sourceSize.width: buttonRoot.iconSize
        source: buttonRoot.iconSource
        anchors.horizontalCenter: parent.horizontalCenter

        ColorOverlay {
            anchors.fill: icon
            source: icon
            color: buttonRoot.iconColor
        }
    }

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            buttonRoot.clicked();
        }
        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
    }

}
