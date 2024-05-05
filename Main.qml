import QtQuick
import QtQuick.Window
import Colors
import Buttons

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    //color: CustomColors.primary
    function foo() {
        Themes.currentTheme = Themes.themes.dark //: Themes.themes.dark
    }

    color: Themes.colors.neutral.neutral200

    Button{
        color: Themes.colors.primary.primary50 //Themes.colors.neutral0
        fontColor: Themes.colors.green.green200
        onClicked : {
            Themes.currentTheme = Themes.themes.dark
        }
    }
}
