import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

import Colors

Rectangle {

    id: cellRoot
    width: 100
    height: 40
    color: cellRoot.bgColor

    signal clicked

    property color bgColor: Themes.colors.elementary.transparent
    property color contentColor: Themes.colors.neutral.neutral700
    property string text : "Id"
    property int fontSize : 9
    property bool enabled : false

    RowLayout {
        anchors.fill: parent
        anchors.rightMargin: 5
        anchors.leftMargin: 5

        Text {
            id: cellContent
            text: cellRoot.text
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            color: cellRoot.contentColor
            Layout.fillHeight: true
            Layout.fillWidth: true
            font.pointSize: cellRoot.fontSize
        }
    }

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        enabled: cellRoot.enabled
        onClicked: {
            cellRoot.clicked();
        }
        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
    }

}

