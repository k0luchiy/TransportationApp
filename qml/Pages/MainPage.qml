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
import Map
import Popups

Rectangle{
    signal logout

    id: window
    width: 1040
    height: 840

    visible: true
    color: Themes.colors.neutral.neutral0

    Settings{
        id: settingsPopup
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        onLogout: {
            window.logout()
        }
    }

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
                        settingsPopup.open()
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
                id: mainStackView
                Layout.fillHeight: true
                Layout.fillWidth: true
                currentIndex: leftMenuTabPannel.currentIndex

                OrderPage{
                    id: orderPage
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    onAddToDelivery: (recordId) => {
                        palnningPage.deliveryOrderList.appendOrder(ordersModel.findRecord("OrderId",recordId))
                        palnningPage.deliveryOrderListChanged()
                        leftMenuTabPannel.currentIndex = 4
                    }
                }
                CarPage{
                    id: carPage
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    onAddToDelivery: (recordId) => {
                        palnningPage.deliveryModel.carId = recordId
                        leftMenuTabPannel.currentIndex = 4
                    }
                }
                DriverPage{
                    id: driverPage
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    onAddToDelivery: (recordId) => {
                        palnningPage.deliveryModel.driverId = recordId
                        leftMenuTabPannel.currentIndex = 4
                    }
                }
                DeliveriesPage{
                    id: deliveriesPage
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    onOpenDelivery : (deliveryId)=>{
                        palnningPage.deliveryModel.setRecord(deliveriesModel.findRecord("DeliveryId", deliveryId))
                        leftMenuTabPannel.currentIndex = 4
                    }
                }
                PlanningPage{
                    id: palnningPage
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            }
        }
    }

    NotificationManager{
        id: notificationManager
        anchors.fill: parent
        enabled: false
        //z: 5
    }
}
