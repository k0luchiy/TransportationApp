import QtQuick 2.15
import QtQuick.Layouts

import Colors
import TabControls
import Tabs

import TransportationsApp.Models 1.0

Item {
    property alias tabIndex : driverTabPannel.currentIndex

    signal addToDelivery(recordId : int)

    id: pageRoot
    height: 800
    width: 1040

    function addInfoTab(recordId){
        driverTabPannel.addTab(qsTr("Driver") + " " + recordId)
        var driverInfoTab = driverInfoTabComp.createObject(driversStackView)
        driverInfoTab.driverModel.setRecord(driversModel.findRecord("DriverId", recordId))
        driverInfoTab.parent = driversStackView;
        driverTabPannel.currentIndex = driverTabPannel.tabs.length - 1
    }

    Component{
        id: driverInfoTabComp
        DriverInfoTab{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }


    ColumnLayout{
        anchors.fill: parent

        TabPannel{
            id: driverTabPannel
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            tabs: [{text: qsTr("Drivers"), checked: true, iconVisible: false}]
            onTabClosed: (index) => {
                driversStackView.children[index].destroy()
                if(driverTabPannel.currentIndex >= index){
                    driversStackView.currentIndex = driverTabPannel.currentIndex + 1
                }
            }
            onCurrentIndexChanged: {
                driversStackView.currentIndex = driverTabPannel.currentIndex
            }
        }

        StackLayout {
            id: driversStackView
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: 10
            currentIndex: driverTabPannel.currentIndex
            DriverTableTab{
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
