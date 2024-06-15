/*! \file carsfiltermodel.cpp
 *  \brief CarsFilterModel class source file.
 *
 *  This file contains CarsFilterModel class implementation.
 *
 */

#include "carsfiltermodel.h"
#include <QDebug>

CarsFilterModel::CarsFilterModel(QObject *parent)
    : QSortFilterProxyModel{parent}
{

}

/*!
 *  \brief Sets source model to filter.
 *
 *  Sets source model that have to be inherited from AbstractSqlQueryModel.
 *
 *  \param sourceModel Source model to set.
 */
void CarsFilterModel::setSourceModel(AbstractSqlQueryModel* sourceModel)
{
    m_sourceModel = sourceModel;
    this->QSortFilterProxyModel::setSourceModel(sourceModel);
}

/*!
 * \brief Changes sorting by column index
 * \param index Column index to sort by
 */
void CarsFilterModel::changeSort(quint64 index)
{
    if(this->sortColumn() == index){
        if(this->sortOrder() == Qt::AscendingOrder){
            this->sort(index, Qt::DescendingOrder);
        }
        else{
            this->sort(index, Qt::AscendingOrder);
        }
    }
    else{
        this->sort(index, Qt::AscendingOrder);
    }
}

//! Getter for car id fitler.
quint64 CarsFilterModel::filterCarId() const { return m_carId; }

//! Getter for car type fitler.
QString CarsFilterModel::filterCarType() const { return m_carType; }

//! Getter for car model fitler.
QString CarsFilterModel::filterCarModel() const { return m_carModel; }

//! Getter for car number fitler.
QString CarsFilterModel::filterCarNumber() const { return m_carNumber; }

//! Getter for car volume capacity fitler.
quint64 CarsFilterModel::filterMinVolumeCapacity() const { return m_minVolumeCapacity; }

//! Getter for car weight capacity fitler.
quint64 CarsFilterModel::filterMinWeightCapacity() const { return m_minWeightCapacity; }

//! Getter for car driving category fitler.
QString CarsFilterModel::filterDrivingCategory() const { return m_drivingCategory; }

/*!
 * \brief Setter for car id filter field
 * \param carId Car id to set
 */
void CarsFilterModel::setFilterCarId(quint64 carId)
{
    m_carId = carId;
    invalidateFilter();
}

/*! \brief Setter for car type filter field
 *  \param carType Car type to set.
 */
void CarsFilterModel::setFilterCarType(const QString& carType)
{
    m_carType = carType;
    invalidateFilter();
}

/*! \brief Setter for car model filter field
*   \param carModel Car model to set.
*/
void CarsFilterModel::setFilterCarModel(const QString& carModel)
{
    m_carModel = carModel;
    invalidateFilter();
}

/*! \brief Setter for car number filter field
 *  \param carNumber Car number to set.
 */
void CarsFilterModel::setFilterCarNumber(const QString& carNumber)
{
    m_carNumber = carNumber;
    invalidateFilter();
}

/*! \brief Setter for car volume capacity filter field
 *  \param minVolumeCapacity Car minimum volume capacity to set.
 */
void CarsFilterModel::setFilterMinVolumeCapacity(quint64 minVolumeCapacity)
{
    m_minVolumeCapacity = minVolumeCapacity;
    invalidateFilter();
}

/*! \brief Setter for car weight capacity filter field
 *  \param minWeightCapacity Car minimum weight capacity to set.
 */
void CarsFilterModel::setFilterMinWeightCapacity(quint64 minWeightCapacity)
{
    m_minWeightCapacity = minWeightCapacity;
    invalidateFilter();
}

/*! \brief Setter for car driving category filter field.
 *  \param Car driving category to set.
 */
void CarsFilterModel::setFilterDrivingCategory(const QString& drivingCategory) {
    m_drivingCategory = drivingCategory;
    invalidateFilter();
}

/*!
 * \brief Setter for all filters fields. Invalidated filter just once.
 * \param carId Car id to set.
 * \param carType   Car type to set.
 * \param carModel  Car model to set.
 * \param carNumber Car number to set.
 * \param volumeCapacity    Car volume capacity to set.
 * \param weightCapacity    Car weight capacirt to set.
 * \param drivinigCategory  Car driving category to set.
 */
void CarsFilterModel::setFilters
(
        quint64 carId, const QString& carType,
        const QString& carModel, const QString& carNumber,
        quint64 volumeCapacity, quint64 weightCapacity,
        const QString& drivinigCategory
)
{
    m_carId = carId;
    m_carType = carType;
    m_carModel = carModel;
    m_carNumber = carNumber;
    m_minVolumeCapacity = volumeCapacity;
    m_minWeightCapacity = weightCapacity;
    m_drivingCategory = drivinigCategory;
    invalidateFilter();
}

/*! \brief Defines if row gonning to be filter out or not. Depends on source model getValue method.
 *  \param  sourceRow   Identificator of a row from source model.
 *  \param  sourceParent    Current index from source parent (currently unused).
 */
bool CarsFilterModel::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    quint64 carId = m_sourceModel->getValue(sourceRow, "CarId").toInt();
    QString carType = m_sourceModel->getValue(sourceRow, "CarType").toString();
    QString carModel = m_sourceModel->getValue(sourceRow, "CarModel").toString();
    QString carNumber = m_sourceModel->getValue(sourceRow, "CarNumber").toString();
    quint64 volumeCapacity = m_sourceModel->getValue(sourceRow, "VolumeCapacity").toInt();
    quint64 weightCapacity = m_sourceModel->getValue(sourceRow, "WeightCapacity").toInt();
    QString drivingCategory = m_sourceModel->getValue(sourceRow, "DrivingCategory").toString();

    return
        (m_carId == carId || m_carId == 0) &&
        carType.contains(QRegularExpression(m_carType, QRegularExpression::CaseInsensitiveOption))  &&
        carModel.contains(QRegularExpression(m_carModel, QRegularExpression::CaseInsensitiveOption))  &&
        carNumber.contains(QRegularExpression(m_carNumber, QRegularExpression::CaseInsensitiveOption))  &&
        (volumeCapacity >= m_minVolumeCapacity || m_minVolumeCapacity == 0) &&
        (weightCapacity >= m_minWeightCapacity || m_minWeightCapacity == 0) &&
        (QString::compare(drivingCategory, m_drivingCategory, Qt::CaseInsensitive) == 0 || m_drivingCategory.isEmpty())
    ;
}

