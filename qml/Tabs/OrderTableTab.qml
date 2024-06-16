import QtQuick 2.15
import QtQuick.Layouts

import Colors
import Buttons
import InputFields
import Tables
import TabControls

Item {
    signal rowClicked(recordId : int)
    signal openTab(recordId : int)
    signal addToDelivery(recordId : int)

    id: pageRoot
    height: 800
    width: 1040

    ColumnLayout{
        anchors.fill: parent
        spacing: 10
        RowLayout{
            Layout.preferredHeight: 35
            Layout.fillWidth: true
            spacing: 10
            TextInputField{
                id: searchField
                Layout.fillWidth: true
                Layout.preferredHeight: 35
                titleVisible: false
                placeholderText: qsTr("Search...")
                iconLeftVisible: true
                iconLeftSource: "qrc:/assets/icons/Outline/search.svg"

                onEditingFinished: {
                    var searchText = searchField.text
                    var orderId = Number(searchText.replace(/\D/g, ""))
                    ordersFilterModel.setFilterOrderId(orderId)
                }
            }
            PrimaryButton{
                Layout.preferredWidth: 95
                Layout.preferredHeight: 35
                btnText: qsTr("Filter")
                iconLeftVisible: true
                iconLeftSource: "qrc:/assets/icons/Outline/filter.svg"

                onClicked: {
                    var orderId = orderIdField.text ? Number(orderIdField.text) : 0
                    var minCreatedDate = createdDateRangeField.startDate
                    var maxCreatedDate = createdDateRangeField.endDate
                    var minDeliveryDate = deliveryDateRangeField.startDate
                    var maxDeliveryDate = deliveryDateRangeField.endDate
                    var address = addressField.text
                    var statusTitle = statusField.currentText
                    var cost = costField.text ? Number(costField.text) : 0

                    ordersFilterModel.setFilters(
                        orderId, minCreatedDate, maxCreatedDate,
                        minDeliveryDate, maxDeliveryDate,
                        address, statusTitle, cost
                    );
                    orderPagination.rowCount = ordersFilterModel.rowCount()
                }
            }
        }

        RowLayout{
            Layout.preferredHeight: 60
            Layout.fillWidth: true
            spacing: 10
            z: 10

            NumberInputField{
                id: orderIdField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Id:")
            }
            DateRangeInputField{
                id: createdDateRangeField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                z: 10
                title: qsTr("Created date:")
            }
            DateRangeInputField{
                id: deliveryDateRangeField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Delivery date:")
            }
            TextInputField{
                id: addressField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Address:")
            }
            ComboBoxInputField{
                id: statusField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Status:")
                model: ordersStatusModel
                textRole: "StatusTitle"
            }
            NumberInputField{
                id: costField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Cost:")
            }

            SecondaryButton{
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.preferredHeight: 35
                Layout.preferredWidth: 60
                btnText: qsTr("Clear")
                fontSize: 10
                onClicked: {
                    searchField.text = ""
                    orderIdField.text = ""
                    createdDateRangeField.clear()
                    deliveryDateRangeField.clear()
                    addressField.text = ""
                    statusField.clear()
                    costField.text = ""
                }
            }
        }
        OrdersTable{
            Layout.fillHeight: true
            Layout.fillWidth: true
            pagination : orderPagination

            onRowClicked: (recordId) => {
                pageRoot.rowClicked(recordId)
            }
            onOpenTab: (recordId) => {
                pageRoot.openTab(recordId)
            }
            onAddToDelivery: (recordId) => {
                pageRoot.addToDelivery(recordId)
            }
        }

        Pagination{
            id : orderPagination
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            rowCount: ordersFilterModel.rowCount()
            rowsPerPage : 15
        }
    }
}
