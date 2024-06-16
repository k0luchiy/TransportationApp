import QtQuick 2.15
import QtQuick.Layouts

import Colors
import Buttons
import InputFields
import Tables
import TabControls
import Utils
import Notifications

import TransportationsApp.Models 1.0

Item {
    property var carModel : Car{}
    property bool requeredPremission : user.rolePriority > 1

    id: pageRoot
    height: 800
    width: 1040

    ColumnLayout{
        anchors.fill: parent

        RowLayout{
            Layout.preferredHeight: 30
            Layout.fillWidth: true

            Text{
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                font.pointSize: 14
                color: Themes.colors.neutral.neutral950
                text: qsTr("Car") + " " + carModel.carNumber
            }

            SecondaryButton{
                Layout.preferredHeight: 30
                Layout.preferredWidth: 60
                contentColor: Themes.colors.primary.primary500
                btnText: qsTr("Save")
                visible: pageRoot.requeredPremission
                onClicked: {
                    var carId = Number(carIdField.text)
                    var carType = carTypeField.text
                    var carModel = carModelField.text
                    var carNumber = carNumberField.text
                    var volumeCapacity = Number(volumeCapacityField.text)
                    var weightCapacity = Number(weightCapacityField.text)
                    var drivingCategory = drivingCategoryField.currentText

                    var updateSuccess = true
                    if(carNumberField.text === ""){
                        carNumberField.isError = true
                        updateSuccess = false
                    } else{
                        carNumberField.isError = false
                    }
                    if(drivingCategoryField.currentIndex===0){
                        drivingCategoryField.isError = true
                        updateSuccess = false
                    } else{
                        drivingCategoryField.isError = false
                    }

                    if(!updateSuccess){
                        notificationManager.showNotification(
                            NotificationTypes.failure,
                            qsTr("Failed to update database")
                        );
                        return;
                    }

                    updateSuccess = carsModel.updateCar(carId, carType, carModel,
                                        carNumber, volumeCapacity,
                                        weightCapacity, drivingCategory);

                    if(updateSuccess){
                        notificationManager.showNotification(
                            NotificationTypes.success,
                            qsTr("Database record successfully updated")
                        );
                    }
                }
            }
        }
        RowLayout{
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10
            ColumnLayout{
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillHeight: true
                Layout.fillWidth: true
                NumberInputField{
                    id: carIdField
                    Layout.fillWidth: true
                    readOnly: true
                    title: qsTr("Id:")
                    text: carModel.carId
                }
                TextInputField{
                    id: carTypeField
                    Layout.fillWidth: true
                    readOnly: !requeredPremission
                    title: qsTr("Type:")
                    text: carModel.carType
                }
                TextInputField{
                    id: carModelField
                    Layout.fillWidth: true
                    readOnly: !requeredPremission
                    title: qsTr("Model:")
                    text: carModel.carModel
                }
                TextInputField{
                    id: carNumberField
                    Layout.fillWidth: true
                    readOnly: !requeredPremission
                    title: qsTr("Car number:")
                    text: carModel.carNumber
                }
            }
            ColumnLayout{
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillHeight: true
                Layout.fillWidth: true
                NumberInputField{
                    id: volumeCapacityField
                    Layout.fillWidth: true
                    readOnly: !requeredPremission
                    title:  qsTr("Volume capacity:")
                    text: carModel.volumeCapacity
                }
                NumberInputField{
                    id: weightCapacityField
                    Layout.fillWidth: true
                    readOnly: !requeredPremission
                    title:  qsTr("Weight capacity:")
                    text: carModel.weightCapacity
                }
                ComboBoxInputField{
                    id: drivingCategoryField
                    Layout.fillWidth: true
                    readOnly: requeredPremission
                    title:  qsTr("Driving category:")
                    model: drivingCatefories
                    textRole: "CategoryName"
                    currentIndex: drivingCategoryField.findIndex(carModel.drivingCategory)
                }
            }
        }
        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

}
