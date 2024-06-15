import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

import Colors
import Buttons

Popup {
    property color bgColor : Themes.colors.neutral.neutral0
    property color borderColor : Themes.colors.neutral.neutral0
    property color titleColor : Themes.colors.neutral.neutral950
    property color contentColor : Themes.colors.neutral.neutral950

    property string titleText : qsTr("About program")
    property int borderWidth : 1
    property int titleSize : 18
    property int fontSize : 12

    id: popupRoot
    height: 180
    width: 450

    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    background: Rectangle {
        id: filterRec
        anchors.fill: parent
        color: popupRoot.bgColor
        border.width: popupRoot.borderWidth
        border.color: popupRoot.borderColor
        radius: 10
    }

    ColumnLayout{
        anchors.fill: parent

        RowLayout{
            Layout.preferredHeight: 30
            Layout.fillWidth: true

            Text{
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                font.pointSize: popupRoot.titleSize
                color: popupRoot.titleColor
                text: popupRoot.titleText
            }
            IconButton{
                iconSize: 25
                iconColor: popupRoot.titleColor
                iconSource: "qrc:/assets/icons/Outline/close.svg"
                onClicked: {
                    popupRoot.close()
                }
            }
        }

        RowLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 20

            IconButton{
                Layout.preferredHeight: 60
                Layout.preferredWidth: 60
                iconSize: 60
                iconColor: popupRoot.contentColor
                iconSource: "qrc:/assets/icons/Essentials/cat_icon.png"
            }

            ColumnLayout{
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    font.pointSize: popupRoot.fontSize
                    color: popupRoot.contentColor
                    text: qsTr("Application created as diploma project and designed for transportation managment.\nDeveloper: Osipov Anton - <a href='https://github.com/k0luchiy'>github.com/k0luchiy</a>") //github.com/k0luchiy")
                    wrapMode: Text.WordWrap
                    textFormat: Text.MarkdownText
                    verticalAlignment: Text.AlignVCenter
                    renderType: Text.NativeRendering
                    MouseArea {
                        anchors.fill: parent
                        onClicked: Qt.openUrlExternally("https://github.com/k0luchiy")
                    }
                }
            }
        }

    }
}
