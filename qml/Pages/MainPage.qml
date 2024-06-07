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

//Window {
//ApplicationWindow{
Rectangle{
    id: window
    width: 1040
    height: 840

//    visibility: Window.FullScreen
    visible: true
//    title: qsTr("Hello World")
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
                    onClicked : {
                        if (Themes.currentTheme.themeId === 0){
                            Themes.currentTheme = Themes.themes.dark
                        }
                        else{
                            Themes.currentTheme = Themes.themes.light
                        }
                    }
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
                    btnText: user.email
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
                id: leftMenuTabPannel
                Layout.fillHeight: true
                Layout.preferredWidth: 200
            }

            StackLayout {
                id: carsStackView
                Layout.fillHeight: true
                Layout.fillWidth: true
                currentIndex: leftMenuTabPannel.currentIndex
//                PlanningTab{
//                    Layout.fillHeight: true
//                    Layout.fillWidth: true
//                }
                OrderPage{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                CarPage{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                DriverPage{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            }
        }
    }

    Item{
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 400
        visible: false

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
}