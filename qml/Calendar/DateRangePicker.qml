import QtQuick 2.15
import QtQuick.Layouts

import Colors
import Buttons
import Utils

Rectangle {
    property color bgColor : Themes.colors.neutral.neutral0

    property alias currentDate : calendar.currentDate
    property alias startDate : calendar.startDate
    property alias endDate : calendar.endDate
    property alias selectedDate : calendar.selectedDate
    property alias month : calendar.month
    property alias year : calendar.year
    property alias  isRangePicker : calendar.isRangePicker

    signal applyClicked

    id: calendarRoot
    width: 390
    height: 300

    color: calendarRoot.bgColor
    border.width: 1
    border.color: Themes.colors.neutral.neutral700
    radius: 6

    RowLayout{
        anchors.fill: parent
        anchors.topMargin: 5
        anchors.bottomMargin: 0
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        ColumnLayout{
            Layout.fillHeight: true
            Layout.preferredWidth: 100
            Layout.topMargin: 5

            AdditionalButton{
                Layout.leftMargin: 5
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                text: "Today"
                onClicked: {
                    var currentDate = DateUtils.getPureDate(new Date(Date.now()))
                    //calendar.selectedDate = currentDate
                    calendar.startDate = currentDate
                    calendar.endDate = currentDate
                }
            }

            AdditionalButton{
                Layout.leftMargin: 5
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                text: "Last 7 days"
                onClicked: {
                    var currentDate = DateUtils.getPureDate(new Date(Date.now()))
                    calendar.startDate = new Date(currentDate - 7 * 24 * 60 * 60 * 1000);
                    calendar.endDate = currentDate
                }
            }

            AdditionalButton{
                Layout.leftMargin: 5
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                text: "Last 14 days"
                onClicked: {
                    var currentDate = DateUtils.getPureDate(new Date(Date.now()))
                    calendar.startDate = new Date(currentDate - 7 * 24 * 60 * 60 * 1000 * 2);
                    calendar.endDate = currentDate
                }
            }

            AdditionalButton{
                Layout.leftMargin: 5
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                text: "This month"
                onClicked: {
                    calendar.startDate = new Date(calendar.year, calendar.month, 1);
                    calendar.endDate = new Date(calendar.year, calendar.month + 1, 0);
                }
            }

            AdditionalButton{
                Layout.leftMargin: 5
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                text: "This year"
                onClicked: {
                    calendar.startDate = new Date(calendar.year, 0, 1);
                    calendar.endDate = new Date(calendar.year, 11, 31);
                }
            }

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
                isRangePicker: true
            }

            RowLayout{
                Layout.preferredHeight: 60

                SecondaryButton{
                    buttonSize: ButtonSizes.smallSize
                    iconLeftVisible: false
                    iconRightVisible: false
                    btnText: "Cancel"
                    onClicked: {
                        calendarRoot.selectedDate = null
                        calendarRoot.visible = false
                    }
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
                    onClicked: {
                        applyClicked()
                        calendarRoot.visible = false
                    }
                }
            }
        }
    }
}
