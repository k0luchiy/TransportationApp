import QtQuick 2.15
import QtQuick.Layouts

TableBase{
    id : tableRoot
    tableHeaders :  ["Код", "Дата создания", "Дата доставки", "Улица", "Статус", "Стоимость"]
    tableModel : ordersFilterModel
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
            }
        }
}


