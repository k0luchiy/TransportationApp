import QtQuick 2.15
import QtQuick.Layouts

import Colors
import Buttons

Rectangle {
    id: root
    width: 390
    height: 300

    border.width: 1
    border.color: Themes.colors.neutral.neutral700
    radius: 6

    function getPureDate(date){
        return new Date(date.getFullYear(), date.getMonth(), date.getDate())
    }


    RowLayout{
        anchors.fill: parent
        anchors.topMargin: 5
        anchors.bottomMargin: 0
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        ColumnLayout{
            Layout.fillHeight: true
            Layout.preferredWidth: 100

            Text{
                verticalAlignment: Text.AlignVCenter
                Layout.leftMargin: 5
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                color: Themes.colors.neutral.neutral600
                font.pointSize: 10
                text: "Today"

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onClicked: {
                        var currentDate = getPureDate(new Date(Date.now()))
                        calendar.selectedDate = currentDate
                        calendar.startDate = currentDate
                        calendar.endDate = currentDate
                    }
                }
            }
            Text{
                verticalAlignment: Text.AlignVCenter
                Layout.leftMargin: 5
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                color: Themes.colors.neutral.neutral600
                font.pointSize: 10
                text: "Last 7 days"

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onClicked: {
                        var currentDate = getPureDate(new Date(Date.now()))
                        calendar.startDate = new Date(currentDate - 7 * 24 * 60 * 60 * 1000);
                        calendar.endDate = currentDate
                    }
                }
            }


            Text{
                verticalAlignment: Text.AlignVCenter
                Layout.leftMargin: 5
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                color: Themes.colors.neutral.neutral600
                font.pointSize: 10
                text: "Last 14 days"
            }
            Text{
                verticalAlignment: Text.AlignVCenter
                Layout.leftMargin: 5
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                color: Themes.colors.neutral.neutral600
                font.pointSize: 10
                text: "Last 30 days"
            }
            Text{
                verticalAlignment: Text.AlignVCenter
                Layout.leftMargin: 5
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                color: Themes.colors.neutral.neutral600
                font.pointSize: 10
                text: "Last 3 month"
            }
            Text{
                verticalAlignment: Text.AlignVCenter
                Layout.leftMargin: 5
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                color: Themes.colors.neutral.neutral600
                font.pointSize: 10
                text: "Last 12 month"
            }
            Text{
                verticalAlignment: Text.AlignVCenter
                Layout.leftMargin: 5
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                color: Themes.colors.neutral.neutral600
                font.pointSize: 10
                text: "Custom"
            }


            /*SecondaryButton{
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 30
                //Layout.fillWidth: true
                borderSize: 0
            }*/
            Item{
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }
        ColumnLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true

            Calendar{
                id: calendar
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            RowLayout{
                Layout.preferredHeight: 60

                SecondaryButton{
                    buttonSize: ButtonSizes.smallSize
                    iconLeftVisible: false
                    iconRightVisible: false
                    btnText: "Cancel"
                }
                Item{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                PrimaryButton{
                    buttonSize: ButtonSizes.smallSize
                    iconLeftVisible: false
                    iconRightVisible: false
                    btnText: "Apply"
                }
            }
        }
    }
}
