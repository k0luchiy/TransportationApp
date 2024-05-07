import QtQuick 2.15
import QtQuick.Layouts

import Colors
import Buttons

Item {
    property color titleColor : Themes.colors.neutral.neutral950
    property color contentColor : Themes.colors.neutral.neutral600
    property color placeholderColor : Themes.colors.neutral.neutral500
    property color bgColor : Themes.colors.elementary.transparent
    property color borderColor : Themes.colors.neutral.neutral100
    property string title : "Title:"
    property string placeholderText : "Placeholder"
    property bool leftIconVisible : true
    property bool rightIconVisible : true
    property url iconLeftSource : "qrc:/assets/icons/Outline/filter.svg"
    property url iconRightSource : "qrc:/assets/icons/Outline/filter.svg"
    property int titleFontSize : 12
    property int contentFontSize : 12


    signal textChanged
    signal editingFinished(int text)


    id: fieldRoot
    width: 280
    height: 70

    ColumnLayout{
        anchors.fill: fieldRoot
        RowLayout{
            //Layout.preferredHeight: 20
            Layout.fillWidth: true
            Text{
                text : fieldRoot.title
                verticalAlignment: Text.AlignVCenter
                font.pointSize : fieldRoot.titleFontSize
                color: fieldRoot.titleColor
            }
        }

        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: fieldRoot.bgColor
            border.width: 1
            border.color: fieldRoot.borderColor
            radius: 5


            RowLayout{
                anchors.fill: parent
                anchors.rightMargin: 5
                anchors.leftMargin: 5


                IconButton{
                    id: leftIcon
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.preferredHeight: 20
                    Layout.preferredWidth: 20
                    iconSize: 20
                    iconColor: fieldRoot.contentColor
                    visible: fieldRoot.leftIconVisible
                    iconSource: fieldRoot.leftIconSource
                }


                TextInput {
                    id: inputField
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: fieldRoot.contentColor
                    font.pointSize : fieldRoot.contentFontSize
                    rightPadding: 5
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    clip: true
                    echoMode: TextInput.Normal
                    onTextChanged: { fieldRoot.textChanged() }

                    Text {
                        text: fieldRoot.placeholderText
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        color: fieldRoot.placeholderColor
                        font.pointSize : fieldRoot.contentFontSize
                        visible: !inputField.text
                    }

                    onEditingFinished: {
                        fieldRoot.editingFinished(text)
                    }
                }

                IconButton{
                    id: rightIcon
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.preferredHeight: 20
                    Layout.preferredWidth: 20
                    iconSize: 20
                    iconColor: fieldRoot.contentColor
                    visible: fieldRoot.rightIconVisible
                    iconSource: fieldRoot.rightIconSource
                }
            }
        }

    }
}
