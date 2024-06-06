import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls.Basic

import Colors
import Buttons
import InputFields

Rectangle {
    signal registerSuccess
    signal loginClicked

    id: signUpPage
    width: 450
    height: 750
    color: Themes.colors.neutral.neutral50

    function registerUser(lastName, firstName, email, password, repeatPassword){
        if(password !== repeatPassword){
            passwordField.isError = true
            passwordField.errorMsg = "Password do not match"
            repeatPasswordField.isError = true
            repeatPasswordField.errorMsg = "Password do not match"
            return;
        }
        else {
            passwordField.isError = false
            passwordField.errorMsg = ""
            repeatPasswordField.isError = false
            repeatPasswordField.errorMsg = ""
        }
        if(user.isUserExist(email)){
            emailField.isError = true
            emailField.errorMsg = "User with this email already exists"
            return;
        }
        else{
            emailField.isError = false
            emailField.errorMsg = ""
        }
        var registerSuceess = user.registration(email, password, firstName, lastName)
        if(registerSuceess){
            console.log("Registration success")
            signUpPage.registerSuccess()
        }
        else{
            console.log("Registration failed")
        }
    }

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 10

        RowLayout{
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.preferredHeight: 30
            Layout.fillWidth: true
            Item{
                Layout.preferredHeight: 30
                Layout.fillWidth: true
            }
            SecondaryButton{
                Layout.preferredHeight: 30
                Layout.preferredWidth: 80
                btnText: qsTr("Login")
                borderSize: 0
                contentColor: Themes.colors.primary.primary500
                onClicked: {
                    signUpPage.loginClicked()
                }
            }
        }
        Item{
            Layout.preferredHeight: 30
            Layout.fillWidth: true
        }
        Text{
            Layout.preferredHeight: 80
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            font.pointSize: 20
            text: qsTr("Sign up")
            horizontalAlignment: Text.AlignHCenter
        }

        ColumnLayout{
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.margins: 30
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10
            TextInputField{
                id: lastNameField
                Layout.preferredHeight: 60
                Layout.fillWidth: true
                titleFontSize: 12
                titleColor: Themes.colors.neutral.neutral950
                title: qsTr("Last name")
                placeholderText: qsTr("Osipov...")
            }
            TextInputField{
                id: firstNameField
                Layout.preferredHeight: 60
                Layout.fillWidth: true
                titleFontSize: 12
                titleColor: Themes.colors.neutral.neutral950
                title: qsTr("First name")
                placeholderText: qsTr("Anton...")
            }
            TextInputField{
                id: emailField
                Layout.preferredHeight: 60
                Layout.fillWidth: true
                titleFontSize: 12
                titleColor: Themes.colors.neutral.neutral950
                title: qsTr("Email")
                placeholderText: qsTr("email...")
            }
            TextInputField{
                id: passwordField
                Layout.preferredHeight: 60
                Layout.fillWidth: true
                titleFontSize: 12
                titleColor: Themes.colors.neutral.neutral950
                title: qsTr("Password")
                placeholderText: qsTr("password...")
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
                titleFontSize: 12
                titleColor: Themes.colors.neutral.neutral950
                title: qsTr("Repeat password")
                placeholderText: qsTr("password...")
                fieldEchoMode: TextInput.Password
                iconRightVisible: true
                iconRightSource: "qrc:/assets/icons/Outline/eye.svg"
                onRightIconClicked: {
                    if(repeatPasswordField.fieldEchoMode === TextInput.Password){
                        repeatPasswordField.fieldEchoMode = TextInput.Normal
                    }
                    else{
                        repeatPasswordField.fieldEchoMode = TextInput.Password
                    }
                }
            }
            PrimaryButton{
                Layout.preferredHeight: 35
                Layout.fillWidth: true
                iconLeftVisible: false
                btnText: qsTr("Sign up")

                onClicked: {
                    var lastName = lastNameField.text
                    var firstName = firstNameField.text
                    var email = emailField.text
                    var password = passwordField.text
                    var repeatPassword = repeatPasswordField.text
                    signUpPage.registerUser(lastName, firstName,
                                        email, password, repeatPassword)
                }
            }
        }

        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}
