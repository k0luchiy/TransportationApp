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



    Component{
        id: tabButton
        TabButtonBase{
            height: 40
            width: 100
            text: "Order 1"
        }
    }

    RowLayout{
        anchors.fill: parent
        visible: false

        LeftMenuTabPannel{
            Layout.fillHeight: true
            Layout.preferredWidth: 200
        }


        ColumnLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true

            TabPannel{
                id: tabPannel
                Layout.preferredHeight: 40
                Layout.fillWidth: true
            }

            ColumnLayout{
                visible: true
                Layout.fillHeight: true
                Layout.fillWidth: true

                OrdersTable{
                    pagination : orderPagination
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    onRowClicked: {
    //                    var component = Qt.createComponent("TabButtonBase.qml")
                        var tab    = tabButton.createObject(tabPannel)
    //                    tab.text = "Order 1"
    //                    tabPannel.addItem(tab)
                        tabPannel.addItem(tab)
                    }
                }

                Pagination{
                    id : orderPagination
                    Layout.preferredHeight: 40
                    Layout.fillWidth: true
                    rowCount: ordersFilterModel.rowCount()
                    rowsPerPage : 5
                }
            }
        }
    }

    Pagination{
        visible: false

    }

    AdditionalCalendar{
        x: 50
        y: 50
        visible: false
    }


    RowLayout{
        visible: true
//        width: 200
//        anchors.top: parent.top
//        anchors.bottom: parent.bottom

        anchors.fill: parent


        TextInputField{
            Layout.fillWidth: true
            enabled: false

        }


        TextInputField{
            Layout.fillWidth: true
            isError: true
        }

        NumberInputField{
            Layout.fillWidth: true
        }

        ComboBoxInputField{
            id: comboBoxField
            Layout.fillWidth: true
            model: ordersFilterModel//["First", "Second", "Third", "Forth"]
            textRole: "OrderId"
            onCurrentTextChanged : {
                label.text = comboBoxField.currentText
            }
        }

        DateInputField{
            Layout.fillWidth: true
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
