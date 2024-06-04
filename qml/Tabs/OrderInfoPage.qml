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
    property var orderModel : Order{}

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
                text: qsTr("Order ") + orderModel.orderId
            }

            SecondaryButton{
                Layout.preferredHeight: 30
                Layout.preferredWidth: 60
                contentColor: Themes.colors.primary.primary500
                btnText: "Save"
                onClicked: {
                    var orderId = Number(orderIdField.text)
                    var createdDate = createdDateField.text
                    var askedDeliveryDate = askedDeliveryDateField.text
                    var statusId = Number(statusField.currentIndex)
                    var volume = Number(volumeField.text)
                    var weight = Number(weightField.text)
                    var address = addressField.text
                    var cost = Number(costField.text)

                    console.log(orderId, createdDate, askedDeliveryDate, statusId, volume, weight, address, cost)
                }
            }
        }
        RowLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10
            ColumnLayout{
                Layout.fillHeight: true
                Layout.fillWidth: true
                NumberInputField{
                    id: orderIdField
                    Layout.fillWidth: true
                    title: qsTr("Id:")
                    text: orderModel.orderId
                }
                DateInputField{
                    id: createdDateField
                    Layout.fillWidth: true
                    title:  qsTr("Created date:")
                    text: DateUtils.formatDate(orderModel.createdDate)
                }
                DateInputField{
                    id: askedDeliveryDateField
                    Layout.fillWidth: true
                    title:  qsTr("Delivery date:")
                    text: DateUtils.formatDate(orderModel.askedDeliveryDate)
                }
                ComboBoxInputField{
                    id: statusField
                    Layout.fillWidth: true
                    title:  qsTr("Status:")
                }
            }
            ColumnLayout{
                Layout.fillHeight: true
                Layout.fillWidth: true
                NumberInputField{
                    id: volumeField
                    Layout.fillWidth: true
                    title:  qsTr("Volume:")
                    text: orderModel.volume
                }
                NumberInputField{
                    id: weightField
                    Layout.fillWidth: true
                    title:  qsTr("Weight:")
                    text: orderModel.weight
                }
                TextInputField{
                    id: addressField
                    Layout.fillWidth: true
                    title:  qsTr("Address:")
                    text: orderModel.address
                }
                NumberInputField{
                    id: costField
                    Layout.fillWidth: true
                    title:  qsTr("Cost:")
                    text: orderModel.cost
                }
            }
        }
        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

}
