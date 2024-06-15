import QtQuick 2.15

import Calendar
import Utils

TextInputField {
    property alias currentDate : calendar.currentDate
    property alias selectedDate : calendar.selectedDate

    property alias month : calendar.month
    property alias year : calendar.year

    id: fieldRoot
    iconRightSource : "qrc:/assets/icons/Outline/calendar.svg"
    iconRightVisible: true
    placeholderText: qsTr("dd.mm.yyyy")
    text: ""
    z: 10
    focusField : false
    focusOnTab: false

    function clear(){
        calendar.clear()
        fieldRoot.text = ""
    }

    DatePicker{
        id: calendar
        y: fieldRoot.height + 10
        x: (Window.width >= fieldRoot.x + calendar.width) ? 0 :
               fieldRoot.width - calendar.width - 5
        z: 5
        visible: false

        onClearClicked: {
            fieldRoot.clear()
        }

        onApplyClicked : {
            if(!fieldRoot.selectedDate){
                fieldRoot.text = ""
            }
            else{
                fieldRoot.text = DateUtils.formatDate(fieldRoot.selectedDate)
            }
        }
    }

    onRightIconClicked: {
        calendar.visible = !calendar.visible
    }

    MouseArea{
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

    onTextChanged:{
        var newDate = DateUtils.strToDate(fieldRoot.text)
        if(!fieldRoot.text || isNaN(newDate)){
            return;
        }
        fieldRoot.month = newDate.getMonth()
        fieldRoot.year = newDate.getFullYear()
        fieldRoot.selectedDate = new Date(newDate.getFullYear(), newDate.getMonth(), newDate.getDate())
    }
}
