import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import Colors

Rectangle {
    property url iconSource:  "qrc:/assets/icons/Outline/switch-vertical.svg"
    property color bgColor: Themes.colors.neutral.neutral50
    property color contentColor: Themes.colors.neutral.neutral700
    property bool iconVisible : true
    property string text : "Id"
    property int fontSize : 9
    property int iconSize : 10
    property bool enabled : true

    signal clicked

    id: headerCellRoot
    width: 100
    height: 40
    color: headerCellRoot.bgColor
    opacity: mouseArea.containsMouse ? 0.8 : 1

    RowLayout {
        anchors.fill: parent
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        spacing: 3

        Text {
            text: headerCellRoot.text
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: headerCellRoot.contentColor
            Layout.fillHeight: true
            Layout.fillWidth: false
            font.pointSize: headerCellRoot.fontSize
        }

        Image {
            id: icon
            Layout.preferredWidth: 10
            Layout.preferredHeight: 10
            sourceSize.height: 10
            sourceSize.width: 10
            source: headerCellRoot.iconSource
            visible: headerCellRoot.iconVisible


            ColorOverlay {
                anchors.fill: parent
                source: icon
                color: headerCellRoot.contentColor
                visible: headerCellRoot.iconVisible
            }
        }

        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }


    MouseArea{
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        enabled: headerCellRoot.enabled
        onClicked: {
            headerCellRoot.clicked();
        }
        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
    }
}

