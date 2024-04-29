/*! \file drivermodel.h
 *  \brief Header file for driver model.
 *
 *  Declaration of driver model class.
 *
 */


#ifndef DRIVERMODEL_H
#define DRIVERMODEL_H

#include <QSqlQueryModel>

class DriverModel : public QSqlQueryModel
{
public:
    explicit DriverModel(QObject *parent = nullptr);
};

#endif // DRIVERMODEL_H
