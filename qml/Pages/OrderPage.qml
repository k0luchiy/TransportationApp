import QtQuick 2.15
import QtQuick.Layouts

import Colors
import TabControls
import Tabs

Item {

    id: pageRoot
    height: 800
    width: 1040

    ColumnLayout{
        anchors.fill: parent

        TabPannel{
            id: orderTabPannel
            Layout.preferredHeight: 40
            Layout.fillWidth: true

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
                connectedTabPannel: orderTabPannel
            }
            OrderInfoPage{
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }
    }
}
