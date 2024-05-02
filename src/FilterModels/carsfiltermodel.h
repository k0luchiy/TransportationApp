/*! \file carsfiltermodel.h
 *  \brief Header file for CarsFilterModel class
 *
 *  Declaration of car filter model class.
 *
 */

#ifndef CARSFILTERMODEL_H
#define CARSFILTERMODEL_H

#include <QSortFilterProxyModel>
#include "abstractsqlquerymodel.h"

class CarsFilterModel : public QSortFilterProxyModel
{
public:
    explicit CarsFilterModel(QObject *parent = nullptr);
    void setSourceModel(AbstractSqlQueryModel* sourceModel);

protected:
    bool filterAcceptsRow(
        int sourceRow,
        const QModelIndex &sourceParent
    ) const;



public: // Getters
    quint64 filterCarId() const;
    QString filterCarType() const;
    QString filterCarModel() const;
    QString filterCarNumber() const;
    quint64 filterMinVolumeCapacity() const;
    quint64 filterMinWeightCapacity() const;
    QString filterDrivingCategory() const;

public: // Setters
    void setFilterCarId(quint64 carId);
    void setFilterCarType(const QString& carType);
    void setFilterCarModel(const QString& carModel);
    void setFilterCarNumber(const QString& carNumber);
    void setFilterMinVolumeCapacity(quint64 minVolumeCapacity);
    void setFilterMinWeightCapacity(quint64 minWeightCapacity);
    void setFilterDrivingCategory(const QString& drivingCategory);

    void setFilters(
        quint64 carId, const QString& carType,
        const QString& carModel, const QString& carNumber,
        quint64 volumeCapacity, quint64 weightCapacity,
        const QString& drivinigCategory
    );

private:
    AbstractSqlQueryModel* m_sourceModel;   //! Source model for filter.

    quint64 m_carId = 0;    //!< Car id field for filter
    QString m_carType = ""; //!< Car type field for filter
    QString m_carModel = "";    //!< Car model field for filter
    QString m_carNumber = "";   //!< Car number field for filter
    quint64 m_minVolumeCapacity = 0;    //!< Car minimum volume capacity field for filter
    quint64 m_minWeightCapacity = 0;    //!< Car minimum weight capacity  field for filter
    QString m_drivingCategory = "";   //!< Car driving category field for filter
};

#endif // CARSFILTERMODEL_H
