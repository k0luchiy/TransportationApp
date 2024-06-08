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
            id: deliveryTabPannel
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            tabs: [{text: "Delivery", checked: true, iconVisible: false}]
            onTabClosed: (index) => {
                deliveryStackView.children[index].destroy()
            }
        }

        StackLayout {
            id: deliveryStackView
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: 10
            currentIndex: deliveryTabPannel.currentIndex
            PlanningTab{
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }
    }
}
