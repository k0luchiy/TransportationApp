import QtQuick 2.15

import Map

Item {
    property alias startAddress : map.startAddress
    property alias orderList : map.orderList

    id: pageRoot
    height: 800
    width: 1040

    MapComponent{
        id: map
        anchors.fill: parent
    }
}
