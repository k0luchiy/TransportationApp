

import QtQuick 2.15
import QtQuick.Layouts

ColumnLayout {

    property var tableHeaders :  ["Код", "Дата создания", "Дата доставки", "Улица", "Статус", "Стоимость"]
    property var tableModel : ordersFilterModel
    property var pagination

    signal rowClicked

    id : tableRoot
    spacing: 0

    TableHeaders{
        Layout.preferredHeight: 35
        Layout.fillWidth: true
        headersModel: tableRoot.tableHeaders
    }

    Component{
        id: tableRow
        TableRow{
            Layout.fillWidth: true
            model: rowModel
            onClicked: {
                tableRoot.rowClicked()
            }
        }
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
            property var rowModel : [OrderId, CreatedDate.toLocaleDateString("en_US"),
                                    AskedDeliveryDate.toLocaleDateString("en_US"),
                                    Address, StatusTitle, Cost]
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
