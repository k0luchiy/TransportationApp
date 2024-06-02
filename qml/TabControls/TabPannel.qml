import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

import Colors

TabBar {
    id: tabBar
    width: 500
    contentWidth: 500
    height: 50


    background: Rectangle{
        anchors.fill: parent
        color: Colors.elementary.transparent
    }

    contentItem:
        Item{
        anchors.fill: parent
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        ColumnLayout{
            anchors.fill: parent
            ListView {
                id: listView
                z: 2
                spacing: 10
                Layout.fillHeight: true
                Layout.fillWidth: true
                boundsMovement: Flickable.StopAtBounds
                model: tabBar.contentModel
                currentIndex: tabBar.currentIndex
                contentHeight: 40
                orientation: ListView.Horizontal
                boundsBehavior: Flickable.StopAtBounds
                delegate: TabButtonBase{
                    text: "Order "
                }
            }
            Rectangle{
                Layout.preferredHeight: 2
                Layout.fillWidth: true
                color: Themes.colors.neutral.neutral400
            }
        }
    }
}

