import QtQuick 2.15
import QtQuick.Layouts

import Colors
import Buttons
import InputFields
import Tables
import TabControls

Item {
    property var order

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
                text: "Order 1"
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
                    title: "Id:"
                }
                DateInputField{
                    Layout.fillWidth: true
                    title: "Created date:"
                }
                DateInputField{
                    Layout.fillWidth: true
                    title: "Delivery date:"
                }
                ComboBoxInputField{
                    Layout.fillWidth: true
                    title: "Status:"
                }
            }
            ColumnLayout{
                Layout.fillHeight: true
                Layout.fillWidth: true
                NumberInputField{
                    Layout.fillWidth: true
                    title: "Volume:"
                }
                NumberInputField{
                    Layout.fillWidth: true
                    title: "Weight:"
                }
                TextInputField{
                    Layout.fillWidth: true
                    title: "Address:"
                }
                NumberInputField{
                    Layout.fillWidth: true
                    title: "Cost:"
                }
            }
        }
        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

}
