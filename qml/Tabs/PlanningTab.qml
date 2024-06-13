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
    property var driverModel : Driver{}
    property var deliveryModel : Delivery{
        onCarIdChanged: {
            carModel.setRecord(carsModel.findRecord("CarId", carId))
        }
        onDriverIdChanged: {
            driverModel.setRecord(driversModel.findRecord("DriverId", driverId))
        }
        onDeliveryIdChanged: {
            deliveryOrderList.setDelivery(deliveryId);
        }
    }
    property var deliveryOrderList : DeliveryOrderList{}

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
                text: qsTr("Delivery ") + deliveryModel.deliveryId
            }

            SecondaryButton{
                Layout.preferredHeight: 30
                Layout.preferredWidth: 60
                contentColor: Themes.colors.primary.primary500
                btnText: "Save"
                onClicked: {
                    pageRoot.displayMap()
//                    var carId = Number(carIdField.text)
//                    var carType = carTypeField.text
//                    var carModel = carModelField.text
//                    var carNumber = carNumberField.text
//                    var volumeCapacity = Number(volumeCapacityField.text)
//                    var weightCapacity = Number(weightCapacityField.text)
//                    var drivingCategory = drivingCategoryField.currentText

//                    carsModel.updateCar(carId, carType, carModel,
//                                        carNumber, volumeCapacity,
//                                        weightCapacity, drivingCategory);
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
                    text: DateUtils.formatDate(deliveryModel.departureDate)
                }
                DateInputField{
                    id: returnDateField
                    Layout.fillWidth: true
                    z: 5
                    title: qsTr("Return date:")
                    text: DateUtils.formatDate(deliveryModel.returnDate)
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
                    text: deliveryModel.carId
                    onEditingFinished: {
                        var carId = carIdField.text ? Number(carIdField.text) : 0
                        carModel.setRecord(carsModel.findRecord("CarId", carId))
                    }
                }
                NumberInputField{
                    id: driverIdField
                    Layout.fillWidth: true
                    title:  qsTr("Driver id:")
                    text: deliveryModel.driverId
                    onEditingFinished: {
                        var driverId = driverIdField.text ? Number(driverIdField.text) : 0
                        driverModel.setRecord(driversModel.findRecord("DriverId", driverId))
                    }
                }
                ComboBoxInputField{
                    id: statusField
                    Layout.fillWidth: true
                    title:  qsTr("Status:")
                    model: ordersStatusModel
                    textRole: "StatusTitle"
                    currentIndex: deliveryModel.statusId
                }
            }
        }
        RowLayout{
            Layout.preferredHeight: 30
            Layout.fillWidth: true
            spacing: 10

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
//            CarsTable{
//                anchors.fill: parent
//                tableModel: [ carModel ]
//            }
            TableBase{
                id : carTableRoot
                anchors.fill: parent
                tableHeaders :  ["Id", "Type", "Model", "Car number", "Volume", "Weight", "Driving category"]
                tableModel : carModel
                tableRow:
                    Component{
                        TableRow{
                            Layout.fillWidth: true
                            deleteVisible: true
                            addToDeliveryVisible: false
                            model: [rowModel.carId, rowModel.carType, rowModel.carModel,
                                    rowModel.carNumber, rowModel.volumeCapacity,
                                    rowModel.weightCapacity, rowModel.drivingCategory]
                            onClicked: {
                                carTableRoot.rowClicked(rowModel.carId)
                            }
                            onDeleteClicked: {
                                deliveryModel.carId = 0
                            }
                        }
                    }
            }

        }

        RowLayout{
            Layout.preferredHeight: 30
            Layout.fillWidth: true
            spacing: 10

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
            TableBase{
                id : driverTableRoot
                anchors.fill: parent
                tableHeaders :  ["Id", "Last name", "First name", "Driving category", "Experience"]
                tableModel : driverModel
                tableRow:
                    Component{
                        TableRow{
                            Layout.fillWidth: true
                            deleteVisible: true
                            addToDeliveryVisible: false
                            model: [rowModel.driverId, rowModel.lastName, rowModel.firstName,
                                    rowModel.drivingCategory, rowModel.experience]
                            onClicked: {
                                driverTableRoot.rowClicked(rowModel.driverId)
                            }
                            onDeleteClicked: {
                                deliveryModel.driverId = 0
                            }
                        }
                    }
            }
        }

        RowLayout{
            Layout.preferredHeight: 30
            Layout.fillWidth: true
            spacing: 10

            Text{
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                font.pointSize: 14
                color: Themes.colors.neutral.neutral950
                text: qsTr("Orders in delivery")
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
            Layout.fillHeight: true
            Layout.fillWidth: true
            TableBase{
                id : tableRoot
                anchors.fill: parent
                tableHeaders :  ["Id", "Created date", "Delivery date", "Address", "Status", "Cost"]
                tableModel : deliveryOrderList.orderList
                tableRow:
                    Component{
                        TableRow{
                            Layout.fillWidth: true
                            addToDeliveryVisible: false
                            deleteVisible: true
                            model: [rowModel.modelData.orderId, rowModel.modelData.createdDate.toLocaleDateString("en_US"),
                                rowModel.modelData.askedDeliveryDate.toLocaleDateString("en_US"),
                                rowModel.modelData.address, rowModel.modelData.statusTitle, rowModel.modelData.cost]
                            onClicked: {
                                tableRoot.rowClicked(rowModel.orderId)
                            }
                            onDeleteClicked: {
                                deliveryOrderList.removeByIndex(rowIndex)
                            }
                        }
                    }
            }
        }

    }

}
