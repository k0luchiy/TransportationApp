import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

import Colors

Popup {
    property color bgColor : Themes.colors.neutral.neutral0
    property color bgCursonColor : Themes.colors.neutral.neutral100
    property color borderColor : Themes.colors.neutral.neutral200
    property color fontColor : Themes.colors.neutral.neutral900
    property int fontSize : 10
    property bool openTabVisible : true
    property bool addToDeliveryVisible : true
    property bool deleteVisible : false

    signal openTab
    signal addToDelivery
    signal deleteClicked

    id: popupRoot
    height: popupRoot.deleteVisible && popupRoot.addToDeliveryVisible ? 105 :
            popupRoot.deleteVisible || popupRoot.addToDeliveryVisible ? 70 : 35
    width: 120

    modal: false
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    margins: 0
    padding: 0

    background: Rectangle {
        id: filterRec
        anchors.fill: parent
        color: popupRoot.bgColor
        border.width: 1
        border.color: popupRoot.borderColor
    }

    contentItem: ColumnLayout{
        anchors.fill: parent
        anchors.margins: 1
        spacing: 0
        clip: true

        Rectangle{
            Layout.preferredHeight: 35
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            color: mouseArea.containsMouse ? popupRoot.bgCursonColor : popupRoot.bgColor
            visible: popupRoot.openTabVisible
            Text{
                anchors.fill: parent
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                verticalAlignment: Text.AlignVCenter
                font.pointSize: popupRoot.fontSize
                color: popupRoot.fontColor
                text: "Open in tab"
            }
            MouseArea{
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    popupRoot.openTab();
                    popupRoot.close()
                }
                cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
            }
        }
        Rectangle{
            Layout.preferredHeight: 35
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            color: addMouseArea.containsMouse ? popupRoot.bgCursonColor : popupRoot.bgColor
            visible: popupRoot.addToDeliveryVisible
            Text{
                anchors.fill: parent
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                verticalAlignment: Text.AlignVCenter
                font.pointSize: popupRoot.fontSize
                color: popupRoot.fontColor
                text: "Add to delivery"
            }
            MouseArea{
                id: addMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    popupRoot.addToDelivery();
                    popupRoot.close()
                }
                cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
            }
        }
        Rectangle{
            Layout.preferredHeight: 35
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            color: deleteMouseArea.containsMouse ? popupRoot.bgCursonColor : popupRoot.bgColor
            visible: popupRoot.deleteVisible

            Text{
                anchors.fill: parent
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                verticalAlignment: Text.AlignVCenter
                font.pointSize: popupRoot.fontSize
                color: Themes.colors.red.red500
                text: "Delete"
            }
            MouseArea{
                id: deleteMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    popupRoot.deleteClicked();
                    popupRoot.close()
                }
                cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
            }
        }
    }

}
