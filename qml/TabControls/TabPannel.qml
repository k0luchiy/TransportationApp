import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

import Colors

TabBar {
    property alias mainTabText : mainTabButton.text

    id: tabBar
    width: 500
    contentWidth: 500
    height: 50

    TabButtonBase {
        id: mainTabButton
        text: "Orders"
        checked: true
    }

    background: Rectangle{
        anchors.fill: parent
        color: Colors.elementary.transparent
    }

    contentItem: ListView {
        id: listView
        anchors.fill: parent
        boundsMovement: Flickable.StopAtBounds
        model: tabBar.contentModel
        currentIndex: tabBar.currentIndex
        contentHeight: 40
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
    }
}

