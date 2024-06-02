import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import Colors
import Buttons

TabButton {
    property url iconSource:  "qrc:/Icons/close_icon.png"
    //property color btnActiveColor: "#0066FF"
    //property color btnDefaultColor: "transparent"//"#F4F5F7"
    property color bgColor : Colors.elementary.transparent
    property color contentActiveColor: Themes.colors.primary.primary600
    property color contentDefaultColor: Themes.colors.neutral.neutral600
    property bool iconVisible : true
    property int fontSize : 12
    property int iconSize : 15
    property int tabNum: 1
    property var connectedStack
    property var connectedTabPannel

    signal removeTab(int index)

    id: btnRoot
    checked: false
    width: 105
    height: 40
    implicitHeight: 40
    implicitWidth: 105
    text: "Order"
    z: 2

    background: Rectangle{
        implicitWidth: btnRoot.width
        implicitHeight: btnRoot.height
        //anchors.fill: parent
        color: btnRoot.bgColor
    }

    contentItem:
        Item{
            anchors.fill: parent
            ColumnLayout {
            anchors.fill: parent
            spacing: 0

            RowLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.leftMargin: 0
                spacing: 3

                IconButton{
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    visible: btnRoot.iconVisible
                    iconSize: btnRoot.iconSize
                    iconSource: "qrc:/assets/icons/Outline/close.svg"
                    iconColor: btnRoot.checked ? btnRoot.contentActiveColor : btnRoot.contentDefaultColor
                    onClicked: {
                        //removeTab(index)
                        //tabBar.removeTab(index)
                    }
//                    onClicked: {
//                        console.log("Close clicked in tab ", btnRoot.tabNum,  connectedTabPannel.count)
//                        var itemNum = btnRoot.tabNum - 1 //carStackView.children.length
//                        //connectedStack.children[itemNum].destroy()
//                        connectedTabPannel.removeItem(btnRoot)
//                        for(var i= itemNum; i <= connectedTabPannel.count; ++i){
//                            connectedTabPannel.itemAt(i).tabNum -= 1
//                        }
////                        connectedTabPannel.removeItem(connectedTabPannel.itemAt(tabNum-1))
//                        btnRoot.closeClicked()
//                    }
                }

                Text {
                    text: btnRoot.text
                    color: btnRoot.checked ? btnRoot.contentActiveColor : btnRoot.contentDefaultColor
                    verticalAlignment: Text.AlignVCenter
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: false
                    font.pointSize: btnRoot.fontSize
                }
            }

            Rectangle {
                height: 2
                Layout.preferredHeight: 2
                Layout.fillWidth: true
//                Layout.leftMargin: 5
//                Layout.rightMargin: 5
                radius: 5
                color: btnRoot.checked ? btnRoot.contentActiveColor : "transparent"
            }
        }
    }

}
