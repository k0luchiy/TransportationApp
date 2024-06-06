import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls.Basic

import Colors

Rectangle {
    signal authSuccess

    id: authPage
    width: 450
    height: 750
    color: Themes.colors.neutral.neutral50

    StackLayout {
        id: authStackView
        anchors.fill: parent
        currentIndex: 0
        LoginPage{
            Layout.fillHeight: true
            Layout.fillWidth: true
            onSigUpClicked: {
                authStackView.currentIndex = 1
            }
            onLoginSuccessful: {
                authPage.authSuccess()
            }
        }
        SignUpPage{
            Layout.fillHeight: true
            Layout.fillWidth: true
            onLoginClicked: {
                authStackView.currentIndex = 0
            }
            onRegisterSuccess: {
                authStackView.currentIndex = 0
            }
        }
    }
}
