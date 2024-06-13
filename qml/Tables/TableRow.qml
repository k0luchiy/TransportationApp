import QtQuick 2.15
import QtQuick.Layouts

import Colors
import Buttons

Item {
    property color bgColor : Themes.colors.elementary.transparent
    property color contentColor : Themes.colors.neutral.neutral700
    property color dividerColor : Themes.colors.neutral.neutral200
    property int fontSize : 9
    property bool openTabVisible : true
    property bool addToDeliveryVisible : true
    property bool deleteVisible : false
    property var model

    signal clicked
    signal openTab
    signal addToDelivery
    signal deleteClicked

    id : rowRoot
    width: 200
    height: 40

    ColumnLayout{
        anchors.fill: parent
        spacing: 0

        RowLayout {
            Layout.fillWidth: true
            spacing: 0

            Item{
                Layout.fillHeight: true
                Layout.fillWidth: true

                RowLayout {
                    id: cell
                    anchors.fill: parent
                    spacing: 0
                    Repeater {
                        Layout.fillWidth: true
                        model: rowRoot.model
                        TableCell {
                            Layout.fillWidth: true
                            text: modelData
                        }
                    }
                }

                MouseArea{
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    enabled: rowRoot.enabled
                    onClicked: {
                        rowRoot.clicked();
                    }
                    cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                }
            }

            Item{
                id: item1
                Layout.preferredHeight: 40
                Layout.preferredWidth: 60

                IconButton{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    iconSource: "qrc:/assets/icons/Outline/dots-vertical.svg"
                    iconSize: 15
                    onClicked: {
                        additionalPanel.open()
                    }
                }
            }
        }

        Rectangle{
            Layout.fillWidth: true
            height: 1
            color: rowRoot.dividerColor
        }
        AdditionalPannel{
            id: additionalPanel
            x: rowRoot.width - width - 5
            y: rowRoot.height+2
            openTabVisible: rowRoot.openTabVisible
            addToDeliveryVisible: rowRoot.addToDeliveryVisible
            deleteVisible: rowRoot.deleteVisible

            onOpenTab: {
                rowRoot.openTab()
            }
            onAddToDelivery: {
                rowRoot.addToDelivery()
            }
            onDeleteClicked: {
                rowRoot.deleteClicked()
            }
        }
    }
}
