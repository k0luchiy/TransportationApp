import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

import Colors

TabButton {
    property int iconSize : 18
    property int fontSize : 12
    property color activeBgColor : Themes.colors.primary.primary600
    property color defaultBgColor : Themes.colors.elementary.transparent//Themes.colors.neutral.neutral50
    property color activeContentColor : Themes.colors.neutral.neutral0
    property color defaultContentColor : Themes.colors.neutral.neutral900
    property bool iconVisible : true
    property url iconSource : "qrc:/assets/icons/Outline/filter.svg"


    id: buttonRoot
    implicitHeight: 40
    implicitWidth: 200
    checked: false

    background: Rectangle{
        anchors.fill: parent
        color: buttonRoot.checked ?
                buttonRoot.activeBgColor : buttonRoot.defaultBgColor
    }


    contentItem:
        Item{
        anchors.fill: parent
        RowLayout{
            anchors.fill: parent
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            spacing: 5

            Image {
                id: icon
                Layout.preferredHeight: buttonRoot.iconSize
                Layout.preferredWidth: buttonRoot.iconSize
                sourceSize.height: buttonRoot.iconSize
                sourceSize.width: buttonRoot.iconSize
                visible: buttonRoot.iconVisible
                source: buttonRoot.iconSource
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                ColorOverlay {
                    anchors.fill: icon
                    source: icon
                    color: buttonRoot.checked ?
                            buttonRoot.activeContentColor : buttonRoot.defaultContentColor
                    visible: buttonRoot.iconVisible
                }
            }

            Text{
                id : btnText
                font.pointSize: buttonRoot.fontSize
                color: buttonRoot.checked ?
                        buttonRoot.activeContentColor : buttonRoot.defaultContentColor
                text: buttonRoot.text
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                clip: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}


