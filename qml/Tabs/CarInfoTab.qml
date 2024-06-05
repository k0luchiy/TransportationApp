import QtQuick 2.15
import QtQuick.Layouts

import Colors
import Buttons
import InputFields
import Tables
import TabControls
import Utils

import TransportationsApp.Models 1.0

Item {
    property var carModel : Car{}

    id: pageRoot
    height: 800
    width: 1040

    ColumnLayout{
        anchors.fill: parent

        RowLayout{
            Layout.preferredHeight: 30
            Layout.fillWidth: true

            Text{
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                font.pointSize: 14
                color: Themes.colors.neutral.neutral950
                text: qsTr("Car ") + carModel.carNumber
            }

            SecondaryButton{
                Layout.preferredHeight: 30
                Layout.preferredWidth: 60
                contentColor: Themes.colors.primary.primary500
                btnText: "Save"
                onClicked: {
                    var carId = Number(carIdField.text)
                    var carType = carTypeField.text
                    var carModel = carModelField.text
                    var carNumber = carNumberField.text
                    var volumeCapacity = Number(volumeCapacityField.text)
                    var weightCapacity = Number(weightCapacityField.text)
                    var drivingCategory = drivingCategoryField.currentText

                    carsModel.updateCar(carId, carType, carModel,
                                        carNumber, volumeCapacity,
                                        weightCapacity, drivingCategory);
                }
            }
        }
        RowLayout{
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10
            ColumnLayout{
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillHeight: true
                Layout.fillWidth: true
                NumberInputField{
                    id: carIdField
                    Layout.fillWidth: true
                    title: qsTr("Id:")
                    text: carModel.carId
                }
                TextInputField{
                    id: carTypeField
                    Layout.fillWidth: true
                    title: qsTr("Type:")
                    text: carModel.carType
                }
                TextInputField{
                    id: carModelField
                    Layout.fillWidth: true
                    title: qsTr("Model:")
                    text: carModel.carModel
                }
                TextInputField{
                    id: carNumberField
                    Layout.fillWidth: true
                    title: qsTr("Car number:")
                    text: carModel.carNumber
                }
            }
            ColumnLayout{
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillHeight: true
                Layout.fillWidth: true
                NumberInputField{
                    id: volumeCapacityField
                    Layout.fillWidth: true
                    title:  qsTr("Volume capacity:")
                    text: carModel.volumeCapacity
                }
                NumberInputField{
                    id: weightCapacityField
                    Layout.fillWidth: true
                    title:  qsTr("Weight capacity:")
                    text: carModel.weightCapacity
                }
                ComboBoxInputField{
                    id: drivingCategoryField
                    Layout.fillWidth: true
                    title:  qsTr("Driving category:")
                    model: drivingCatefories
                    textRole: "CategoryName"
                    currentIndex: drivingCategoryField.findIndex(carModel.drivingCategory)
                }
            }
        }
        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

}
