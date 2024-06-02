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
        OrderTableTab{
            Layout.margins: 10
            Layout.fillHeight: true
            Layout.fillWidth: true
            connectedTabPannel: orderTabPannel
        }
    }
}
