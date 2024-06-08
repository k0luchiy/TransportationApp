#include "delivery.h"

Delivery::Delivery(QObject *parent)
    : QObject{parent}
{

}

quint64 Delivery::deliveryId() const { return m_deliveryId; }
quint64 Delivery::carId() const { return m_carId; }
quint64 Delivery::driverId() const { return m_driverId; }
QDate Delivery::departureDate() const { return m_departureDate; }
QDate Delivery::returnDate() const { return m_returnDate; }
quint64 Delivery::statusId() const { return m_statusId; }
QString Delivery::statusTitle() const { return m_statusTitle; }


void Delivery::setDeliveryId(quint64 deliveryId) { m_deliveryId = deliveryId; deliveryIdChanged(); }
void Delivery::setCarId(quint64 carId) { m_carId = carId; carIdChanged(); }
void Delivery::setDriverId(quint64 driverId) { m_driverId = driverId; driverIdChanged(); }
void Delivery::setDepartureDate(const QDate &departureDate) { m_departureDate = departureDate; departureDateChanged(); }
void Delivery::setReturnDate(const QDate &returnDate) { m_returnDate = returnDate; returnDateChanged(); }
void Delivery::setStatusId(quint64 statusId) { m_statusId = statusId; statusIdChanged(); }
void Delivery::setStatusTitle(const QString &statusTitle) { m_statusTitle = statusTitle; statusTitleChanged(); }


void Delivery::setData(
    quint64 deliveryId, quint64 carId, quint64 driverId,
    const QDate& departureDate, const QDate& returnDate,
    quint64 statusId, const QString& statusTitle
)
{
    setDeliveryId(deliveryId);
    setCarId(carId);
    setDriverId(driverId);
    setDepartureDate(departureDate);
    setReturnDate(returnDate);
    setStatusId(statusId);
    setStatusTitle(statusTitle);
}

void Delivery::setRecord(const QSqlRecord& record)
{
    quint64 deliveryId = record.value("DeliveryId").toInt();
    quint64 carId = record.value("CarId").toInt();
    quint64 driverId = record.value("DriverId").toInt();
    QDate departureDate = record.value("DepartureDate").toDate();
    QDate returnDate = record.value("ReturnDate").toDate();
    quint64 statusId = record.value("StatusId").toInt();
    QString statusTitle = record.value("StatusTitle").toString();

    setData(
        deliveryId, carId, driverId,
        departureDate, returnDate,
        statusId, statusTitle
    );
}
