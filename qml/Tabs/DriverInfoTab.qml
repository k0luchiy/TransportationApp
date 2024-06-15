import QtQuick 2.15
import QtQuick.Layouts

import Colors
import Buttons
import InputFields
import Tables
import TabControls
import Notifications

import TransportationsApp.Models 1.0

Item {
    property var driverModel : Driver{}

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
                text: qsTr("Driver") + " " + driverModel.driverId
            }

            SecondaryButton{
                Layout.preferredHeight: 30
                Layout.preferredWidth: 60
                contentColor: Themes.colors.primary.primary500
                btnText: qsTr("Save")
                onClicked: {
                    var driverId = Number(driverIdField.text)
                    var personId = Number(driverModel.personId)
                    var lastName = lastNameField.text
                    var firstName = firstNameField.text
                    var experience = Number(experienceField.text)
                    var salary = Number(salaryField.text)
                    var drivingCategory = drivingCategoryField.currentText

                    var updateSuccess = true
                    if(lastName.text === ""){
                        lastName.isError = true
                        updateSuccess = false
                    } else{
                        lastName.isError = false
                    }
                    if(firstName.text === ""){
                        firstName.isError = true
                        updateSuccess = false
                    } else{
                        firstName.isError = false
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

                    updateSuccess = driversModel.updateDriver(driverId, personId, lastName,
                                        firstName, experience,
                                        salary, drivingCategory);

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
                    id: driverIdField
                    Layout.fillWidth: true
                    readOnly: true
                    title: qsTr("Id:")
                    text: driverModel.driverId
                }
                TextInputField{
                    id: lastNameField
                    Layout.fillWidth: true
                    title: qsTr("Last name:")
                    text: driverModel.lastName
                }
                TextInputField{
                    id: firstNameField
                    Layout.fillWidth: true
                    title: qsTr("First name:")
                    text: driverModel.firstName
                }
            }
            ColumnLayout{
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillHeight: true
                Layout.fillWidth: true
                NumberInputField{
                    id: experienceField
                    Layout.fillWidth: true
                    title:  qsTr("Experience:")
                    text: driverModel.experience
                }
                NumberInputField{
                    id: salaryField
                    Layout.fillWidth: true
                    title:  qsTr("Salary:")
                    text: driverModel.salary
                }
                ComboBoxInputField{
                    id: drivingCategoryField
                    Layout.fillWidth: true
                    title:  qsTr("Driving category:")
                    model: drivingCatefories
                    textRole: "CategoryName"
                    currentIndex: drivingCategoryField.findIndex(driverModel.drivingCategory)
                }
            }
        }
        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

}
