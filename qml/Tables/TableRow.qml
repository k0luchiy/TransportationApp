import QtQuick 2.15
import QtQuick.Layouts

import Colors

Item {
    property color bgColor : Themes.colors.elementary.transparent
    property color contentColor : Themes.colors.neutral.neutral700
    property color dividerColor : Themes.colors.neutral.neutral200
    property int fontSize : 9
    property var model

    signal clicked

    id : rowRoot
    width: 200
    height: 40

    ColumnLayout{
        anchors.fill: parent
        spacing: 0

        RowLayout {
            id: cell
            Layout.fillWidth: true
            spacing: 0

            Repeater {
                Layout.fillWidth: true
                model: rowRoot.model
                TableCell {
                    Layout.fillWidth: true
                    text: modelData
                }
            }

            TableCell {
                width: 60
                Layout.preferredWidth: 60
                text: ""
            }

        }

        Rectangle{
            Layout.fillWidth: true
            height: 1
            color: rowRoot.dividerColor
        }
    }

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        Layout.fillHeight: true
        Layout.fillWidth: true
        hoverEnabled: true
        enabled: rowRoot.enabled
        onClicked: {
            rowRoot.clicked();
        }
        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
    }
}
