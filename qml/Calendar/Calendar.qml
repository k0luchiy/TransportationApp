import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls

import Colors
import Buttons
import "DatesUtils.js" as DatesUtils

Rectangle{
    property date currentDate : new Date(Date.now());
    property date startDate
    property date endDate
    property var selectedDate

    property var month : currentDate.getMonth()
    property var year : currentDate.getFullYear()
    property bool isRangePicker : true

    property color bgColor : Themes.colors.neutral.neutral0
    property color basicFontColor : Themes.colors.neutral.neutral950
    property color secondaryFontColor : Themes.colors.neutral.neutral500

    property color bgSelectedColor : isRangePicker ?
                    Themes.colors.neutral.neutral100 :
                    Themes.colors.primary.primary500
    property color bgBoundColor : Themes.colors.primary.primary500
    property color bgInRangeColor : Themes.colors.neutral.neutral50

    property color fontDefaultColor : Themes.colors.neutral.neutral950
    property color fontBoundColor : Colors.neutral.neutral0
    property color fontSelectedColor : isRangePicker ?
                   Themes.colors.neutral.neutral950 :
                   Colors.neutral.neutral50
    property color fontInRangeColor : Themes.colors.primary.primary600
    property color fontNextMonthColor : Themes.colors.neutral.neutral500


    property int iconSize : 20
    property url iconLeftSource : "qrc:/assets/icons/Outline/arrow-sm-left.svg"
    property url iconRightSource : "qrc:/assets/icons/Outline/arrow-sm-right.svg"

    property int titleFontSize : 12
    property int smallFontSize : 10

    property alias locale : monthGrid.locale

    id: calendarRoot
    width: 250
    height: 250
    color: calendarRoot.bgColor


    ColumnLayout{
        anchors.fill: parent


        RowLayout{
            Layout.preferredHeight: 25
            Layout.fillWidth: true

            IconButton{
                iconSize: calendarRoot.iconSize
                iconColor: calendarRoot.basicFontColor
                iconSource: calendarRoot.iconLeftSource

                onClicked: {
                    if(calendarRoot.month == 0){
                        calendarRoot.month = 11
                        calendarRoot.year -= 1
                    }
                    else{
                        calendarRoot.month -= 1
                    }
                }
            }

            Item{
                Layout.fillWidth: true
            }

            Text{
                id : monthTitle
                Layout.fillHeight: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.pointSize: calendarRoot.titleFontSize
                text: DatesUtils.getMonthName(calendarRoot.month) + " " + calendarRoot.year
                color: calendarRoot.basicFontColor

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        yearsList.visible = !yearsList.visible
                    }
                }
            }
            Item{
                Layout.fillWidth: true
            }

            IconButton{
                iconSize: calendarRoot.iconSize
                iconColor: calendarRoot.basicFontColor
                iconSource: calendarRoot.iconRightSource
                onClicked: {
                    if(calendarRoot.month == 11){
                        calendarRoot.month = 0
                        calendarRoot.year += 1
                    }
                    else{
                        calendarRoot.month += 1
                    }
                }
            }
        }


        ListView{
            id: yearsList
            Layout.preferredHeight: 15
            Layout.fillWidth: true
            visible: false
            clip: true
            boundsMovement: Flickable.StopAtBounds
            boundsBehavior: Flickable.StopAtBounds
            orientation: ListView.Horizontal
            contentX: contentWidth / 2 - width/2

            model : DatesUtils.get30Years(calendarRoot.currentDate.getFullYear())

            delegate:
                Text{
                    width: 40
                    Layout.preferredWidth: 40
                    font.pointSize: calendarRoot.smallFontSize
                    text: modelData
                    color: calendarRoot.secondaryFontColor
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            calendarRoot.year = modelData
                        }
                    }
                }
        }
        ColumnLayout {
            id: grid
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 1

            DayOfWeekRow {
                locale: monthGrid.locale
                Layout.preferredHeight: 30
                Layout.fillWidth: true

                delegate: Text {
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: calendarRoot.secondaryFontColor
                    font.pointSize: 8

                    text: narrowName
                }
            }

            MonthGrid {
                id: monthGrid
                month: calendarRoot.month
                year: calendarRoot.year
                locale: Qt.locale("en_US")
                spacing: 0

                Layout.fillWidth: true
                Layout.fillHeight: true

                delegate:
                    Rectangle{
                        property date date: DatesUtils.getPureDate(model.date)
                        property bool selected : false
                        property bool inRange : false
                        property bool isBoundRange : false

                        id : dayRoot
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        //opacity: model.month === monthGrid.month ? 1 : 0
                        color:  dayRoot.isBoundRange ?
                                    calendarRoot.bgBoundColor :
                                dayRoot.selected ?
                                    calendarRoot.bgSelectedColor :
                                dayRoot.inRange ?
                                    calendarRoot.bgInRangeColor :
                                    calendarRoot.bgColor

                        Text {
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: model.day
                            anchors.fill: parent
                            font.pointSize: calendarRoot.smallFontSize
                            color:
                                dayRoot.isBoundRange ?
                                     calendarRoot.fontBoundColor :
                                 dayRoot.selected ?
                                     calendarRoot.fontSelectedColor :
                                 dayRoot.inRange ?
                                     calendarRoot.fontInRangeColor :
                                 model.month !== monthGrid.month ?
                                     calendarRoot.fontNextMonthColor :
                                     calendarRoot.fontDefaultColor

                        }

                        Connections {
                            target: calendarRoot
                            function  updateDaySquare() {
                                dayRoot.isBoundRange =
                                        (dayRoot.date.getTime() == calendarRoot.startDate.getTime() ||
                                         dayRoot.date.getTime() == calendarRoot.endDate.getTime())
                                dayRoot.selected = calendarRoot.selectedDate ?
                                            (dayRoot.date.getTime() === calendarRoot.selectedDate.getTime()) : false


                                dayRoot.inRange =
                                        (dayRoot.date > calendarRoot.startDate &&
                                         dayRoot.date < calendarRoot.endDate)
                            }


                            function onSelectedDateChanged() {
                                updateDaySquare()
                            }
                            function onMonthChanged(){
                                updateDaySquare()
                            }
                            function onYearChanged(){
                                updateDaySquare()
                            }
                            function onCurrentDateChanged(){
                                updateDaySquare()
                            }

                            function onStartDateChanged(){
                                updateDaySquare()
                            }
                            function onEndDateChanged(){
                                updateDaySquare()
                            }
                        }

                        MouseArea{
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                // Basicly sets start and end dates
                                // or just selected on first click
                                if(!calendarRoot.selectedDate || !calendarRoot.isRangePicker){
                                    calendarRoot.selectedDate = dayRoot.date
                                }
                                else if(calendarRoot.selectedDate.getTime() === dayRoot.date.getTime())
                                {
                                    calendarRoot.selectedDate = null
                                    dayRoot.selected = false
                                }
                                else{
                                    var lastSelectedDate = dayRoot.date
                                    if(lastSelectedDate > calendarRoot.selectedDate){
                                        calendarRoot.startDate = calendarRoot.selectedDate
                                        calendarRoot.endDate = lastSelectedDate
                                    }
                                    else{
                                        calendarRoot.startDate = lastSelectedDate
                                        calendarRoot.endDate = calendarRoot.selectedDate
                                    }
                                    calendarRoot.selectedDate = null

                                }
                                //dayRoot.selected = true
                            }
                        }
                    }

            }

        }
    }
}

