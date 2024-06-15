import QtQuick 2.15

import Calendar
import Utils

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
    placeholderText: qsTr("dd.mm - dd.mm")
    text: ""
    z: 5
    focusField : false
    focusOnTab: false

    function clear(){
        calendar.clear()
        fieldRoot.text = ""
    }

    DateRangePicker{
        id: calendar
        y: fieldRoot.height + 10
        x: (Window.width >= fieldRoot.x + calendar.width) ? 0 :
               fieldRoot.width - calendar.width - 5
        z: 10
        visible: false

        onClearClicked: {
            fieldRoot.clear()
        }

        onApplyClicked : {
            fieldRoot.text = DateUtils.dateRangeToString(fieldRoot.startDate, fieldRoot.endDate)
        }
    }

    onRightIconClicked: {
        calendar.visible = !calendar.visible
    }

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
        focus: true
        activeFocusOnTab: true
        enabled: !readOnly
        onClicked : {
            calendar.visible = !calendar.visible
        }
        Keys.onReturnPressed: {
            fieldRoot.rightIconClicked()
        }
    }
}
