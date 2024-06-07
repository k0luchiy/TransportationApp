import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls.Basic

import Colors
import Buttons
import InputFields

Rectangle {
    property bool authError : false
    property string authErrorMsg : ""

    signal loginSuccessful
    signal sigUpClicked

    id: loginPage
    width: 450
    height: 750
    color: Themes.colors.neutral.neutral50

    function authenticate(email, password){
        var authSuceess = user.authenticate(email, password)
        if(authSuceess){
            emailField.isError = false
            passwordField.isError = false
            loginPage.loginSuccessful()
        }
        else{
            emailField.isError = true
            passwordField.isError = true
            loginPage.authError = true
            loginPage.authErrorMsg = "Wrong credentials were provided"
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
                btnText: "Sign up"
                borderSize: 0
                contentColor: Themes.colors.primary.primary500
                onClicked: {
                    loginPage.sigUpClicked()
                }
            }
        }
        Item{
            Layout.preferredHeight: 30
            Layout.fillWidth: true
        }
        Text{
            Layout.preferredHeight: 100
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            font.pointSize: 20
            text: "Login"
            horizontalAlignment: Text.AlignHCenter
        }

        ColumnLayout{
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.margins: 30
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10
            Text{
                id: authErrorLabel
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                font.pointSize: 12
                color: Themes.colors.red.red500
                //visible: loginPage.authError
                text: loginPage.authError ? loginPage.authErrorMsg : ""
            }
            TextInputField{
                id: emailField
                focus: true
                activeFocusOnTab: true
                Layout.preferredHeight: 70
                Layout.fillWidth: true
                titleFontSize: 12
                titleColor: Themes.colors.neutral.neutral950
                title: "Email"
                placeholderText: "email..."
            }
            TextInputField{
                id: passwordField
                activeFocusOnTab: true
                Layout.preferredHeight: 70
                Layout.fillWidth: true
                titleFontSize: 12
                titleColor: Themes.colors.neutral.neutral950
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
            PrimaryButton{
                Layout.preferredHeight: 35
                Layout.fillWidth: true
                iconLeftVisible: false
                btnText: "Login"

                onClicked: {
                    var email = emailField.text
                    var password = passwordField.text
                    loginPage.authenticate(email, password)
                }
            }
        }

        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}
