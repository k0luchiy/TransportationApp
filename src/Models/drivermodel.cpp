/*! \file drivermodel.cpp
 *  \brief DriverModel class source file.
 *
 *  This file contains DriverModel class implementation.
 *
 */

#include "drivermodel.h"
#include <QDebug>

//! Query whitch AbstractSqlQueryModel will execute for selecting all drivers information.
const char* DriverModel::SELECT_QUERY =
    "select dr.DriverId, dr.PersonId, pi.FirstName, pi.MiddleName, pi.LastName, \
    pi.BirthDate, sc.ScheduleId, sc.ScheduleTitle, \
    dr.DrivingCategory, dc.CategoryPriority, dr.Salary, dr.Experience \
    from Drivers dr \
    join DrivingCategories dc on dr.DrivingCategory = dc.CategoryName \
    join PersonalInfo pi on dr.PersonId = pi.PersonId   \
    join Schedules sc on dr.ScheduleId = sc.ScheduleId \
    order by dr.DriverId";


DriverModel::DriverModel(QObject *parent)
    : AbstractSqlQueryModel{SELECT_QUERY, parent}
{

}

bool DriverModel::updateDriver(
        quint64 driverId, quint64 personId, const QString& lastName,
        const QString& firstName, quint64 experience,
        quint64 salary, const QString& drivingCategory)
{
    QSqlQuery query;
    const QString person_update_query =
        "Update PersonalInfo set  \
        lastName = :lastName, firstName = :firstName \
        where personId = :personId ";
    query.prepare(person_update_query);
    query.bindValue(":lastName", lastName);
    query.bindValue(":firstName", firstName);
    query.bindValue(":personId", personId);

    bool res = query.exec();

    const QString driver_update_query =
        "Update Drivers set  \
        experience = :experience, salary = :salary \
        where driverId = :driverId";
    query.prepare(driver_update_query);
    query.bindValue(":experience", experience);
    query.bindValue(":salary", salary);
    query.bindValue(":drivingCategory", drivingCategory);
    query.bindValue(":driverId", driverId);

    res &= query.exec();
    updateModel();

    return res;
}
