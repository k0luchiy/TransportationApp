import QtQuick 2.15
import QtQuick.Layouts

import Colors
import TabControls
import Tabs
import Map

import TransportationsApp.Models 1.0

Item {
    property alias tabIndex : deliveryTabPannel.currentIndex

    property alias deliveryOrderList : planningTab.deliveryOrderList
    property alias deliveryModel : planningTab.deliveryModel

    id: pageRoot
    height: 800
    width: 1040


    onDeliveryOrderListChanged: {
        console.log("deliveryOrderList changed")
        planningMapTab.orderList = planningTab.deliveryOrderList.orderList
    }

    Component{
        id: planningMapTabComp
        MapComponent{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }


    ColumnLayout{
        anchors.fill: parent

        TabPannel{
            id: deliveryTabPannel
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            tabs: [
                {text: "Delivery", checked: true, iconVisible: false},
                {text: "Map", checked: true, iconVisible: false}
            ]
        }

        StackLayout {
            id: deliveryStackView
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: 10
            currentIndex: deliveryTabPannel.currentIndex
            PlanningTab{
                id: planningTab
                Layout.fillHeight: true
                Layout.fillWidth: true
//                onDeliveryOrderListChanged: {
//                    planningMapTab.orderList = planningTab.deliveryOrderList.orderList
//                }
            }

            PlanningMapTab{
                id: planningMapTab
                Layout.fillHeight: true
                Layout.fillWidth: true
                startAddress: "Екатеринбург, улица Репина 15"
                orderList: pageRoot.deliveryOrderList.orderList //pageRoot.deliveryOrderList.orderList
            }
        }
    }
}
