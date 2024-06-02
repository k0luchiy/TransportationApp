import QtQuick 2.15
import QtQuick.Layouts

import Colors
import Buttons

Item {
    property color titleColor : Themes.colors.neutral.neutral700
    property color contentColor : Themes.colors.neutral.neutral700
    property color placeholderColor : Themes.colors.neutral.neutral500
    property color errorColor : Themes.colors.red.red500
    property color bgColor :
        fieldRoot.enabled ? Themes.colors.neutral.neutral0 :
        Themes.colors.neutral.neutral200
    property color borderColor :
        fieldRoot.enabled ? Themes.colors.neutral.neutral100 :
        Themes.colors.neutral.neutral300
    property string title : qsTr("Title:")
    property string placeholderText : qsTr("Placeholder")
    property string errorMsg : qsTr("Error")
    property bool titleVisible : true
    property bool iconLeftVisible : false
    property bool iconRightVisible : false
    property bool enabled : true
    property bool isError : false
    property url iconLeftSource : "qrc:/assets/icons/Outline/filter.svg"
    property url iconRightSource : "qrc:/assets/icons/Outline/filter.svg"
    property int titleFontSize : 12
    property int contentFontSize : 12

    property alias text : inputField.text
    property alias fieldValidator : inputField.validator
    property alias fieldInputMask : inputField.inputMask
    property alias fieldEchoMode : inputField.echoMode
    property alias readOnly : inputField.readOnly

    //signal textChanged
    signal leftIconClicked
    signal rightIconClicked
    signal editingFinished(int text)


    id: fieldRoot
    width: 280
    height: fieldRoot.titleVisible ? 45 + 25 : 45

    ColumnLayout{
        anchors.fill: fieldRoot
        RowLayout{
            //Layout.preferredHeight: 20
            Layout.fillWidth: true
            visible : fieldRoot.titleVisible
            Text{
                text : fieldRoot.title
                verticalAlignment: Text.AlignVCenter
                font.pointSize : fieldRoot.titleFontSize
                color: fieldRoot.isError ? fieldRoot.errorColor : fieldRoot.titleColor
            }
        }

        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: fieldRoot.bgColor
            border.width: 1
            border.color: fieldRoot.isError ? fieldRoot.errorColor : fieldRoot.borderColor
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
                    visible: fieldRoot.iconLeftVisible
                    iconSource: fieldRoot.iconLeftSource
                    onClicked: {
                        leftIconClicked()
                    }
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
                    inputMask: ""
                    readOnly: false
                    enabled: fieldRoot.enabled
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
                    visible: fieldRoot.iconRightVisible
                    iconSource: fieldRoot.iconRightSource
                    onClicked: {
                        rightIconClicked()
                    }
                }
            }
        }

    }
}
