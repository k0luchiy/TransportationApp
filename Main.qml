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

Window {
    id: window
    width: 1040
    height: 840

//    visibility: Window.FullScreen
    visible: true
    title: qsTr("Hello World")

    //color: CustomColors.primary
    function foo() {
        Themes.currentTheme = Themes.themes.dark //: Themes.themes.dark
    }

    color: Themes.colors.neutral.neutral0


    ColumnLayout{
        anchors.fill: parent
        visible: true
        spacing: 0

        Rectangle{
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            color: Themes.colors.neutral.neutral50

            RowLayout{
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10

                Text{
                    Layout.fillHeight: true
                    Layout.preferredWidth: 150
                    font.pointSize: 16
                    color: Themes.colors.neutral.neutral950
                    text: "Transportation"
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                }
                Item{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                IconButton{
                    iconSize: 18
                    iconSource: "qrc:/assets/icons/Outline/cog.svg"
                }
                IconButton{
                    iconSize: 18
                    iconSource: "qrc:/assets/icons/Outline/information-circle.svg"
                }
                IconButton{
                    iconSize: 18
                    iconSource: "qrc:/assets/icons/Outline/question-mark-circle.svg"
                }
                Button{
                    Layout.fillHeight: true
                    Layout.preferredWidth: 235
                    clip: true
                    iconSize: 18
                    fontSize: 12
                    bgColor: Colors.elementary.transparent
                    contentColor: Themes.colors.neutral.neutral950
                    btnText: "antoshka.osipov.04@mail.ru"
                    iconLeftSource: "qrc:/assets/icons/Outline/user.svg"
                }
                IconButton{
                    iconSize: 18
                    iconSource: "qrc:/assets/icons/Outline/logout.svg"
                }
            }
        }

        RowLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true

            LeftMenuTabPannel{
                Layout.fillHeight: true
                Layout.preferredWidth: 200
            }

            OrderPage{
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }
    }

    Item{
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 400
        visible: false
//        ColumnLayout{
//            Layout.fillHeight: true
//            Layout.fillWidth: true
//            NotificationMsg {
//            }
//        }
        NotificationManager{
            id: notificationManager
            anchors.fill: parent
        }
    }

    ColumnLayout{
        visible: false
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        x: 500
        width: 120
        PrimaryButton{
            Layout.preferredHeight: 50
            Layout.fillWidth: true
            btnText: "Info"
            onClicked: {
                notificationManager.showNotification(
                    NotificationTypes.info,
                    "Information notification test"
                );
            }
        }
        PrimaryButton{
            Layout.preferredHeight: 50
            Layout.fillWidth: true
            btnText: "Success"
            onClicked: {
                notificationManager.showNotification(
                    NotificationTypes.success,
                    "Success notification test"
                );
            }
        }
        PrimaryButton{
            Layout.preferredHeight: 50
            Layout.fillWidth: true
            btnText: "Warning"
            onClicked: {
                notificationManager.showNotification(
                    NotificationTypes.warning,
                    "Warning notification test"
                );
            }
        }
        PrimaryButton{
            Layout.preferredHeight: 50
            Layout.fillWidth: true
            btnText: "Failure"
            onClicked: {
                notificationManager.showNotification(
                    NotificationTypes.failure,
                    "Failure notification test"
                );
            }
        }
    }

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
        visible: false
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
