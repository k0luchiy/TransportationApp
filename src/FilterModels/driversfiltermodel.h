/*! \file driversfiltermodel.h
 *  \brief Header file for DriversFilterModel class
 *
 *  Declaration of drivers filter model class.
 *
 */

#ifndef DRIVERSFILTERMODEL_H
#define DRIVERSFILTERMODEL_H

#include <QSortFilterProxyModel>
#include "abstractsqlquerymodel.h"

class DriversFilterModel : public QSortFilterProxyModel
{
    Q_OBJECT
public:
    explicit DriversFilterModel(QObject *parent = nullptr);
    void setSourceModel(AbstractSqlQueryModel* sourceModel);

public Q_SLOTS: // Getters
    quint64 filterDriverId() const;
    QString filterFirstName() const;
    QString filterLastName() const;
    QString filterDrivingCategory() const;
    quint64 filterExperience() const;


public Q_SLOTS: // Setters
    void setFilterDriverId(quint64 driverId);
    void setFilterFirstName(const QString& firstName);
    void setFilterLastName(const QString& lastName);
    void setFilterDrivingCategory(const QString& drivingCategory);
    void setFilterExperience(quint64 experince);
    void setFiltes(
        quint64 driverId, const QString& firstName,
        const QString& lastName, const QString& dtivingCategoty,
        quint64 experience
    );


protected:
    bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const;

private:
    AbstractSqlQueryModel* m_sourceModel;   //! Source model for filter.

    quint64 m_driverId = 0; //!< Driver id field for filter
    QString m_firstName = "";   //!< Drivers first name field for filter
    QString m_lastName = "";    //!< Drivers last name field for filter
    QString m_drivingCategory = ""; //!< Drivers driving category field for filter
    quint64 m_experience = 0;    //!< Minimum experience of a driver for filter
};

#endif // DRIVERSFILTERMODEL_H
