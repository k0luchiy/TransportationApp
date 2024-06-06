import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls.Basic

import Colors
import Buttons
import InputFields
import TabControls
import Calendar
import Tables
import Notifications
import Pages
import Tabs

Window{
    id: window
    width: 450
    height: 650
    visible: true
    title: qsTr("Transportation app")
    color: Themes.colors.neutral.neutral0

    Component{
        id: loginPageComp
        LoginPage{
            width: 450
            height: 650
            onLoginSuccessful: {
                mainLoader.sourceComponent = mainPageComp
                window.width = 1040
                window.height = 840
                window.visibility = Window.Maximized
            }
        }
    }

    Component{
        id: mainPageComp
        MainPage{
            width: 1040
            height: 840
        }
    }

    Loader {
        id: mainLoader
        anchors.fill: parent
        sourceComponent: loginPageComp
    }
}
