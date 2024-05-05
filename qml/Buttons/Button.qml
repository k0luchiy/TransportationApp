import QtQuick 2.15
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import Colors

Rectangle {
    property var buttonSize : ButtonSizes.largeSize
    property color bgColor : Themes.colors.primary.primary500
    property color contentColor : Themes.colors.elementary.white
    property string btnText : "Button"
    property bool iconLeftVisible : true
    property bool iconRightVisible : false
    property url iconLeftSource : "qrc:/assets/icons/Outline/filter.svg"
    property url iconRightSource : "qrc:/assets/icons/Outline/filter.svg"
    property int borderSize : 0

    signal clicked()

    id: buttonRoot
    color: buttonRoot.bgColor
    width: buttonRoot.buttonSize.width
    height: buttonRoot.buttonSize.height
    radius: buttonRoot.buttonSize.radius
    border.width: buttonRoot.borderSize
    border.color: buttonRoot.contentColor

    RowLayout{
        anchors.fill: parent
        spacing: 5

        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        Image {
            id: btnLeftIcon
            Layout.preferredHeight: buttonRoot.buttonSize.iconSize
            Layout.preferredWidth: buttonRoot.buttonSize.iconSize
            sourceSize.height: buttonRoot.buttonSize.iconSize
            sourceSize.width: buttonRoot.buttonSize.iconSize
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            visible: buttonRoot.iconLeftVisible
            source: buttonRoot.iconLeftSource

            ColorOverlay {
                anchors.fill: btnLeftIcon
                source: btnLeftIcon
                color: buttonRoot.contentColor
                visible: buttonRoot.iconLeftVisible
            }
        }

        Text{
            font.pointSize: buttonRoot.buttonSize.fontSize
            color: buttonRoot.contentColor
            text: buttonRoot.btnText
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }


        Image {
            id: btnRightIcon
            Layout.preferredHeight: buttonRoot.buttonSize.iconSize
            Layout.preferredWidth: buttonRoot.buttonSize.iconSize
            sourceSize.height: buttonRoot.buttonSize.iconSize
            sourceSize.width: buttonRoot.buttonSize.iconSize
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            visible: buttonRoot.iconRightVisible
            source: buttonRoot.iconRightSource

            ColorOverlay {
                anchors.fill: btnRightIcon
                source: btnRightIcon
                color: buttonRoot.contentColor
                visible: buttonRoot.iconRightVisible
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
        onClicked: {
            buttonRoot.clicked();
        }
        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
    }
}
