import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

import Colors
import Buttons
import InputFields

Popup {
    property color bgColor : Themes.colors.neutral.neutral0
    property color borderColor : Themes.colors.neutral.neutral0
    property color titleColor : Themes.colors.neutral.neutral950

    property string titleText : "Settings"
    property int borderWidth : 1

    id: popupRoot
    height: 570
    width: 400

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
        Layout.margins: 10
        spacing: 10

        RowLayout{
            Layout.preferredHeight: 30
            Layout.fillWidth: true

            Text{
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                font.pointSize: 18
                text: popupRoot.titleText
                color: popupRoot.titleColor
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
        ColumnLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 5

            Text{
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                font.pointSize: 14
                color: popupRoot.titleColor
                text: "Personal info"
            }
            TextInputField{
                id: lastNameField
                Layout.preferredHeight: 60
                Layout.fillWidth: true
                title: "Last name"
                text: user.lastName ? user.lastName : ""
            }
            TextInputField{
                id: firstNameField
                Layout.preferredHeight: 60
                Layout.fillWidth: true
                title: "First name"
                text: user.firstName ? user.firstName : ""
            }
            TextInputField{
                id: emailField
                Layout.preferredHeight: 60
                Layout.fillWidth: true
                title: "Email"
                placeholderText: "email..."
                text: user.email ? user.email : ""
            }
        }
        ColumnLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 5

            Text{
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                font.pointSize: 14
                color: popupRoot.titleColor
                text: "Reset password"
            }
            TextInputField{
                id: passwordField
                Layout.preferredHeight: 60
                Layout.fillWidth: true
                title: "Password"
                placeholderText: "password..."
                fieldEchoMode: TextInput.Password
                iconRightVisible: true
                iconRightSource: "qrc:/assets/icons/Outline/eye.svg"
                onRightIconClicked: {
                    if(passwordField.fieldEchoMode === TextInput.Password){
                        passwordField.fieldEchoMode = TextInput.Normal
                    }
                    else{
                        passwordField.fieldEchoMode = TextInput.Password
                    }
                }
            }
            TextInputField{
                id: repeatPasswordField
                Layout.preferredHeight: 60
                Layout.fillWidth: true
                title: "Password"
                placeholderText: "password..."
                fieldEchoMode: TextInput.Password
                iconRightVisible: true
                iconRightSource: "qrc:/assets/icons/Outline/eye.svg"
                onRightIconClicked: {
                    if(passwordField.fieldEchoMode === TextInput.Password){
                        passwordField.fieldEchoMode = TextInput.Normal
                    }
                    else{
                        passwordField.fieldEchoMode = TextInput.Password
                    }
                }
            }
        }
        ColumnLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 5

            SwitchInputField{
                id: darkModeSwitch
                Layout.preferredHeight: 25
                Layout.fillWidth: true
                text: "Dark mode"

                onCheckedChanged: {
                    if (darkModeSwitch.checked){
                        Themes.currentTheme = Themes.themes.dark
                    }
                    else{
                        Themes.currentTheme = Themes.themes.light
                    }
                }
            }
//            SecondaryButton{
//                Layout.preferredHeight: 30
//                Layout.preferredWidth: 80
//                btnText: "Log out"
//                borderSize: 0
//                contentColor: Themes.colors.red.red500
//                onClicked: {
//                }
//            }
            Text{
                Layout.preferredHeight: 25
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 14
                color: Themes.colors.red.red500
                text: "Log out"
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    focus: true
                    activeFocusOnTab: true
                    onClicked: {
                        buttonRoot.clicked();
                    }
                    Keys.onReturnPressed: {
                        buttonRoot.clicked();
                    }
                    cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                }
            }
            Item{
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            RowLayout{
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                SecondaryButton{
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 80
                    btnText: "Cancel"
                }
                Item{
                    Layout.preferredHeight: 30
                    Layout.fillWidth: true
                }
                PrimaryButton{
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 80
                    iconLeftVisible: false
                    btnText: "Save"
                }
            }
        }

    }

}
