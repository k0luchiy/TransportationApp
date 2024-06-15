import QtQuick 2.15
import QtQuick.Layouts

import Colors

ColumnLayout {
    property bool headerIconVisible: true
    property bool headerEnabled: true

    property bool modelEmpty : false
    property var tableHeaders
    property var tableModel
    property var pagination
    property var tableRow

    signal headerClicked(index : int)
    signal rowClicked(recordId : int)
    signal openTab(recordId : int)
    signal addToDelivery(recordId : int)
    signal deleteClicked(recordId : int)

    id : tableRoot
    spacing: 0
    clip: true

    TableHeaders{
        Layout.preferredHeight: 35
        Layout.fillWidth: true
        headersModel: tableRoot.tableHeaders
        iconVisible: tableRoot.headerIconVisible
        enabled: tableRoot.headerEnabled
        onHeaderClicked: (index) => {
            tableRoot.headerClicked(index)
        }
    }

    Component{
        id: emptyItem
        Item{}
    }

    Component{
        id: emptyTableModel
        Item{
            width: 200
            height: 40

            Text{
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 10
                color: Themes.colors.neutral.neutral700
                text: qsTr("No items found")
            }
        }
    }

    Component {
        id: rowComponent
        Loader {
            anchors.left: parent ? parent.left : undefined
            anchors.right: parent ? parent.right : undefined
            property var rowModel : model
            property var rowIndex : index
            sourceComponent: tableRoot.modelEmpty ? emptyTableModel :
                isNaN(pagination) ? tableRow :
                (index >= pagination.startRowIndex && index < pagination.endRowIndex) ?
                                 tableRow : emptyItem
        }
    }

    ListView {
        id: tableContent
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        boundsMovement: Flickable.StopAtBounds
        model: tableRoot.tableModel
        Layout.fillHeight: true
        Layout.fillWidth: true

        delegate: rowComponent
    }

}

