#include "drivermodel.h"

//! Query whitch AbstractSqlQueryModel will execute for selecting all drivers information.
const char* DriverModel::SELECT_QUERY =
    "select dr.DriverId, pi.FirstName, pi.MiddleName, pi.LastName, \
    pi.BirthDate, sc.ScheduleId, sc.ScheduleTitle, \
    dr.DrivingCategory, dr.Salary, dr.Experience \
    from Drivers dr \
    join PersonalInfo pi on dr.PersonId = pi.PersonId   \
    join Schedules sc on dr.ScheduleId = sc.ScheduleId";


DriverModel::DriverModel(QObject *parent)
    : AbstractSqlQueryModel{SELECT_QUERY, parent}
{

}
