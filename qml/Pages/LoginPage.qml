import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls.Basic

import Colors
import Buttons
import InputFields

Rectangle {
    signal loginSuccessful

    id: loginPage
    width: 450
    height: 650
    color: Themes.colors.neutral.neutral50

    function authenticate(email, password){
        var authSuceess = user.authenticate(email, password)
        if(authSuceess){
            loginPage.loginSuccessful()
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
            }
        }
        Text{
            Layout.preferredHeight: 90
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
            TextInputField{
                id: emailField
                Layout.preferredHeight: 70
                Layout.fillWidth: true
                titleFontSize: 12
                titleColor: Themes.colors.neutral.neutral950
                title: "Email"
                placeholderText: "email..."
            }
            TextInputField{
                id: passwordField
                Layout.preferredHeight: 70
                Layout.fillWidth: true
                titleFontSize: 12
                titleColor: Themes.colors.neutral.neutral950
                title: "Password"
                placeholderText: "password..."
                fieldEchoMode: TextInput.Password
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
