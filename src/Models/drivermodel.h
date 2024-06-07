/*! \file drivermodel.h
 *  \brief Header file for driver model.
 *
 *  Declaration of driver model class.
 *
 */


#ifndef DRIVERMODEL_H
#define DRIVERMODEL_H

#include <QSqlQueryModel>
#include "abstractsqlquerymodel.h"

/*!
 * \brief Stores drivers records.
 *
 *  DriverModel class store's drives records after executing query.
 *
 */
class DriverModel : public AbstractSqlQueryModel
{
    Q_OBJECT
public:
    explicit DriverModel(QObject *parent = nullptr);

public Q_SLOTS:
    bool updateDriver(quint64 driverId, quint64 personId, const QString& lastName,
                      const QString& firstName, quint64 experience,
                      quint64 salary, const QString& drivingCategory);

private:
    const static char* SELECT_QUERY;
};

#endif // DRIVERMODEL_H
