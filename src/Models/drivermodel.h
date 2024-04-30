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
public:
    explicit DriverModel(QObject *parent = nullptr);

private:
    const static char* SELECT_QUERY;
};

#endif // DRIVERMODEL_H
