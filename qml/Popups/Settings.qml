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

    property string titleText : qsTr("Settings")
    property int borderWidth : 1

    signal logout

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

    onClosed: {
        lastNameField.text = user.lastName
        firstNameField.text = user.firstName
        emailField.text = user.email
        oldPasswordField.text = ""
        newPasswordField.text = ""
        lastNameField.isError = false
        firstNameField.isError = false
        emailField.isError = false
        oldPasswordField.isError = false
        newPasswordField.isError = false
        popupRoot.close()
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
                text: qsTr("Personal info")
            }
            TextInputField{
                id: lastNameField
                Layout.preferredHeight: 60
                Layout.fillWidth: true
                title: qsTr("Last name")
                text: user.lastName ? user.lastName : ""
            }
            TextInputField{
                id: firstNameField
                Layout.preferredHeight: 60
                Layout.fillWidth: true
                title: qsTr("First name")
                text: user.firstName ? user.firstName : ""
            }
            TextInputField{
                id: emailField
                Layout.preferredHeight: 60
                Layout.fillWidth: true
                title: qsTr("Email")
                placeholderText: qsTr("email...")
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
                text: qsTr("Reset password")
            }
            TextInputField{
                id: oldPasswordField
                Layout.preferredHeight: 60
                Layout.fillWidth: true
                title: qsTr("Password")
                placeholderText: qsTr("password...")
                fieldEchoMode: TextInput.Password
                iconRightVisible: true
                iconRightSource: "qrc:/assets/icons/Outline/eye.svg"
                onRightIconClicked: {
                    if(oldPasswordField.fieldEchoMode === TextInput.Password){
                        oldPasswordField.fieldEchoMode = TextInput.Normal
                    }
                    else{
                        oldPasswordField.fieldEchoMode = TextInput.Password
                    }
                }
            }
            TextInputField{
                id: newPasswordField
                Layout.preferredHeight: 60
                Layout.fillWidth: true
                title: qsTr("Password")
                placeholderText: qsTr("password...")
                fieldEchoMode: TextInput.Password
                iconRightVisible: true
                iconRightSource: "qrc:/assets/icons/Outline/eye.svg"
                onRightIconClicked: {
                    if(newPasswordField.fieldEchoMode === TextInput.Password){
                        newPasswordField.fieldEchoMode = TextInput.Normal
                    }
                    else{
                        newPasswordField.fieldEchoMode = TextInput.Password
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
                text: qsTr("Dark mode")
                checked: Themes.currentTheme.themeId === 1

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
                text: qsTr("Log out")
                MouseArea{
                    id: logoutMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    focus: true
                    activeFocusOnTab: true
                    onClicked: {
                        popupRoot.close()
                        popupRoot.logout()
                    }
                    Keys.onReturnPressed: {
                        logoutMouse.clicked();
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
                    btnText: qsTr("Cancel")
                    onClicked: {
                        popupRoot.close()
                    }
                }
                Item{
                    Layout.preferredHeight: 30
                    Layout.fillWidth: true
                }
                PrimaryButton{
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 80
                    iconLeftVisible: false
                    btnText: qsTr("Save")
                    onClicked: {
                        var lastName = lastNameField.text
                        var firstName = firstNameField.text
                        var email = emailField.text
                        var oldPassword = oldPasswordField.text
                        var newPassword = newPasswordField.text
                        var infoSuccess = true
                        var pwdSuccess = true

                        if(
                            lastName !== user.lastName ||
                            firstName !== user.firstName ||
                            email !== user.email)
                        {
                            user.updateUserInfo(user.userId, lastName,
                                                firstName, email)
                        }

                        if(oldPassword === "" && newPassword === ""){}
                        else if(oldPassword !== "" && newPassword !== ""){
                            var oldPasswordMatch = user.checkPassword(user.userId, oldPassword)
                            if(oldPasswordMatch){
                                oldPasswordField.isError = false
                                user.updateUserPassword(user.userId,
                                                    oldPassword, newPassword)
                            }
                            else{
                                oldPasswordField.isError = true
                                pwdSuccess = false
                            }
                        }
                        else{
                            if(oldPassword !== "") {oldPasswordField.isError = false}
                            else {oldPasswordField.isError = true}
                            if(newPassword !== "") {newPasswordField.isError = false}
                            else {newPasswordField.isError = true}
                            pwdSuccess = false
                        }


                        if(infoSuccess && pwdSuccess){
                            settings.dumpSettings()
                            popupRoot.close()
                        }
                    }
                }
            }
        }

    }

}
