import QtQuick 2.15
import QtQuick.Layouts

import Colors
import Buttons
import InputFields
import Tables
import TabControls
import Utils
import Notifications

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
        onDepartureDateChanged: {
            departureDateField.text = DateUtils.formatDate(deliveryModel.departureDate)
            departureDateField.isError = false
        }
        onReturnDateChanged: {
            returnDateField.text = DateUtils.formatDate(deliveryModel.returnDate)
            returnDateField.isError = false
        }
    }
    property var deliveryOrderList : DeliveryOrderList{ }

    id: pageRoot
    height: 800
    width: 1040

    ColumnLayout{
        anchors.fill: parent
        spacing: 10

        RowLayout{
            Layout.preferredHeight: 30
            Layout.fillWidth: true
            spacing: 10

            Text{
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                font.pointSize: 14
                color: Themes.colors.neutral.neutral950
                text: (deliveryModel.deliveryId ?
                           qsTr("Delivery") + " " + deliveryModel.deliveryId :
                           qsTr("None deliveries selected"))
            }

            SecondaryButton{
                Layout.preferredHeight: 30
                Layout.preferredWidth: 60
                contentColor: Themes.colors.primary.primary500
                btnText: qsTr("+ New")
                onClicked: {
                    var deliveryId = deliveriesModel.createDelivery(user.userId)
                    deliveryModel.setRecord(deliveriesModel.findRecord("DeliveryId", deliveryId))
                }
            }

            SecondaryButton{
                Layout.preferredHeight: 30
                Layout.preferredWidth: 60
                contentColor: Themes.colors.primary.primary500
                btnText: qsTr("Save")
                onClicked: {
                    var updateSuccess = true
                    if(deliveryModel.carId===0){
                        carIdField.isError = true
                        updateSuccess = false
                    } else{
                        carIdField.isError = false
                    }
                    if(deliveryModel.driverId===0){
                        driverIdField.isError = true
                        updateSuccess = false
                    } else{
                        driverIdField.isError = false
                    }
                    if(departureDateField.text===""){
                        departureDateField.isError = true
                        updateSuccess = false
                    } else{
                        departureDateField.isError = false
                    }
                    if(returnDateField.text===""){
                        returnDateField.isError = true
                        updateSuccess = false
                    } else{
                        returnDateField.isError = false
                    }
                    if(statusField.currentIndex===0){
                        statusField.isError = true
                        updateSuccess = false
                    } else{
                        statusField.isError = false
                    }


                    if(!updateSuccess){
                        notificationManager.showNotification(
                            NotificationTypes.failure,
                            qsTr("Failed to update database")
                        );
                        return;
                    }

                    updateSuccess &= deliveryModel.save()
                    updateSuccess &= deliveryOrderList.save()

                    if(updateSuccess){
                        notificationManager.showNotification(
                            NotificationTypes.success,
                            qsTr("Database record successfully updated")
                        );
                    }
                }
            }
        }
        RowLayout{
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10
            z: 5
            ColumnLayout{
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillHeight: true
                Layout.fillWidth: true
                NumberInputField{
                    id: deliveryIdField
                    Layout.fillWidth: true
                    readOnly: true
                    title: qsTr("Id:")
                    placeholderText: ""
                    text: deliveryModel.deliveryId === 0 ? "" : deliveryModel.deliveryId
                }
                DateInputField{
                    id: departureDateField
                    Layout.fillWidth: true
                    z: 10
                    title: qsTr("Departure date:")
                    text: DateUtils.formatDate(deliveryModel.departureDate)
                    onSelectedDateChanged: {
                        deliveryModel.departureDate = departureDateField.selectedDate
                        departureDateField.isError = false
                    }
                }
                DateInputField{
                    id: returnDateField
                    Layout.fillWidth: true
                    z: 5
                    title: qsTr("Return date:")
                    text: DateUtils.formatDate(deliveryModel.returnDate)
                    onSelectedDateChanged: {
                        deliveryModel.returnDate = returnDateField.selectedDate
                        returnDateField.isError = false
                    }
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
                    placeholderText: ""
                    text: deliveryModel.carId === 0 ? "" : deliveryModel.carId
                    onEditingFinished: {
                        var carId = carIdField.text ? Number(carIdField.text) : 0
                        deliveryModel.carId = carId
                        carIdField.isError = false
                    }
                }
                NumberInputField{
                    id: driverIdField
                    Layout.fillWidth: true
                    title:  qsTr("Driver id:")
                    placeholderText: ""
                    text: deliveryModel.driverId === 0 ? "" : deliveryModel.driverId
                    onEditingFinished: {
                        var driverId = driverIdField.text ? Number(driverIdField.text) : 0
                        deliveryModel.driverId = driverId
                        driverIdField.isError = false
                    }
                }
                ComboBoxInputField{
                    id: statusField
                    Layout.fillWidth: true
                    title:  qsTr("Status:")
                    model: ordersStatusModel
                    textRole: "StatusTitle"
                    currentIndex: deliveryModel.statusId
                    onCurrentIndexChanged: {
                        deliveryModel.statusId = statusField.currentIndex
                        deliveryModel.statusTitle = statusField.currentText
                        statusField.isError = false
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
                text: qsTr("Car")
            }

            SecondaryButton{
                Layout.preferredHeight: 30
                Layout.preferredWidth: 110
                fontSize: 10
                iconLeftVisible: true
                iconLeftSource: "qrc:/assets/icons/Outline/book-open.svg"
                btnText: qsTr("Watch all")
                onClicked: {
                    carPage.tabIndex = 0
                    leftMenuTabPannel.currentIndex = 1
                }
            }
            SecondaryButton{
                Layout.preferredHeight: 30
                Layout.preferredWidth: 155
                fontSize: 10
                iconLeftVisible: true
                iconLeftSource: "qrc:/assets/icons/Outline/search.svg"
                btnText: qsTr("Add automaticly")
                onClicked: {
                    var departureDate = departureDateField.selectedDate
                    deliveryModel.carId = deliveryModel.findCar(departureDate)
                }
            }
        }

        Item{
            Layout.preferredHeight: 85
            Layout.fillWidth: true

            TableBase{
                id : carTableRoot
                anchors.fill: parent
                tableHeaders :  [qsTr("Id"), qsTr("Type"), qsTr("Model"),
                    qsTr("Car number"), qsTr("Volume"), qsTr("Weight"), qsTr("Driving category")]
                tableModel : carModel
                modelEmpty : carModel.carId === 0
                headerIconVisible: false
                headerEnabled: false
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
                            onOpenTab: {
                                carPage.addInfoTab(rowModel.carId)
                                leftMenuTabPannel.currentIndex = 1
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
                onClicked: {
                    driverPage.tabIndex = 0
                    leftMenuTabPannel.currentIndex = 2
                }
            }
            SecondaryButton{
                Layout.preferredHeight: 30
                Layout.preferredWidth: 155
                fontSize: 10
                iconLeftVisible: true
                iconLeftSource: "qrc:/assets/icons/Outline/search.svg"
                btnText: qsTr("Add automaticly")
                onClicked: {
                    var departureDate = departureDateField.selectedDate
                    deliveryModel.driverId = deliveryModel.findCar(departureDate)
                }
            }
        }

        Item{
            Layout.preferredHeight: 85
            Layout.fillWidth: true
            TableBase{
                id : driverTableRoot
                anchors.fill: parent
                tableHeaders :  [qsTr("Id"), qsTr("Last name"), qsTr("First name"),
                    qsTr("Driving category"), qsTr("Experience")]
                headerIconVisible: false
                headerEnabled: false
                tableModel : driverModel
                modelEmpty : driverModel.driverId === 0
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
                            onOpenTab: {
                                driverPage.addInfoTab(rowModel.driverId)
                                leftMenuTabPannel.currentIndex = 2
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
                onClicked: {
                    orderPage.tabIndex = 0
                    leftMenuTabPannel.currentIndex = 0
                }
            }
        }

        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
            TableBase{
                id : ordersTableRoot
                anchors.fill: parent
                tableHeaders :  [qsTr("Id"), qsTr("Created date"), qsTr("Delivery date"),
                    qsTr("Address"), qsTr("Status"), qsTr("Cost")]
                headerIconVisible: false
                headerEnabled: false
                tableModel : deliveryOrderList.orderList
                modelEmpty : deliveryOrderList.orderList.length === 0
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
                                ordersTableRoot.rowClicked(rowModel.orderId)
                            }
                            onOpenTab: {
                                orderPage.addInfoTab(rowModel.modelData.orderId)
                                leftMenuTabPannel.currentIndex = 0
                            }
                            onDeleteClicked: {
                                deliveryOrderList.removeByIndex(rowIndex)
                                deliveryOrderListChanged()
                            }
                        }
                    }
            }
        }

    }

}
