import QtQuick 2.15
import QtQuick.Layouts

import Colors
import Buttons
import InputFields
import Tables
import TabControls
import Utils
import Map
import Notifications

import TransportationsApp.Models 1.0

Item {
    property var orderModel : Order{}
    property bool requeredPremission : user.rolePriority > 1

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
                text: qsTr("Order") + " " + orderModel.orderId
            }

            SecondaryButton{
                Layout.preferredHeight: 30
                Layout.preferredWidth: 60
                contentColor: Themes.colors.primary.primary500
                btnText: qsTr("Save")
                visible: pageRoot.requeredPremission
                onClicked: {
                    var orderId = Number(orderIdField.text)
                    var askedDeliveryDate = DateUtils.strToDate(askedDeliveryDateField.text)
                    var statusId = Number(statusField.currentIndex)
                    var volume = Number(volumeField.text)
                    var weight = Number(weightField.text)
                    var address = addressField.text
                    var cost = Number(costField.text)
                    var updateSuccess = true
                    if(askedDeliveryDateField.text === ""){
                        askedDeliveryDateField.isError = true
                        updateSuccess = false
                    } else{
                        askedDeliveryDateField.isError = false
                    }
                    if(statusId===0){
                        statusField.isError = true
                        updateSuccess = false
                    } else{
                        statusField.isError = false
                    }
                    if(address === ""){
                        addressField.isError = true
                        updateSuccess = false
                    } else{
                        addressField.isError = false
                    }

                    if(!updateSuccess){
                        notificationManager.showNotification(
                            NotificationTypes.failure,
                            qsTr("Failed to update database")
                        );
                        return;
                    }

                    updateSuccess = ordersModel.updateOrder(orderId, askedDeliveryDate, statusId,
                                            address, volume, weight, cost);

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
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10
            z: 2
            ColumnLayout{
                Layout.fillHeight: true
                Layout.fillWidth: true
                NumberInputField{
                    id: orderIdField
                    Layout.fillWidth: true
                    readOnly: true
                    title: qsTr("Id:")
                    text: orderModel.orderId
                }
                DateInputField{
                    id: createdDateField
                    Layout.fillWidth: true
                    readOnly: true
                    title:  qsTr("Created date:")
                    text: DateUtils.formatDate(orderModel.createdDate)
                }
                DateInputField{
                    id: askedDeliveryDateField
                    Layout.fillWidth: true
                    readOnly: !requeredPremission
                    title:  qsTr("Delivery date:")
                    text: DateUtils.formatDate(orderModel.askedDeliveryDate)
                }
                ComboBoxInputField{
                    id: statusField
                    Layout.fillWidth: true
                    readOnly: requeredPremission
                    title:  qsTr("Status:")
                    model: ordersStatusModel
                    textRole: "StatusTitle"
                    currentIndex: orderModel.statusId
                }
            }
            ColumnLayout{
                Layout.fillHeight: true
                Layout.fillWidth: true
                NumberInputField{
                    id: volumeField
                    Layout.fillWidth: true
                    readOnly: !requeredPremission
                    title:  qsTr("Volume:")
                    text: orderModel.volume
                }
                NumberInputField{
                    id: weightField
                    Layout.fillWidth: true
                    readOnly: !requeredPremission
                    title:  qsTr("Weight:")
                    text: orderModel.weight
                }
                TextInputField{
                    id: addressField
                    Layout.fillWidth: true
                    readOnly: !requeredPremission
                    title:  qsTr("Address:")
                    text: orderModel.address
                }
                NumberInputField{
                    id: costField
                    Layout.fillWidth: true
                    readOnly: !requeredPremission
                    title:  qsTr("Cost:")
                    text: orderModel.cost
                }
            }
        }
        MapComponent{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.topMargin: 10
            z: 1
            startAddress: "Екатеринбург, улица " + orderModel.address
        }
    }

}
