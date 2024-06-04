import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

import Colors

TabBar {
    property var tabs : []

    signal tabClosed(index : int)

    id: tabBarRoot
    width: 500
    contentWidth: 500
    height: 50
    currentIndex: 0

    background: Rectangle{
        anchors.fill: parent
        color: Colors.elementary.transparent
    }

    function addTab(title, iconVisible = true, checked = false){
        var tab = {}
        tab.text = title
        tab.iconVisible = iconVisible
        tab.checked = checked
//        tab.closed.connect( ()=>{
//            tabBarRoot.removeItem(tab)
//            tabBarRoot.tabClosed(tabBarRoot.count - 1)
//        })
        tabBarRoot.tabs.push(tab)
        tabBarRoot.tabs = tabBarRoot.tabs
    }

//    function addTab(title, iconVisible = true, checked = false){
//        var component = Qt.createComponent("TabButtonBase.qml")
//        var tab = tabButton.createObject(tabBarRoot)
//        tab.text = title
//        tab.iconVisible = iconVisible
//        tab.checked = checked
//        tab.closed.connect( ()=>{
//            tabBarRoot.removeItem(tab)
//            tabBarRoot.tabClosed(tabBarRoot.count - 1)
//        })
//        tabBarRoot.addItem(tab)
//    }

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
                model: tabBarRoot.tabs//tabBarRoot.contentModel
                currentIndex: tabBarRoot.currentIndex
                contentHeight: 40
                orientation: ListView.Horizontal
                boundsBehavior: Flickable.StopAtBounds
                delegate: TabButtonBase{
                    id: tabButton
                    text: modelData.text
                    checked: tabBarRoot.currentIndex === index//modelData.checked
                    iconVisible: modelData.iconVisible
                    onClicked: {
                        tabBarRoot.currentIndex = index
                    }
                    onClosed: {
                        tabBarRoot.tabClosed(index)
                        if(index!==0 && tabBarRoot.currentIndex === index){
                            tabBarRoot.currentIndex = index - 1
                        }
//                        if(tabBarRoot.currentIndex >= index){
//                            //tabBarRoot.currentIndex = tabBarRoot.currentIndex
//                            tabBarRoot.currentIndex = currentIndex - 1
//                        }
                        tabBarRoot.tabs.splice(index, 1)
                        tabBarRoot.tabs = tabBarRoot.tabs
                    }
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

