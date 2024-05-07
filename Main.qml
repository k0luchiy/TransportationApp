import QtQuick
import QtQuick.Window
import Colors
import Buttons
import InputFields

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    //color: CustomColors.primary
    function foo() {
        Themes.currentTheme = Themes.themes.dark //: Themes.themes.dark
    }

    color: Themes.colors.neutral.neutral0

    TextInputField{

    }

    PrimaryButton{
        x: 521
        y: 403
        onClicked : {
            console.log(Themes.currentTheme.themeId)
            if (Themes.currentTheme.themeId === 0){
                Themes.currentTheme = Themes.themes.dark
            }
            else{
                Themes.currentTheme = Themes.themes.light
            }
        }
    }
}
