/*! \file carsmdoel.h
 *  \brief Header file for cars model
 *
 *  Declaration of cars model class.
 *
*/

#ifndef CARSMODEL_H
#define CARSMODEL_H

#include "abstractsqlquerymodel.h"
#include <QSqlQuery>

/*!
 * \brief The CarsModel class stores cars data.
 *
 * CarsModel class store's cars records after executing query.
 *
 */
class CarsModel : public AbstractSqlQueryModel
{
    Q_OBJECT
public:
    explicit CarsModel(QObject *parent = nullptr);

public Q_SLOTS:
    bool updateCar(
        quint64 carId, const QString& carType, const QString& carModel,
        const QString& carNumber, quint64 volumeCapacity, quint64 weightCapacity,
        const QString& drivingCateogry
    );

private:
    const static char* SELECT_QUERY;
};

#endif // CARSMODEL_H
