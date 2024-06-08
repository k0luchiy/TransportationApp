import QtQuick 2.15
import QtQuick.Layouts

import Colors
import Buttons
import InputFields
import Tables
import TabControls

Item {
    signal rowClicked(recordId : int)

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
                placeholderText: "Search..."
                iconLeftVisible: true
                iconLeftSource: "qrc:/assets/icons/Outline/search.svg"

                onEditingFinished: {
                    var searchText = searchField.text
                    var deliveryId = Number(searchText.replace(/\D/g, ""))
                    deliveriesFilterModel.setFilterDeliveryId(deliveryId)
                }
            }
            PrimaryButton{
                Layout.preferredWidth: 95
                Layout.preferredHeight: 35
                btnText: "Filter"
                iconLeftVisible: true
                iconLeftSource: "qrc:/assets/icons/Outline/filter.svg"

                onClicked: {
                    var deliveryId = deliveryIdField.text ? Number(deliveryIdField.text) : 0
                    var carNumber= carNumberField.text
                    var driverName = driverNameField.text
                    var minDepartureDate = departureDateRangeField.startDate
                    var maxDepartureDate = departureDateRangeField.endDate
                    var minReturnDate = returnDateRangeField.startDate
                    var maxReturnDate = returnDateRangeField.endDate
                    var statusTitle = statusField.currentText

                    deliveriesFilterModel.setFilters(
                        deliveryId, carNumber, driverName,
                        minDepartureDate, maxDepartureDate,
                        minReturnDate, maxReturnDate, statusTitle
                    );
                    deliveryPagination.rowCount = deliveriesFilterModel.rowCount()
                }
            }
        }

        RowLayout{
            Layout.preferredHeight: 60
            Layout.fillWidth: true
            spacing: 10
            z: 10

            NumberInputField{
                id: deliveryIdField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Id:")
            }
            TextInputField{
                id: carNumberField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Car number:")
            }
            TextInputField{
                id: driverNameField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Driver name:")
            }
            DateRangeInputField{
                id: departureDateRangeField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                z: 10
                title: qsTr("Departure date:")
            }
            DateRangeInputField{
                id: returnDateRangeField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Return date:")
            }
            ComboBoxInputField{
                id: statusField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Status:")
                model: ordersStatusModel
                textRole: "StatusTitle"
            }

            SecondaryButton{
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.preferredHeight: 35
                Layout.preferredWidth: 60
                btnText: "Clear"
                fontSize: 10
                onClicked: {
                    searchField.text = ""
                    deliveryIdField.text = ""
                    carNumberField.text = ""
                    driverNameField.text = ""
                    departureDateRangeField.clear()
                    returnDateRangeField.clear()
                    statusField.clear()
                }
            }
        }
        DeliveriesTable{
            Layout.fillHeight: true
            Layout.fillWidth: true
            pagination : deliveryPagination

            onRowClicked: (recordId) => {
                pageRoot.rowClicked(recordId)
            }
        }

        Pagination{
            id : deliveryPagination
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            rowCount: deliveriesFilterModel.rowCount()
            rowsPerPage : 5
        }
    }
}
