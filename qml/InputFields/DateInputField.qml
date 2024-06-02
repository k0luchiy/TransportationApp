import QtQuick 2.15

import Calendar

TextInputField {
    property alias currentDate : calendar.currentDate
    property alias startDate : calendar.startDate
    property alias endDate : calendar.endDate
    property alias selectedDate : calendar.selectedDate

    property alias month : calendar.month
    property alias year : calendar.year

    id: fieldRoot
    iconRightSource : "qrc:/assets/icons/Outline/calendar.svg"
    iconRightVisible: true
    placeholderText: "mm-dd - mm-dd"
    text: ""


    AdditionalCalendar{
        id: calendar
        y: fieldRoot.height + 10
        x: (Window.width >= fieldRoot.x + calendar.width) ? 0 :
               fieldRoot.width - calendar.width - 5

        visible: false
        onApplyClicked : {
            fieldRoot.text = DatesUtils.dateRangeToString(fieldRoot.startDate, fieldRoot.endDate)
        }
    }

    onRightIconClicked: {
        calendar.visible = !calendar.visible
    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
        onClicked : {
            calendar.visible = !calendar.visible
        }
    }
}
