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
    //property var deliveryModel : Delivery{}

    id: pageRoot
    height: 800
    width: 1040

    ColumnLayout{
        anchors.fill: parent
        spacing: 10

        RowLayout{
            Layout.preferredHeight: 30
            Layout.fillWidth: true

            Text{
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                font.pointSize: 14
                color: Themes.colors.neutral.neutral950
                text: qsTr("Delivery ") + carModel.carNumber
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
                    id: deliveryIdField
                    Layout.fillWidth: true
                    readOnly: true
                    title: qsTr("Id:")
                    text: "1"
                }
                DateInputField{
                    id: departureDateField
                    Layout.fillWidth: true
                    z: 5
                    title: qsTr("Departure date:")
                }
                DateInputField{
                    id: returnDateField
                    Layout.fillWidth: true
                    z: 5
                    title: qsTr("Return date:")
                }
            }
            ColumnLayout{
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillHeight: true
                Layout.fillWidth: true
                NumberInputField{
                    id: carIdField
                    Layout.fillWidth: true
                    title:  qsTr("Car id:")
                    text: "1"
                }
                NumberInputField{
                    id: driverIdField
                    Layout.fillWidth: true
                    title:  qsTr("Driver id:")
                    text: "1"
                }
                ComboBoxInputField{
                    id: statusField
                    Layout.fillWidth: true
                    title:  qsTr("Status:")
                    model: ordersStatusModel
                    textRole: "StatusTitle"
                    currentIndex: orderModel.statusId
                }
            }
        }
        RowLayout{
            Layout.preferredHeight: 30
            Layout.fillWidth: true

            Text{
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                font.pointSize: 14
                color: Themes.colors.neutral.neutral950
                text: qsTr("Car ")
            }

            SecondaryButton{
                Layout.preferredHeight: 30
                Layout.preferredWidth: 110
                fontSize: 10
                iconLeftVisible: true
                iconLeftSource: "qrc:/assets/icons/Outline/book-open.svg"
                btnText: qsTr("Watch all")
            }
            SecondaryButton{
                Layout.preferredHeight: 30
                Layout.preferredWidth: 155
                fontSize: 10
                iconLeftVisible: true
                iconLeftSource: "qrc:/assets/icons/Outline/search.svg"
                btnText: qsTr("Add automaticly")
            }
        }

        Item{
            Layout.preferredHeight: 85
            Layout.fillWidth: true
            CarsTable{
                anchors.fill: parent
            }
        }

        RowLayout{
            Layout.preferredHeight: 30
            Layout.fillWidth: true

            Text{
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                font.pointSize: 14
                color: Themes.colors.neutral.neutral950
                text: qsTr("Driver ")
            }

            SecondaryButton{
                Layout.preferredHeight: 30
                Layout.preferredWidth: 110
                fontSize: 10
                iconLeftVisible: true
                iconLeftSource: "qrc:/assets/icons/Outline/book-open.svg"
                btnText: qsTr("Watch all")
            }
            SecondaryButton{
                Layout.preferredHeight: 30
                Layout.preferredWidth: 155
                fontSize: 10
                iconLeftVisible: true
                iconLeftSource: "qrc:/assets/icons/Outline/search.svg"
                btnText: qsTr("Add automaticly")
            }
        }

        Item{
            Layout.preferredHeight: 85
            Layout.fillWidth: true
            CarsTable{
                anchors.fill: parent
            }
        }

        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

}
