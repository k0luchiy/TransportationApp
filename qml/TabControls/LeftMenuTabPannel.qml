import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

import Colors

TabBar {
    id: tabBar
    width: 200
    contentWidth: 200
    height: 500
    background: Rectangle{
        anchors.fill: parent
        color: Colors.elementary.transparent
    }

    LeftMenuTabButton{
        text: "Orders"
        anchors.left: parent.left
        anchors.right: parent.right
        iconSource: "qrc:/assets/icons/Outline/clipboard-list.svg"
    }

    LeftMenuTabButton{
        text: "Cars"
        anchors.left: parent.left
        anchors.right: parent.right
        iconSource: "qrc:/assets/icons/Outline/truck.svg"
    }

    LeftMenuTabButton{
        text: "Drivers"
        anchors.left: parent.left
        anchors.right: parent.right
        iconSource: "qrc:/assets/icons/Outline/identification.svg"
    }

    LeftMenuTabButton{
        text: "Deliveries"
        anchors.left: parent.left
        anchors.right: parent.right
        iconSource: "qrc:/assets/icons/Outline/cube.svg"
    }

    LeftMenuTabButton{
        text: "Planning"
        anchors.left: parent.left
        anchors.right: parent.right
        iconSource: "qrc:/assets/icons/Outline/pencil-alt.svg"
    }

    contentItem: ListView {
        id: listView
        anchors.fill: parent
        boundsMovement: Flickable.StopAtBounds
        model: tabBar.contentModel
        currentIndex: tabBar.currentIndex
        contentHeight: 40
        orientation: ListView.Vertical
        boundsBehavior: Flickable.StopAtBounds
    }

}

