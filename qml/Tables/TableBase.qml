import QtQuick 2.15
import QtQuick.Layouts


ColumnLayout {

    property var tableHeaders
    property var tableModel
    property var pagination
    property var tableRow

    signal rowClicked(recordId : int)

    id : tableRoot
    spacing: 0

    TableHeaders{
        Layout.preferredHeight: 35
        Layout.fillWidth: true
        headersModel: tableRoot.tableHeaders
    }

    Component{
        id: emptyItem
        Item{}
    }

    Component {
        id: rowComponent
        Loader {
            anchors.left: parent ? parent.left : undefined
            anchors.right: parent ? parent.right : undefined
            property var rowModel : model
            sourceComponent: (index >= pagination.startRowIndex && index < pagination.endRowIndex) ?
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

