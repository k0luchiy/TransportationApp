import QtQuick 2.15
import QtQuick.Layouts

TableBase{
    property bool requeredPremission : user.rolePriority > 1

    id : tableRoot
    tableHeaders :  [qsTr("Id"), qsTr("Created date"), qsTr("Delivery date"),
        qsTr("Address"), qsTr("Status"), qsTr("Cost")]
    tableModel : ordersFilterModel
    modelEmpty : ordersFilterModel.rowCount() === 0
    tableRow:
        Component{
            TableRow{
                Layout.fillWidth: true
                addToDeliveryVisible: requeredPremission
                model: [rowModel.OrderId, rowModel.CreatedDate.toLocaleDateString("en_US"),
                    rowModel.AskedDeliveryDate.toLocaleDateString("en_US"),
                    rowModel.Address, rowModel.StatusTitle, rowModel.Cost]
                onClicked: {
                    tableRoot.rowClicked(rowModel.OrderId)
                }
                onOpenTab: {
                    tableRoot.openTab(rowModel.OrderId)
                }
                onAddToDelivery: {
                    tableRoot.addToDelivery(rowModel.OrderId)
                }
            }
        }

    onHeaderClicked: (index) => {
        ordersFilterModel.changeSort(index)
    }
}


