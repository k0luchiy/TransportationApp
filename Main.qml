import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls.Basic

import Colors
import Buttons
import InputFields
import TabControls
import Calendar

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    //color: CustomColors.primary
    function foo() {
        Themes.currentTheme = Themes.themes.dark //: Themes.themes.dark
    }

    color: Themes.colors.neutral.neutral0

    AdditionalCalendar{}

    ColumnLayout{
        visible: false
        width: 200
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        LeftMenuTabPannel{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    ColumnLayout{
        visible: false
        width: 200
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        TextInputField{
            Layout.fillWidth: true
            enabled: false

        }

        NumberInputField{
            Layout.fillWidth: true
        }

        ComboBoxControl{
            Layout.fillWidth: true
            Layout.preferredHeight: 45
        }
        ComboBoxInputField{
            id: comboBoxField
            Layout.fillWidth: true
            model: ["First", "Second", "Third", "Forth"]
            onCurrentTextChanged : {
                label.text = comboBoxField.currentText
            }

        }

        Text{
            id: label
            height: 30
            Layout.fillWidth: true
            color: Themes.colors.elementary.black
            text: "Hello"
            font.pointSize: 14
        }

        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    PrimaryButton{
        x: 521
        y: 403
        onClicked : {
            if (Themes.currentTheme.themeId === 0){
                Themes.currentTheme = Themes.themes.dark
            }
            else{
                Themes.currentTheme = Themes.themes.light
            }
        }
    }
}
