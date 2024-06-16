import QtQuick 2.15
import QtQuick.Layouts

TableBase{
    property bool requeredPremission : user.rolePriority > 1

    id : tableRoot
    tableHeaders :  [qsTr("Id"), qsTr("Type"), qsTr("Model"),
        qsTr("Car number"), qsTr("Volume"), qsTr("Weight"), qsTr("Driving category")]
    tableModel : carsFilterModel
    modelEmpty : carsFilterModel.rowCount() === 0
    tableRow:
        Component{
            TableRow{
                Layout.fillWidth: true
                addToDeliveryVisible: requeredPremission
                model: [rowModel.CarId, rowModel.CarType, rowModel.CarModel,
                        rowModel.CarNumber, rowModel.VolumeCapacity,
                        rowModel.WeightCapacity, rowModel.DrivingCategory]
                onClicked: {
                    tableRoot.rowClicked(rowModel.CarId)
                }
                onOpenTab: {
                    tableRoot.openTab(rowModel.CarId)
                }
                onAddToDelivery: {
                    tableRoot.addToDelivery(rowModel.CarId)
                }
            }
        }

    onHeaderClicked: (index) => {
        carsFilterModel.changeSort(index)
    }
}

