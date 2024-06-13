import QtQuick 2.15
import QtQuick.Layouts

TableBase{
    id : tableRoot
    tableHeaders :  ["Id", "Car number", "Driver name", "Departure date", "Return date", "Status"]
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
            }
        }
}

