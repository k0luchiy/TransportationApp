import QtQuick 2.15
import QtQuick.Layouts

TableBase{
    id : tableRoot
    tableHeaders :  ["Id", "Type", "Model", "Car number", "Volume", "Weight", "Driving category"]
    tableModel : carsFilterModel
    modelEmpty : carsFilterModel.rowCount() === 0
    tableRow:
        Component{
            TableRow{
                Layout.fillWidth: true
                model: [rowModel.CarId, rowModel.CarType, rowModel.CarModel,
                        rowModel.CarNumber, rowModel.VolumeCapacity,
                        rowModel.WeightCapacity, rowModel.DrivingCategory]
                onClicked: {
                    tableRoot.rowClicked(rowModel.CarId)
                }
            }
        }
}

