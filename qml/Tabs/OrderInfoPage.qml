import QtQuick 2.15
import QtQuick.Layouts

import Colors
import Buttons
import InputFields
import Tables
import TabControls

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
                    Layout.fillWidth: true
                    title: qsTr("Id:")
                    text: orderModel.orderId
                }
                DateInputField{
                    Layout.fillWidth: true
                    title:  qsTr("Created date:")
                    text: orderModel.createdDate
                }
                DateInputField{
                    Layout.fillWidth: true
                    title:  qsTr("Delivery date:")
                    text: orderModel.askedDeliveryDate
                }
                ComboBoxInputField{
                    Layout.fillWidth: true
                    title:  qsTr("Status:")
                }
            }
            ColumnLayout{
                Layout.fillHeight: true
                Layout.fillWidth: true
                NumberInputField{
                    Layout.fillWidth: true
                    title:  qsTr("Volume:")
                    text: orderModel.volume
                }
                NumberInputField{
                    Layout.fillWidth: true
                    title:  qsTr("Weight:")
                    text: orderModel.weight
                }
                TextInputField{
                    Layout.fillWidth: true
                    title:  qsTr("Address:")
                    text: orderModel.address
                }
                NumberInputField{
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
