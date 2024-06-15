#include "deliveriesmodel.h"

//! Query whitch AbstractSqlQueryModel will execute for selecting all delivery information.
const char* DeliveriesModel::SELECT_QUERY =
    "select del.DeliveryId, del.CarId, c.CarNumber, del.DriverId, pi.LastName, pi. FirstName, \
            CONCAT(pi.LastName, ' ', pi. FirstName) as DriverName, \
            del.DepartureDate, del.ReturnDate, del.StatusId, s.StatusTitle, del.CreatedBy \
    from Deliveries del \
    join Cars c on del.CarId = c.CarId \
    join Drivers dr on del.DriverId = dr.DriverId \
    join PersonalInfo pi on dr.PersonId = pi.PersonId \
    join OrderStatus s on del.StatusId = s.StatusId ";

DeliveriesModel::DeliveriesModel(QObject *parent)
    : AbstractSqlQueryModel{SELECT_QUERY, parent}
{

}

bool DeliveriesModel::updateDelivery(
    quint64 deliveryId, quint64 carId, quint64 driverId,
    const QDate& departureDate, const QDate& returnDate, quint64 statusId,
    quint64 userId
)
{

}

quint64 DeliveriesModel::createDelivery(quint64 userId)
{
    QSqlQuery query;
    const QString reg_query =
        "Insert into Deliveries(CarId, DriverId, DepartureDate, ReturnDate, StatusId, CreatedBy) \
        values(1, 1, NOW(), NOW(), 1, :createdBy)";

    query.prepare(reg_query);
    query.bindValue(":createdBy", userId);
    query.exec();
    quint64 lastId = query.lastInsertId().toUInt();
    updateModel();
    return lastId;
}
