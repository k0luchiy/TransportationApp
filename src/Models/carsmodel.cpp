/*! \file carsmodel.cpp
 *  \brief CarsModel class source file.
 *
 *  This file contains CarsModel class implementation.
 *
 */

#include "carsmodel.h"


//! Query whitch AbstractSqlQueryModel will execute for selecting all car information.
const char* CarsModel::SELECT_QUERY =
    "select \
        c.CarId, c.CarType, c.CarModel, \
        c.CarNumber, c.DrivingCategory, dc.CategoryPriority, \
        c.VolumeCapacity, c.WeightCapacity, \
        c.LastInspection, c.ReleaseYear \
    from Cars c \
    join DrivingCategories dc on c.DrivingCategory = dc.CategoryName \
    order by c.CarId";


CarsModel::CarsModel(QObject *parent)
    : AbstractSqlQueryModel{SELECT_QUERY, parent}
{

}


/*!
 * \brief Updates car's data by car id
 * \param carId Id of a car to update
 * \param carType   New car type to set
 * \param carModel  New car model to set
 * \param carNumber New car number to set
 * \param volumeCapacity    New volume capacity to set
 * \param weightCapacity    New weight capacity to set
 * \param drivingCateogry   New driving category to set
 * \return True if query executed successfully, False otherwise
 */
bool CarsModel::updateCar(
        quint64 carId, const QString& carType, const QString& carModel,
        const QString& carNumber, quint64 volumeCapacity, quint64 weightCapacity,
        const QString& drivingCategory
)
{
    QSqlQuery query;
    const QString reg_query =
        " Update Cars set  \
            carType = :carType, carModel = :carModel, \
            carNumber = :carNumber, volumeCapacity = :volumeCapacity, \
            weightCapacity = :weightCapacity, drivingCategory = :drivingCategory \
          where carId = :carId \
        ";
    query.prepare(reg_query);
    query.bindValue(":carId", carId);
    query.bindValue(":carType", carType);
    query.bindValue(":carModel", carModel);
    query.bindValue(":carNumber", carNumber);
    query.bindValue(":volumeCapacity", volumeCapacity);
    query.bindValue(":weightCapacity", weightCapacity);
    query.bindValue(":drivingCategory", drivingCategory);
    bool res = query.exec();
    updateModel();
    return res;
}
