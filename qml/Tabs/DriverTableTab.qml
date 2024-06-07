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
                    var driverId = Number(searchText.replace(/\D/g, ""))
                    driversFilterModel.setFilterDriverId(driverId)
                }
            }
            PrimaryButton{
                Layout.preferredWidth: 95
                Layout.preferredHeight: 35
                btnText: "Filter"
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

                    driversFilterModel.setFilters(
                        orderId, minCreatedDate, maxCreatedDate,
                        minDeliveryDate, maxDeliveryDate,
                        address, statusTitle, cost
                    );
                    driverPagination.rowCount = driversFilterModel.rowCount()
                }
            }
        }

        RowLayout{
            Layout.preferredHeight: 60
            Layout.fillWidth: true
            spacing: 10
            z: 10

            NumberInputField{
                id: driverIdField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Id:")
            }
            TextInputField{
                id: lastNameField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Last name:")
            }
            TextInputField{
                id: firstNameField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("First name:")
            }
            ComboBoxInputField{
                id: drivingCategoryField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Driving category:")
                model: drivingCatefories
                textRole: "CategoryName"
            }
            NumberInputField{
                id: experienceField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Experience:")
            }

            SecondaryButton{
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.preferredHeight: 35
                Layout.preferredWidth: 60
                btnText: "Clear"
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
        DriversTable{
            Layout.fillHeight: true
            Layout.fillWidth: true
            pagination : driverPagination

            onRowClicked: (recordId) => {
                pageRoot.rowClicked(recordId)
            }
        }

        Pagination{
            id : driverPagination
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            rowCount: driversFilterModel.rowCount()
            rowsPerPage : 5
        }
    }
}