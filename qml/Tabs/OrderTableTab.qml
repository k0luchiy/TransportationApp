import QtQuick 2.15
import QtQuick.Layouts

import Colors
import Buttons
import InputFields
import Tables
import TabControls

Item {
    property var connectedTabPannel

    id: pageRoot
    height: 800
    width: 1040

    ColumnLayout{
        anchors.fill: parent
        spacing: 10

        RowLayout{
            Layout.preferredHeight: 60
            Layout.fillWidth: true
            spacing: 10
            z: 10

            TextInputField{
                Layout.fillWidth: true
                Layout.preferredHeight: 60
            }
            DateRangeInputField{
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                z: 10
            }
            DateRangeInputField{
                Layout.fillWidth: true
                Layout.preferredHeight: 60
            }
            TextInputField{
                Layout.fillWidth: true
                Layout.preferredHeight: 60
            }
            ComboBoxInputField{
                Layout.fillWidth: true
                Layout.preferredHeight: 60
            }
            TextInputField{
                Layout.fillWidth: true
                Layout.preferredHeight: 60
            }

            SecondaryButton{
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.preferredHeight: 35
                Layout.preferredWidth: 60
                btnText: "Clear"
                fontSize: 10
            }
        }
        OrdersTable{
            pagination : orderPagination
            Layout.fillHeight: true
            Layout.fillWidth: true

            onRowClicked: {
                var component = Qt.createComponent("TabButtonBase.qml")
                var tab    = tabButton.createObject(connectedTabPannel)
                tab.text = "Order 1"
                tab.connectedTabPannel = connectedTabPannel
                connectedTabPannel.addItem(tab)
            }
        }

        Pagination{
            id : orderPagination
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            rowCount: ordersFilterModel.rowCount()
            rowsPerPage : 5
        }
    }
}
