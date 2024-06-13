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
    width: settings.rememberUser ? 1040 : 450
    height: settings.rememberUser ? 840 : 750

//    width: 1040
//    height: 840
//    visibility: Window.Maximized
    visible: true
    title: qsTr("Transportation app")
    color: Themes.colors.neutral.neutral0

    Component{
        id: authPageComp
        AuthPage{
            onAuthSuccess: {
                if(settings.rememberUser){
                    settings.userId = user.userId
                }
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

            onLogout: {
                settings.rememberUser = false
                settings.userId = 0
                settings.dumpSettings()
                window.width = 450
                window.height = 750
                window.visibility = Window.Windowed
                mainLoader.sourceComponent = authPageComp
            }
        }
    }

    Loader {
        id: mainLoader
        anchors.fill: parent
        //sourceComponent: (setttings.rememberUser && settings.userId !== 0) ?
        //            mainPageComp : authPageComp //authPageComp
    }

    Component.onCompleted: {
        if (settings.darkMode){
            Themes.currentTheme = Themes.themes.dark
        }
        else{
            Themes.currentTheme = Themes.themes.light
        }

        if(settings.rememberUser && settings.userId !== 0){
            user.setUser(settings.userId)
            mainLoader.sourceComponent = mainPageComp
            window.width = 1040
            window.height = 840
            window.visibility = Window.Maximized
        }
        else{
            mainLoader.sourceComponent = authPageComp
        }
    }

    onClosing: {
        if(Themes.currentTheme.themeId === 0){
            settings.darkMode = false
        }
        else{
            settings.darkMode = true
        }
        settings.dumpSettings()
    }
}
