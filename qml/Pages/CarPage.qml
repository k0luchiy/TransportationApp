import QtQuick 2.15
import QtQuick.Layouts

import Colors
import TabControls
import Tabs

import TransportationsApp.Models 1.0

Item {
    property alias tabIndex : carTabPannel.currentIndex

    signal addToDelivery(recordId : int)

    id: pageRoot
    height: 800
    width: 1040

    function addInfoTab(recordId){
        carTabPannel.addTab(qsTr("Car") + " " + recordId)
        var carInfoPage = carInfoPageComp.createObject(carsStackView)
        carInfoPage.carModel.setRecord(carsModel.findRecord("CarId", recordId))
        carInfoPage.parent = carsStackView;
        carTabPannel.currentIndex = carTabPannel.tabs.length - 1
    }

    Component{
        id: carInfoPageComp
        CarInfoTab{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    ColumnLayout{
        anchors.fill: parent

        TabPannel{
            id: carTabPannel
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            tabs: [{text: qsTr("Cars"), checked: true, iconVisible: false}]
            onTabClosed: (index) => {
                carsStackView.children[index].destroy()
                if(carTabPannel.currentIndex >= index){
                    carsStackView.currentIndex = carTabPannel.currentIndex + 1
                }
            }
            onCurrentIndexChanged: {
                carsStackView.currentIndex = carTabPannel.currentIndex
            }
        }

        StackLayout {
            id: carsStackView
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: 10
            currentIndex: carTabPannel.currentIndex
            CarTableTab{
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
