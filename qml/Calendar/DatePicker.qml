import QtQuick 2.15
import QtQuick.Layouts

import Colors
import Buttons

Rectangle {
    property color bgColor : Themes.colors.neutral.neutral0

    property alias currentDate : calendar.currentDate
    property alias selectedDate : calendar.selectedDate
    property alias month : calendar.month
    property alias year : calendar.year

    signal applyClicked
    signal clearClicked

    id: calendarRoot
    width: 300
    height: 320

    color: calendarRoot.bgColor
    border.width: 1
    border.color: Themes.colors.neutral.neutral700
    radius: 6

    function clear(){
        calendar.clear()
    }

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 10

        Calendar{
            id: calendar
            Layout.fillHeight: true
            Layout.fillWidth: true
            isRangePicker: false
        }

        RowLayout{
            Layout.preferredHeight: 60

            SecondaryButton{
                buttonSize: ButtonSizes.smallSize
                iconLeftVisible: false
                iconRightVisible: false
                btnText: qsTr("Clear")
                onClicked: {
                    calendarRoot.clearClicked()
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
                btnText: qsTr("Apply")
                onClicked: {
                    calendarRoot.applyClicked()
                    calendarRoot.visible = false
                }
            }
        }
    }

}
