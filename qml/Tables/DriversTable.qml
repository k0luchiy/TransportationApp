import QtQuick 2.15
import QtQuick.Layouts

TableBase{
    id : tableRoot
    tableHeaders :  ["Id", "Last name", "First name", "Driving category", "Experience"]
    tableModel : driversFilterModel
    modelEmpty : driversFilterModel.rowCount() === 0
    tableRow:
        Component{
            TableRow{
                Layout.fillWidth: true
                model: [rowModel.DriverId, rowModel.LastName, rowModel.FirstName,
                        rowModel.DrivingCategory, rowModel.Experience]
                onClicked: {
                    tableRoot.rowClicked(rowModel.DriverId)
                }
                onOpenTab: {
                    tableRoot.openTab(rowModel.DriverId)
                }
                onAddToDelivery: {
                    tableRoot.addToDelivery(rowModel.DriverId)
                }
            }
        }
}

