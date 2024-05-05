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

    color: Themes.colors.neutral.neutral800
    Button{
        borderSize: 1
        bgColor: Colors.elementary.transparent
        contentColor: Colors.neutral.neutral400
        iconLeftVisible: false
        iconRightVisible: false
        buttonSize: ButtonSizes.mediumSize
    }

}
