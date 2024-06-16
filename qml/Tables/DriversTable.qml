import QtQuick 2.15
import QtQuick.Layouts

TableBase{
    property bool requeredPremission : user.rolePriority > 1

    id : tableRoot
    tableHeaders :  [qsTr("Id"), qsTr("Last name"), qsTr("First name"),
        qsTr("Driving category"), qsTr("Experience")]
    tableModel : driversFilterModel
    modelEmpty : driversFilterModel.rowCount() === 0
    tableRow:
        Component{
            TableRow{
                Layout.fillWidth: true
                addToDeliveryVisible: requeredPremission
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

    onHeaderClicked: (index) => {
        driversFilterModel.changeSort(index)
    }
}

