import QtQuick 2.15
// Basic because of customization
import QtQuick.Controls.Basic

import Colors
import Buttons

ComboBox {
    id: comboBox
    height: 45
    width: 200
    enabled: true

    property color bgColor :
        comboBox.enabled ? Themes.colors.neutral.neutral0 :
            Themes.colors.neutral.neutral100
    property color selectedColor: Themes.colors.neutral.neutral100
    property color contentColor: Themes.colors.neutral.neutral600
    property color borderColor : Themes.colors.neutral.neutral100
    property int borderSize : 1
    property int fontSize : 12
    property int itemHeight : 30
    property int itemCount : 3


    background: Rectangle {
        anchors.fill: parent
        color: comboBox.bgColor
        border.width: comboBox.borderSize
        border.color: comboBox.borderColor
        radius: 5
    }

    contentItem: Text {
            anchors.fill: parent
            text: comboBox.displayText
            color: comboBox.contentColor
            font.pointSize: comboBox.fontSize
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.rightMargin: 25
            anchors.leftMargin: 5
            elide: Text.ElideRight
    }

    indicator : IconButton{
        id: iconBtn
        width: 15
        height: 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 5
        iconSource: "qrc:/assets/icons/Outline/chevron-down.svg"
        iconColor: comboBox.contentColor
        iconSize: 15
        onClicked : {
            if(!comboBox.popup.visible){
                comboBox.popup.open()
            }
            else{
                comboBox.popup.close()
            }
        }
    }

    delegate: ItemDelegate {
            id: delegate

            required property var model
            required property int index

            height: comboBox.itemHeight
            width: comboBox.width
            contentItem: Rectangle{
                anchors.fill: parent
                color: highlighted ? comboBox.selectedColor : comboBox.bgColor

                Text {
                    anchors.fill: parent
                    text: delegate.model[comboBox.textRole]
                    color: comboBox.contentColor
                    font.pointSize: 10
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.rightMargin: 25
                    anchors.leftMargin: 5
                }
            }
            highlighted: comboBox.highlightedIndex === index
        }

    popup: Popup {
            y: comboBox.height - 1
            width: comboBox.width
            height: comboBox.itemHeight * comboBox.itemCount
            padding: 1

            contentItem: ListView {
                boundsMovement: Flickable.StopAtBounds
                boundsBehavior: Flickable.StopAtBounds
                clip: true
                model: comboBox.popup.visible ? comboBox.delegateModel : null
                currentIndex: comboBox.highlightedIndex

                ScrollIndicator.vertical: ScrollIndicator { }
            }

            background: Rectangle {
                anchors.fill: parent
                color: comboBox.bgColor
                border.color: comboBox.borderColor
                radius: 5
            }
        }

}


