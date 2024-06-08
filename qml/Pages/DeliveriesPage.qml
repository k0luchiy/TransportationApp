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
        id: palnningTabComp
        PlanningTab{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }


    ColumnLayout{
        anchors.fill: parent

        TabPannel{
            id: deliveriesTabPannel
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            tabs: [{text: "Deliveies", checked: true, iconVisible: false}]
            onTabClosed: (index) => {
                deliveiesStackView.children[index].destroy()
            }
        }

        StackLayout {
            id: deliveiesStackView
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: 10
            currentIndex: deliveriesTabPannel.currentIndex
            DeliveryTableTab{
                Layout.fillHeight: true
                Layout.fillWidth: true
                onRowClicked: (recordId) => {
                    deliveriesTabPannel.addTab("Delivery " + recordId)
                    var planningTab = palnningTabComp.createObject(deliveiesStackView)
                    planningTab.deliveryModel.setRecord(deliveriesModel.findRecord("DeliveryId", recordId))
                    planningTab.parent = deliveiesStackView;
                }
            }
        }
    }
}
