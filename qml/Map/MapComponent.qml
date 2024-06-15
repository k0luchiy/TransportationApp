import QtQuick 2.15
import QtLocation 6.7
import QtPositioning

import Colors

Item {
    property string startAddress
    property var startPoint : QtPositioning.coordinate(56.8285045286533, 60.56644931964543)
    property var orderList : []
    property int currentGeocodeIndex: 0
    property int currentRouteIndex: 0
    property int currentFillRouteIndex: 0
    property var routeDetails : []

    property color routeColor: Themes.colors.primary.primary500
    property color circleColor: Themes.colors.primary.primary500

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
            model: routeQuery.waypoints
            delegate: MapQuickItem {
                z: 2
                visible: index!==0
                anchorPoint.x: width / 2
                anchorPoint.y: height
                coordinate: QtPositioning.coordinate(modelData.latitude, modelData.longitude)
                sourceItem: Rectangle {
                    width: 20
                    height: 20
                    color: Colors.elementary.white
                    border.width: 3
                    z: 2
                    border.color: circleColor
                    //opacity: 0.7
                    radius: 10
                    Text{
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: index
                        font.pointSize: 10
                    }
                }
            }
        }

        MapItemView {
            model: routeModel
            delegate: MapRoute {
                route: routeData
                line.color: routeColor
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

    RouteQuery {
        id: routeQuery
        travelModes: RouteQuery.CarTravel
        routeOptimizations: RouteQuery.FastestRoute
    }

    RouteModel {
        id: routeModel
        plugin: mapPlugin
        query: routeQuery
    }

    GeocodeModel {
         id: routeGeocodeModel
         plugin: mapPlugin

         onLocationsChanged: {
             if (routeGeocodeModel.count > 0) {
                routeQuery.addWaypoint(routeGeocodeModel.get(0).coordinate)
                ++currentGeocodeIndex
                if (currentGeocodeIndex < orderList.length) {
                    routeGeocodeModel.query = "Екатеринбург, улица " + orderList[currentGeocodeIndex].address
                    routeGeocodeModel.update()
                } else {
                    routeModel.update()
                    fillRouteInfo()
                }
             }
         }
     }


    RouteQuery {
        id: routeDetailsQuery
        travelModes: RouteQuery.CarTravel
        routeOptimizations: RouteQuery.FastestRoute
    }

    RouteModel {
        id: routeDetailsModel
        plugin: mapPlugin
        autoUpdate: true
        query: routeDetailsQuery

        onRoutesChanged: {
            console.log("Routes changed")
            if (routeDetailsModel.count <= 0) {
                return
            }

            var route = routeDetailsModel.get(0)
            var distance = route.distance
            var travelTime = route.travelTime
            var startCoordinate = route.path[0]
            var endCoordinate = route.path[route.path.length - 1]
            var orderId = orderList[currentRouteIndex].orderId
            var address = orderList[currentRouteIndex].address
            var status = orderList[currentRouteIndex].statusTitle
            var nextStatus = orderList.length < currentRouteIndex ? orderList[currentRouteIndex+1].statusTitle : ""

            ++currentRouteIndex
            console.log("Info", distance, address)

            mapItemRoot.routeDetails.push({
                start: {latitude: startCoordinate.latitude, longitude: startCoordinate.longitude},
                end: {latitude: endCoordinate.latitude, longitude: endCoordinate.longitude},
                distance: distance,
                travelTime: travelTime,
                orderId: orderId,
                address: address,
                status: status,
                nextStatus: nextStatus
            })
            mapItemRoot.routeDetailsChanged()
            continueFillRouteInfo()
        }
    }

    function updateRoute() {
        routeQuery.clearWaypoints()
        routeDetailsQuery.clearWaypoints()
        mapItemRoot.routeDetails = []
        currentRouteIndex = 0
        currentGeocodeIndex = 0
        currentFillRouteIndex = 0
        if (startPoint) {
            routeQuery.addWaypoint(startPoint)
        }
        if (orderList.length > 0) {
            routeGeocodeModel.query = "Екатеринбург, улица " + orderList[currentGeocodeIndex].address
            routeGeocodeModel.update()
        }
    }

    function fillRouteInfo() {
        console.log("Fill route")
        currentFillRouteIndex = 0
        continueFillRouteInfo()
    }

    function continueFillRouteInfo() {
        if (currentFillRouteIndex < routeQuery.waypoints.length - 1) {
            console.log("add point", currentFillRouteIndex)
            routeDetailsQuery.clearWaypoints()
            routeDetailsQuery.addWaypoint(routeQuery.waypoints[currentFillRouteIndex])
            routeDetailsQuery.addWaypoint(routeQuery.waypoints[currentFillRouteIndex + 1])
            routeDetailsModel.update()
            currentFillRouteIndex++
        }
    }
//    function fillRouteInfo(){
//        console.log("Fill route")
//        for(var i=0; i < routeQuery.waypoints.length-1; ++i){
//            console.log("add point", i)
//            routeDetailsQuery.clearWaypoints()
//            routeDetailsQuery.addWaypoint(routeQuery.waypoints[i])
//            routeDetailsQuery.addWaypoint(routeQuery.waypoints[i+1])
//            routeDetailsModel.update()
//        }
//    }

    onStartAddressChanged: {
        geocodeModel.query = mapItemRoot.startAddress
        geocodeModel.update()
    }

    onOrderListChanged: {
        if(mapItemRoot.orderList.length > 0){
            updateRoute()
        }
        else{
            console.log("Order list empty")
            routeQuery.clearWaypoints()
            routeDetailsQuery.clearWaypoints()
            mapItemRoot.routeDetails = []
            routeModel.update()
            routeDetailsModel.update()
            routeGeocodeModel.update()
        }
    }

    Component.onCompleted: {
        if (mapItemRoot.startAddress !== "") {
            geocodeModel.query = mapItemRoot.startAddress
            geocodeModel.update()
        }
    }

}
