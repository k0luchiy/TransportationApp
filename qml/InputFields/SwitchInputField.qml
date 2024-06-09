import QtQuick 2.12
import QtQuick.Controls 2.12

import Colors

Switch {
    property color bgColor : Colors.elementary.tranparent
    property color indicatorActiveColor : Themes.colors.primary.primary500
    property color indicatorDefaultColor : Themes.colors.neutral.neutral400
    property color indicatorBorderColor : Themes.colors.neutral.neutral700
    property color circleColor: Colors.elementary.white
    property color textActiveColor : Themes.colors.neutral.neutral900
    property color textDefaultColor : Themes.colors.neutral.neutral900

    property int indicatorBorderWidth : 0
    property int circleSize : 20
    property int fontSize : 12


    id: fieldRoot
    text: qsTr("Switch")

//    background: Rectangle{
//        color: fieldRoot.bgColor
//    }
//
//    anchors.verticalCenter: parent.verticalCenter
//    anchors.horizontalCenter: parent.horizontalCenter
    indicator: Rectangle {
        id: rectangle
        implicitWidth: 48
        implicitHeight: 26
        x: fieldRoot.leftPadding
        y: parent.height / 2 - height / 2

        radius: 13
        color: fieldRoot.checked ? indicatorActiveColor: indicatorDefaultColor
        border.color: indicatorBorderColor
        border.width: indicatorBorderWidth

        // small round point
        Rectangle {
            id : smallRect
            height: circleSize
            width: circleSize
            radius: 100
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 5
            anchors.leftMargin: 3
            color: circleColor
            border.color: indicatorBorderColor
            border.width: indicatorBorderWidth

            // Change the position of the small dot
            NumberAnimation on x{
                to: smallRect.width + 5
                running: fieldRoot.checked ? true : false
                duration: 200
            }

            // Change the position of the small dot
            NumberAnimation on x{
                to: 3
                running: fieldRoot.checked ? false : true
                duration: 200
            }
        }
    }

    // The text to be displayed
    contentItem: Text {
        color: fieldRoot.checked ? textActiveColor : textDefaultColor
        verticalAlignment: Text.AlignVCenter
        anchors.left: indicator.right
        anchors.leftMargin: 5
        text: fieldRoot.text
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: fontSize
    }

}
