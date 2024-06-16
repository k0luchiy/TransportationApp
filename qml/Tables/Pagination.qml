// The whole thing is a joke...
import QtQuick 2.15
import QtQuick.Layouts

import Colors
import Buttons

Item {
    property int currentIndex : 0
    property int rowCount : 150
    property int rowsPerPage: 15
    property int pageCount : (rowCount / rowsPerPage) + 1
    property int startRowIndex : currentIndex*rowsPerPage
    property int endRowIndex : currentIndex*rowsPerPage+rowsPerPage
    property int maxPageCount : 8

    property color selectedIndicatorColor : Themes.colors.primary.primary600
    property color defaultIndicatorColor : Themes.colors.elementary.transparent
    property color selectedFontColor : Colors.neutral.neutral0
    property color defaultFontColor : Themes.colors.neutral.neutral600
    property int fontSize : 10
    property int indicatorSize: 30

    id: paginationRoot
    width: 500
    height: 40
    visible: pageCount > 1

    function generatePageNumbers(pageCount){
        var pages = []
        for(var i=1; i <= pageCount; ++i){
            pages.push(i)
        }
        return pages
    }

    // Its sooooo bad
    function getIndicator(index){
        var middle = paginationRoot.maxPageCount / 2
        if(paginationRoot.pageCount<=paginationRoot.maxPageCount){
            return pageIndicator; //1;
        }
        else if(index===0 || index === paginationRoot.pageCount-1){
            return pageIndicator; //1;
        }
        else if(paginationRoot.currentIndex < middle)
        {
            if(index <= paginationRoot.maxPageCount-3){
                return pageIndicator; //1;
            }
        }
        else if(paginationRoot.currentIndex >= paginationRoot.pageCount - middle)
        {
            if(index >=  paginationRoot.pageCount - middle - 2){
                return pageIndicator; //1;
            }
        }
        else if(index > paginationRoot.currentIndex - middle/2 &&
                index <= paginationRoot.currentIndex + middle/2)
        {
            return pageIndicator; //1;
        }

        if(index === 2 || index === paginationRoot.pageCount-2){
            return skipIndicator;//2;
        }

        return emptyIndicator;//0;
    }

    Component{
        id: pageIndicator
        Rectangle{
            width: indicatorSize
            height: indicatorSize
            radius: 5
            //visible: isIndicatorVisible(index)
            anchors.verticalCenter: parent.verticalCenter
            color: pageIndex === paginationRoot.currentIndex ?
                       paginationRoot.selectedIndicatorColor :
                       paginationRoot.defaultIndicatorColor
            Text{
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: pageIndex === paginationRoot.currentIndex ?
                           paginationRoot.selectedFontColor :
                           paginationRoot.defaultFontColor
                font.pointSize: paginationRoot.fontSize
                text: pageNumber
            }

            MouseArea{
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    paginationRoot.currentIndex = pageIndex
                }
                cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
            }
        }
    }
    Component{
        id: skipIndicator
        Rectangle{
            width: indicatorSize
            height: indicatorSize
            radius: 5
            anchors.verticalCenter: parent.verticalCenter
            color: paginationRoot.defaultIndicatorColor
            Text{
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: paginationRoot.defaultFontColor
                font.pointSize: paginationRoot.fontSize
                text: "..."
            }
        }
    }

    Component{
        id: emptyIndicator
        Item{}
    }


    RowLayout{
        anchors.fill: parent

        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        SecondaryButton{
            Layout.preferredHeight: indicatorSize
            Layout.preferredWidth: indicatorSize
            textVisible: false
            iconLeftVisible: true
            iconSize: 20
            iconLeftSource: "qrc:/assets/icons/Outline/chevron-left.svg"
            enabled: paginationRoot.currentIndex !== 0
            contentColor: Themes.colors.neutral.neutral500
            onClicked: {
                if(paginationRoot.currentIndex !== 0){
                    paginationRoot.currentIndex -= 1
                }
            }
        }

        ListView{
            id: listView
            boundsMovement: Flickable.StopAtBounds
            boundsBehavior: Flickable.StopAtBounds
            interactive: false
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.preferredWidth: contentWidth
            //Layout.fillWidth: true
            orientation: ListView.Horizontal

            model: generatePageNumbers(paginationRoot.pageCount)

            delegate:
                Component{
                id: component
                    Loader{
                        property int pageIndex : index
                        property int pageNumber: modelData

                        Layout.preferredHeight: indicatorSize
                        Layout.preferredWidth: indicatorSize
                        anchors.verticalCenter: parent.verticalCenter
                        sourceComponent: getIndicator(index)
                    }
                }
        }

        SecondaryButton{
            Layout.preferredHeight: indicatorSize
            Layout.preferredWidth: indicatorSize
            textVisible: false
            iconLeftVisible: true
            iconSize: 20
            iconLeftSource: "qrc:/assets/icons/Outline/chevron-right.svg"
            enabled: paginationRoot.currentIndex !== paginationRoot.pageCount-1
            contentColor: Themes.colors.neutral.neutral500
            onClicked: {
                if(paginationRoot.currentIndex !== paginationRoot.pageCount-1){
                    paginationRoot.currentIndex += 1
                }
            }
        }

        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}
