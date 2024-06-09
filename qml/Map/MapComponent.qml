import QtQuick 2.15
import QtLocation
import QtPositioning

Item {
    property string startAddress
    property var startPoint : QtPositioning.coordinate(56.8285045286533, 60.56644931964543)
    property var orderList


    id: mapItemRoot

    Plugin {
        id: mapPlugin
        name: "osm"
    }

    Map {
        id: mapRoot
        anchors.fill: parent
        plugin: mapPlugin
        center: mapItemRoot.startPoint
        zoomLevel: 15

        MapQuickItem{
            id: marker
            coordinate: mapItemRoot.startPoint
            sourceItem: Image{
                id: markerImage
                height: 30
                width: 30
                source: "qrc:/assets/icons/Essentials/map-marker.png"
            }
            anchorPoint.x: markerImage.width / 2
            anchorPoint.y: markerImage.height
        }


        MapItemView {
            z: 2
            model: wayPoints
            delegate: MapQuickItem {
                z: 2
                anchorPoint.x: width / 2
                anchorPoint.y: height
                coordinate: QtPositioning.coordinate(modelData.lat, modelData.lon)
                sourceItem: Rectangle {
                    width: 20
                    height: 20
                    color: "#ffffff"//"transparent"
                    border.width: 3
                    z: 2
                    border.color: "#427AFF"
                    //opacity: 0.7
                    radius: 10
                    Text{
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: index+1
                        font.pointSize: 10
                    }
                }
            }
        }

        MapItemView {
            model: routeModel
            delegate: MapRoute {
                route: routeData
                line.color: "#427AFF"//"#3cb200"
                line.width: 4
            }
        }

        PinchHandler {
            id: pinch
            target: mapRoot
            onActiveChanged: if (active) {
                mapRoot.startCentroid = mapRoot.toCoordinate(pinch.centroid.position, false)
            }
            onScaleChanged: (delta) => {
                mapRoot.zoomLevel += Math.log2(delta)
                mapRoot.alignCoordinateToPoint(mapRoot.startCentroid, pinch.centroid.position)
            }
            onRotationChanged: (delta) => {
                mapRoot.bearing -= delta
                mapRoot.alignCoordinateToPoint(mapRoot.startCentroid, pinch.centroid.position)
            }
            grabPermissions: PointerHandler.TakeOverForbidden
        }
        WheelHandler {
            id: wheel
            acceptedDevices: Qt.platform.pluginName === "cocoa" || Qt.platform.pluginName === "wayland"
                             ? PointerDevice.Mouse | PointerDevice.TouchPad
                             : PointerDevice.Mouse
            rotationScale: 1/120
            property: "zoomLevel"
        }
        DragHandler {
            id: drag
            target: mapRoot
            onTranslationChanged: (delta) => mapRoot.pan(-delta.x, -delta.y)
        }
        Shortcut {
            enabled: mapRoot.zoomLevel < mapRoot.maximumZoomLevel
            sequence: StandardKey.ZoomIn
            onActivated: mapRoot.zoomLevel = Math.round(mapRoot.zoomLevel + 1)
        }
        Shortcut {
            enabled: mapRoot.zoomLevel > mapRoot.minimumZoomLevel
            sequence: StandardKey.ZoomOut
            onActivated: mapRoot.zoomLevel = Math.round(mapRoot.zoomLevel - 1)
        }
    }

    GeocodeModel {
        id: geocodeModel
        plugin: mapPlugin
        query: mapItemRoot.startAddress

        onLocationsChanged: {
            if(geocodeModel.count > 0){
                mapItemRoot.startPoint = geocodeModel.get(0).coordinate
                mapRoot.center = mapItemRoot.startPoint
                marker.coordinate = mapItemRoot.startPoint
            }
        }
    }

    onStartAddressChanged: {
        geocodeModel.query = mapItemRoot.startAddress
        geocodeModel.update()
    }

    onOrderListChanged: {
        console.log("Map order list changed", mapItemRoot.orderList)
        if(mapItemRoot.orderList){
            for(var i=0; i < orderList.length; ++i){
                console.log(orderList[i].address)
            }
        }
    }

    Component.onCompleted: {
        if (mapItemRoot.startAddress !== "") {
            geocodeModel.query = mapItemRoot.startAddress
            geocodeModel.update()
        }
        console.log("Map order list", mapItemRoot.orderList)
        if(mapItemRoot.orderList){
            for(var i=0; i < orderList.length; ++i){
                console.log(orderList[i].address)
            }
        }
    }

}
