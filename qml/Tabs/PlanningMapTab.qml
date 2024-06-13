import QtQuick 2.15
import QtQuick.Layouts

import Map

Item {
    property alias startAddress : map.startAddress
    property alias orderList : map.orderList
    property alias routeDetails : map.routeDetails

    id: pageRoot
    height: 800
    width: 1040

    RowLayout{
        anchors.fill: parent

        RouteInfoPannel{
            Layout.fillHeight: true
            Layout.preferredWidth: 270
            routeDetails: pageRoot.routeDetails
        }

        MapComponent{
            id: map
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}
