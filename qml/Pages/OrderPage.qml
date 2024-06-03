import QtQuick 2.15
import QtQuick.Layouts

import Colors
import TabControls
import Tabs

import TransportationsApp.Models 1.0

Item {

    id: pageRoot
    height: 800
    width: 1040

    Component{
        id: orderInfoPageComp
        OrderInfoPage{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }


    ColumnLayout{
        anchors.fill: parent

        TabPannel{
            id: orderTabPannel
            Layout.preferredHeight: 40
            Layout.fillWidth: true

//            onTabClosed: (index) => {
//                ordersStackView
//            }

            TabButtonBase {
                id: mainTabButton
                text: "Orders"
                checked: true
                iconVisible: false
            }
        }

        StackLayout {
            id: ordersStackView
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: 10
            currentIndex: orderTabPannel.currentIndex
            OrderTableTab{
                Layout.fillHeight: true
                Layout.fillWidth: true
                //connectedTabPannel: orderTabPannel
                onRowClicked: (recordId) => {
                    orderTabPannel.addTab("Order " + recordId)
                    var orderInfoPage    = orderInfoPageComp.createObject(ordersStackView)
                    orderInfoPage.orderModel.setRecord(orders.findRecord("OrderId", recordId))
                    orderInfoPage.parent = ordersStackView;
                }
            }
        }
    }
}
