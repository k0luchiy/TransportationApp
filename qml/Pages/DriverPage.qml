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
            tabs: [{text: "Drivers", checked: true, iconVisible: false}]
            onTabClosed: (index) => {
                driversStackView.children[index].destroy()
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
                    driverTabPannel.addTab("Driver " + recordId)
                    var driverInfoTab = driverInfoTabComp.createObject(driversStackView)
                    driverInfoTab.driverModel.setRecord(driversModel.findRecord("DriverId", recordId))
                    driverInfoTab.parent = driversStackView;
                }
            }
        }
    }
}
