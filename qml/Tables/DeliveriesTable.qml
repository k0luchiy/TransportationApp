import QtQuick 2.15
import QtQuick.Layouts

TableBase{
    id : tableRoot
    tableHeaders :  [qsTr("Id"), qsTr("Car number"), qsTr("Driver name"),
        qsTr("Departure date"), qsTr("Return date"), qsTr("Status")]
    tableModel : deliveriesFilterModel
    modelEmpty : deliveriesFilterModel.rowCount() === 0
    tableRow:
        Component{
            TableRow{
                Layout.fillWidth: true
                addToDeliveryVisible: false
                model: [rowModel.DeliveryId, rowModel.CarNumber, rowModel.DriverName,
                        rowModel.DepartureDate.toLocaleDateString("en_US"),
                        rowModel.ReturnDate.toLocaleDateString("en_US"),
                        rowModel.StatusTitle]
                onClicked: {
                    tableRoot.rowClicked(rowModel.DeliveryId)
                }
                onOpenTab: {
                    tableRoot.rowClicked(rowModel.OrderId)
                }
            }
        }

    onHeaderClicked: (index) => {
        deliveriesFilterModel.changeSort(index)
    }
}

