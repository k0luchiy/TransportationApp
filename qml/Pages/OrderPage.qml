import QtQuick 2.15
import QtQuick.Layouts

import Colors
import TabControls
import Tabs

import TransportationsApp.Models 1.0

Item {

    signal addToDelivery(recordId : int)

    id: pageRoot
    height: 800
    width: 1040

    Component{
        id: orderInfoPageComp
        OrderInfoTab{
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
            tabs: [{text: "Order", checked: true, iconVisible: false}]
            onTabClosed: (index) => {
                ordersStackView.children[index].destroy()
                //orderTabPannel.currentIndexChanged()
                //ordersStackView.currentIndex = ordersStackView.currentIndex
                //ordersStackView.currentIndex = orderTabPannel.currentIndex

//                if(orderTabPannel.currentIndex >= index){
//                     //tabBarRoot.currentIndex = tabBarRoot.currentIndex
//                    ordersStackView.currentIndex -= 1
//                }
            }
        }

        StackLayout {
            id: ordersStackView
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: 10
            currentIndex: orderTabPannel.currentIndex
            OrderTableTab{
                id: orderTableTab
                Layout.fillHeight: true
                Layout.fillWidth: true
                //connectedTabPannel: orderTabPannel
                onRowClicked: (recordId) => {
                    orderTabPannel.addTab("Order " + recordId)
                    var orderInfoPage = orderInfoPageComp.createObject(ordersStackView)
                    orderInfoPage.orderModel.setRecord(ordersModel.findRecord("OrderId", recordId))
                    orderInfoPage.parent = ordersStackView;
                }
                onOpenTab: (recordId) => {
                    orderTableTab.rowClicked(recordId)
                }
                onAddToDelivery: (recordId) => {
                    pageRoot.addToDelivery(recordId)
                }
            }
        }
    }
}
