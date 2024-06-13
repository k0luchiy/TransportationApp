import QtQuick 2.15
import QtLocation 6.7
import QtPositioning

Item {
    property string startAddress
    property var startPoint : QtPositioning.coordinate(56.8285045286533, 60.56644931964543)
    property var orderList : []
    property int currentGeocodeIndex: 0
    property var routeDetails : []


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
            model: routeQuery.waypoints //waypoints//waypointsModel
            delegate: MapQuickItem {
                z: 2
                visible: index!==0
                anchorPoint.x: width / 2
                anchorPoint.y: height
                coordinate: QtPositioning.coordinate(modelData.latitude, modelData.longitude)
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

    RouteQuery {
        id: routeQuery
        travelModes: RouteQuery.CarTravel
        routeOptimizations: RouteQuery.FastestRoute
    }

    RouteModel {
        id: routeModel
        plugin: mapPlugin
        query: routeQuery

//        onRoutesChanged: {
//            if (routeQuery.status === RouteQuery.Ready) {
//                //routeItem.route = routeQuery.route

//                // Extract and store route details
//                mapItemRoot.routeDetails = []
//                console.log("Model count", routeModel.count)
//                var route = routeModel.get(0)
//                //var routeSegments = routeModel.get(0).legs //routeQuery.route.segments
//                for (var i = 0; i < routeModel.count; ++i) {
//                    var segment = routeModel.get(i)
//                    var distance = segment.distance
//                    var travelTime = segment.travelTime
//                    var startCoordinate = segment.path[0]
//                    var endCoordinate = segment.path[segment.path.length - 1]
//                    console.log("Distance ", i, distance)

//                    mapItemRoot.routeDetails.push({
//                        start: {latitude: startCoordinate.latitude, longitude: startCoordinate.longitude},
//                        end: {latitude: endCoordinate.latitude, longitude: endCoordinate.longitude},
//                        distance: distance,
//                        travelTime: travelTime
//                    })
//                }
//                console.log("Route Details: ", JSON.stringify(mapItemRoot.routeDetails, null, 2))
//                fillRouteInfo()
//            }
//        }
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
        query: routeDetailsQuery


        onRoutesChanged: {
            var route = routeDetailsModel.get(0)
            var distance = route.distance
            var travelTime = route.travelTime
            var startCoordinate = route.path[0]
            var endCoordinate = route.path[route.path.length - 1]
            console.log("Distance ", distance)

            mapItemRoot.routeDetails.push({
                start: {latitude: startCoordinate.latitude, longitude: startCoordinate.longitude},
                end: {latitude: endCoordinate.latitude, longitude: endCoordinate.longitude},
                distance: distance,
                travelTime: travelTime
            })
        }
    }

    function updateRoute() {
        routeQuery.clearWaypoints()
        currentGeocodeIndex = 0
        if (startPoint) {
            routeQuery.addWaypoint(startPoint)
        }
        if (orderList.length > 0) {
            routeGeocodeModel.query = "Екатеринбург, улица " + orderList[currentGeocodeIndex].address
            routeGeocodeModel.update()
        }
    }

    function fillRouteInfo(){
        var waypoints =  routeQuery.waypointObjects()
        console.log("FillRouteInfo", waypoints.length)
        for(var i=0; i < routeQuery.waypoints.length - 1; ++i){
            routeDetailsQuery.clearWaypoints()
            routeDetailsQuery.addWaypoint(routeQuery.waypoints[i])
            routeDetailsQuery.addWaypoint(routeQuery.waypoints[i+1])
            routeDetailsModel.update()
        }
        console.log("Details count", mapItemRoot.routeDetails.length)
    }

    onStartAddressChanged: {
        geocodeModel.query = mapItemRoot.startAddress
        geocodeModel.update()
    }

    onOrderListChanged: {
        if(mapItemRoot.orderList){
            console.log("OrderList changed")
            for(var i=0; i < orderList.length; ++i){
                console.log(orderList[i].address)
            }
            updateRoute()
            fillRouteInfo()
        }
    }

    Component.onCompleted: {
        if (mapItemRoot.startAddress !== "") {
            geocodeModel.query = mapItemRoot.startAddress
            geocodeModel.update()
        }
    }

}
