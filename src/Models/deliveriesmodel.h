#ifndef DELIVERIESMODEL_H
#define DELIVERIESMODEL_H

#include "abstractsqlquerymodel.h"
#include <QObject>
#include <QDate>

class DeliveriesModel : public AbstractSqlQueryModel
{
    Q_OBJECT
public:
    explicit DeliveriesModel(QObject *parent = nullptr);

public Q_SLOTS:
    bool updateDelivery(
        quint64 deliveryId, quint64 carId, quint64 driverId,
        const QDate& departureDate, const QDate& returnDate, quint64 statusId,
        quint64 userId
    );

private:
    const static char* SELECT_QUERY;
};

#endif // DELIVERIESMODEL_H
