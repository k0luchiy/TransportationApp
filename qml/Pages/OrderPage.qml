import QtQuick 2.15
import QtQuick.Layouts

import Colors
import TabControls
import Tabs

import TransportationsApp.Models 1.0

Item {
    property alias tabIndex : orderTabPannel.currentIndex

    signal addToDelivery(recordId : int)

    id: pageRoot
    height: 800
    width: 1040

    function addInfoTab(recordId){
        orderTabPannel.addTab(qsTr("Order") + " " + recordId)
        var orderInfoPage = orderInfoPageComp.createObject(ordersStackView)
        orderInfoPage.orderModel.setRecord(ordersModel.findRecord("OrderId", recordId))
        orderInfoPage.parent = ordersStackView;
        orderTabPannel.currentIndex = orderTabPannel.tabs.length - 1
    }

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
            tabs: [{text: qsTr("Orders"), checked: true, iconVisible: false}]
            onTabClosed: (index) => {
                ordersStackView.children[index].destroy()
                if(orderTabPannel.currentIndex >= index){
                    ordersStackView.currentIndex = orderTabPannel.currentIndex + 1
                }
            }
            onCurrentIndexChanged: {
                ordersStackView.currentIndex = orderTabPannel.currentIndex
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
                onRowClicked: (recordId) => {
                    pageRoot.addInfoTab(recordId)
                }
                onOpenTab: (recordId) => {
                    pageRoot.addInfoTab(recordId)
                }
                onAddToDelivery: (recordId) => {
                    pageRoot.addToDelivery(recordId)
                }
            }
        }
    }
}
