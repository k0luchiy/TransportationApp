import QtQuick 2.15
import QtQuick.Layouts

import Colors

Rectangle {
    property int orderId: 0
    property int distance: 0
    property int travelTime: 0
    property string address : ""

    property color bgColor : Colors.elementary.transparent
    property color borderColor : Themes.colors.neutral.neutral700
    property int borderSize : 1
    property color titleColor : Themes.colors.neutral.neutral950
    property color fontColor : Themes.colors.neutral.neutral900
    property int titleSize : 14
    property int fontSize : 12

    id: compRoot
    width: 240
    height: 120
    color: compRoot.bgColor
    radius: 5
    border.width: compRoot.borderSize
    border.color: compRoot.borderColor

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        RowLayout {
            height: 30
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillWidth: true

            Text {
                id: orderText
                text: qsTr("Order") + " " + compRoot.orderId
                fontSizeMode: Text.Fit
                font.pointSize: compRoot.titleSize
                color: compRoot.titleColor
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillHeight: true
            Layout.fillWidth: true
            RowLayout {
                Text {
                    id: distanceText
                    color: compRoot.fontColor
                    font.pointSize: compRoot.fontSize
                    text: qsTr("Distance:") + " " + (
                              compRoot.distance>1000 ?
                                  compRoot.distance/1000 + " " + qsTr("km") :
                                  compRoot.distance + " " + qsTr("m"))
                }
            }
            RowLayout {
                Text {
                    id: timeText
                    color: compRoot.fontColor
                    font.pointSize: compRoot.fontSize
                    text: qsTr("Travel time:") + " " +  (travelTime / 60).toFixed(0) + " " +qsTr("m")

                }
            }

            RowLayout {
                Text {
                    id: addressText
                    color: compRoot.fontColor
                    font.pointSize: compRoot.fontSize
                    text: qsTr("Address:") + " " + compRoot.address
                }
            }
        }

    }
}
