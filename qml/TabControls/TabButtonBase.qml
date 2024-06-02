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
    property bool iconVisible : false
    property int fontSize : 12
    property int iconSize : 15
    property int tabNum: 1
    property var connectedStack

    id: btnRoot
    checked: false
    width: 105
    height: 40
    text: "Order"

    background: Rectangle{
        implicitWidth: btnRoot.width
        implicitHeight: btnRoot.height
        //anchors.fill: parent
        color: btnRoot.bgColor
    }

    contentItem:
        ColumnLayout {
        anchors.fill: parent
        spacing: 0

        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 3

            IconButton{
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                iconSize: btnRoot.iconSize
                iconSource: "qrc:/assets/icons/Outline/close.svg"
                iconColor: btnRoot.checked ? btnRoot.contentActiveColor : btnRoot.contentDefaultColor
//                onClicked: {
//                    console.log("Close clicked in tab ", btnRoot.tabNum,  tabBar.count)
//                    var itemNum = btnRoot.tabNum - 1 //carStackView.children.length
//                    connectedStack.children[itemNum].destroy()
//                    //carStackView.children[itemNum].destroy()
//                    tabBar.removeItem(btnRoot)
//                    for(var i= itemNum; i <= tabBar.count; ++i){
//                        tabBar.itemAt(i).tabNum -= 1
//                    }
//                    btnRoot.closeClicked()
//                }
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
            Layout.rightMargin: 1
            Layout.leftMargin: 1
            color: btnRoot.checked ? btnRoot.contentActiveColor : "transparent"
        }
    }

}
