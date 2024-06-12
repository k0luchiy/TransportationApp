import QtQuick
import QtQuick.Controls

import Colors

RadioButton {
    property color activeIndicatorColor : Themes.colors.primary.primary500
    property color textColor : Themes.colors.neutral.neutral900
    property int indicatorCircleSize : 25
    property int indicatorBorderSize : 6
    property int fontSize : 12

    id: btnRoot
    text: qsTr("RadioButton")
    checked: false
    spacing: 5

    indicator: Rectangle {
        implicitWidth: btnRoot.indicatorCircleSize
        implicitHeight: btnRoot.indicatorCircleSize
        x: btnRoot.leftPadding
        y: parent.height / 2 - height / 2
        radius: 100
        border.color: Themes.colors.neutral.neutral300

        Rectangle {
            anchors.fill: parent
            radius: 100
            visible: btnRoot.checked
            color: Colors.elementary.transparent
            border.width: btnRoot.indicatorBorderSize
            border.color: btnRoot.activeIndicatorColor
        }

        MouseArea{
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            focus: true
            activeFocusOnTab: true
            onClicked: {
                btnRoot.checked = !btnRoot.checked
            }
            Keys.onReturnPressed: {
                btnRoot.checked = !btnRoot.checked
            }
            cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
        }
    }

    contentItem: Text {
        verticalAlignment: Text.AlignVCenter
        leftPadding: btnRoot.indicator.width + btnRoot.spacing
        font.pointSize: btnRoot.fontSize
        text: btnRoot.text
        color: btnRoot.textColor
    }
}
