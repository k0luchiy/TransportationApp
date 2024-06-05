#include "car.h"
#include <QDebug>

Car::Car(QObject *parent)
    : QObject{parent}
{

}

//
// Getters
//
quint64 Car::carId() const { return m_carId; }
QString Car::carType() const { return m_carType; }
QString Car::carModel() const { return m_carModel; }
QString Car::carNumber() const { return m_carNumber; }
quint64 Car::volumeCapacity() const { return m_volumeCapacity; }
quint64 Car::weightCapacity() const { return m_weightCapacity; }
QString Car::drivingCategory() const { return m_drivingCategory; }

//
// Setters
//
void Car::setCarId(quint64 carId) { m_carId = carId; carIdChanged(); }
void Car::setCarType(const QString &carType) { m_carType = carType; carTypeChanged(); }
void Car::setCarModel(const QString &carModel) { m_carModel = carModel; carModelChanged(); }
void Car::setCarNumber(const QString &carNumber) { m_carNumber = carNumber; carNumberChanged(); }
void Car::setVolumeCapacity(quint64 volumeCapacity) { m_volumeCapacity = volumeCapacity; volumeCapacityChanged(); }
void Car::setWeightCapacity(quint64 weightCapacity) { m_weightCapacity = weightCapacity; weightCapacityChanged(); }
void Car::setDrivingCategory(const QString &drivingCategory) { m_drivingCategory = drivingCategory; drivingCategoryChanged(); }


void Car::setData(
    quint64 carId, const QString& carType,
    const QString& carModel, const QString& carNumber,
    quint64 volumeCapacity, quint64 weightCapacity,
    const QString& drivingCategory
)
{
    setCarId(carId);
    setCarType(carType);
    setCarModel(carModel);
    setCarNumber(carNumber);
    setVolumeCapacity(volumeCapacity);
    setWeightCapacity(weightCapacity);
    setDrivingCategory(drivingCategory);
}

void Car::setRecord(const QSqlRecord& record)
{
    quint64 carId = record.value("CarId").toInt();
    QString carType = record.value("CarType").toString();
    QString carModel = record.value("CarModel").toString();
    QString carNumber = record.value("CarNumber").toString();
    quint64 volumeCapacity = record.value("VolumeCapacity").toInt();
    quint64 weightCapacity = record.value("WeightCapacity").toInt();
    QString drivingCategory = record.value("DrivingCategory").toString();

    setData(carId , carType, carModel,
            carNumber, volumeCapacity,
            weightCapacity, drivingCategory
    );

}
