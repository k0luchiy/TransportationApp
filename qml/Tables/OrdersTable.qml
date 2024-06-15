import QtQuick 2.15
import QtQuick.Layouts

TableBase{
    id : tableRoot
    tableHeaders :  ["Id", "Created date", "Delivery date", "Address", "Status", "Cost"]
    tableModel : ordersFilterModel
    modelEmpty : ordersFilterModel.rowCount() === 0
    tableRow:
        Component{
            TableRow{
                Layout.fillWidth: true
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


