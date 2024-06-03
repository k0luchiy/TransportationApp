import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

import Colors

TabBar {
    id: tabBarRoot
    width: 500
    contentWidth: 500
    height: 50

    background: Rectangle{
        anchors.fill: parent
        color: Colors.elementary.transparent
    }

    function addTab(title, iconVisible = true, checked = false){
        var component = Qt.createComponent("TabButtonBase.qml")
        var tab    = tabButton.createObject(tabBarRoot)
        tab.text = "Order 1"
        tab.iconVisible = iconVisible
        tab.checked = checked
        tab.closed.connect(()=>{tabBarRoot.removeItem(tab)})
        tabBarRoot.addItem(tab)
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
                model: tabBarRoot.contentModel
                currentIndex: tabBarRoot.currentIndex
                contentHeight: 40
                orientation: ListView.Horizontal
                boundsBehavior: Flickable.StopAtBounds
            }
            Rectangle{
                Layout.preferredHeight: 2
                Layout.fillWidth: true
                color: Themes.colors.neutral.neutral400
            }
        }
    }
}

