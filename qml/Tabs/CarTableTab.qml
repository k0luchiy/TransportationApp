import QtQuick 2.15
import QtQuick.Layouts

import Colors
import Buttons
import InputFields
import Tables
import TabControls

Item {
    property bool requeredPremission : user.rolePriority > 1

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
                    var carId = Number(searchText.replace(/\D/g, ""))
                    carsFilterModel.setFilterCarId(carId)
                }
            }
            PrimaryButton{
                Layout.preferredWidth: 95
                Layout.preferredHeight: 35
                btnText: qsTr("Filter")
                iconLeftVisible: true
                iconLeftSource: "qrc:/assets/icons/Outline/filter.svg"

                onClicked: {
                    var carId = carIdField.text ? Number(carIdField.text) : 0
                    var carType = carTypeField.text
                    var carModel = carModelField.text
                    var carNumber = carNumberField.text
                    var volumeCapacity = volumeCapacityField.text ? Number(volumeCapacityField.text) : 0
                    var weightCapacity = weightCapacityField.text ? Number(weightCapacityField.text) : 0
                    var drivingCategory = drivingCategoryField.currentText

                    carsFilterModel.setFilters(
                        carId, carType, carModel,
                        carNumber, volumeCapacity,
                        weightCapacity, drivingCategory
                    );
                }
            }
        }

        RowLayout{
            Layout.preferredHeight: 60
            Layout.fillWidth: true
            spacing: 10
            z: 10

            NumberInputField{
                id: carIdField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Id:")
            }
            TextInputField{
                id: carTypeField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Type:")
            }
            TextInputField{
                id: carModelField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Model:")
            }
            TextInputField{
                id: carNumberField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Car number:")
            }
            NumberInputField{
                id: volumeCapacityField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Volume:")
            }
            NumberInputField{
                id: weightCapacityField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Weight:")
            }
            ComboBoxInputField{
                id: drivingCategoryField
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                title: qsTr("Driving category:")
                model: drivingCatefories
                textRole: "CategoryName"
            }

            SecondaryButton{
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.preferredHeight: 35
                Layout.preferredWidth: 60
                btnText: qsTr("Clear")
                fontSize: 10
                onClicked: {
                    searchField.text = ""
                    carIdField.text = ""
                    carTypeField.text = ""
                    carModelField.text = ""
                    carNumberField.text = ""
                    volumeCapacityField.text = ""
                    weightCapacityField.text = ""
                    drivingCategoryField.clear()
                }
            }
        }

        CarsTable{
            Layout.fillHeight: true
            Layout.fillWidth: true
            pagination : carPagination

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
            id : carPagination
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            rowCount: carsFilterModel.rowCount()
            rowsPerPage : 15
        }
    }
}
