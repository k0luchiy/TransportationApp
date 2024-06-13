import QtQuick 2.15
import QtQuick.Layouts

import Colors

Item {
    property var routeDetails

    height: 600
    width: 270

    ColumnLayout {
        anchors.fill: parent
        clip: true

        Text{
            height: 45
            Layout.preferredHeight: 45
            Layout.preferredWidth: 270
            color: Themes.colors.neutral.neutral950
            font.pointSize: 18
            text: "Orders"
        }

        ListView{
            boundsMovement: Flickable.StopAtBounds
            boundsBehavior: Flickable.StopAtBounds
            Layout.fillHeight: true
            Layout.preferredWidth: 270
            anchors.margins: 5
            spacing: 0
            model:  routeDetails
            delegate:
            RowLayout{
                Layout.preferredWidth: 270
                Layout.preferredHeight: 180
                spacing: 10
                ColumnLayout{
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    Layout.preferredHeight: 150
                    Layout.preferredWidth: 30
                    spacing: 0
                    Rectangle{
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 30
                        color: Colors.elementary.transparent
                        z: 2
                        radius: 100
                        border.width: 5
                        border.color: modelData.status === "Выполняется" ? "#22C55E" : "#8D97B0"
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        Text{
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: 10
                            color: Themes.colors.neutral.neutral950
                            text: index+1
                        }
                    }
                    Rectangle{
                        Layout.preferredWidth: 7
                        Layout.preferredHeight: 123
                        Layout.topMargin: -1
                        color: modelData.status === "Выполняется" && modelData.nextStatus === "Выполняется" ? "#22C55E" : "#8D97B0"
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        visible: routeDetails.length - 1 !== index
                    }
                }

                WaypointInfo{
                    width: 220
                    Layout.preferredWidth: 220
                    //Layout.fillWidth: true
                    Layout.preferredHeight: 130
                    orderId : modelData.orderId
                    distance: modelData.distance.toFixed(2)
                    address: modelData.address
                    travelTime: modelData.travelTime
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                }
            }
        }

    }
//    onRouteDetailsChanged: {
//        console.log("Route changed", routeDetails, routeDetails.length)
//        console.log("Route Details: ", JSON.stringify(routeDetails, null, 2))
//    }

}
