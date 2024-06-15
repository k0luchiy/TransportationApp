/*! \file driversfiltermodel.cpp
 *  \brief DriversFilterModel class source file.
 *
 *  This file contains DriversFilterModel class implementation.
 *
 */
#include "driversfiltermodel.h"

DriversFilterModel::DriversFilterModel(QObject *parent)
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
void DriversFilterModel::setSourceModel(AbstractSqlQueryModel* sourceModel)
{
    m_sourceModel = sourceModel;
    this->QSortFilterProxyModel::setSourceModel(sourceModel);
}

/*!
 * \brief Changes sorting by column index
 * \param index Column index to sort by
 */
void DriversFilterModel::changeSort(quint64 index)
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

//! Getter for driver id field
quint64 DriversFilterModel::filterDriverId() const { return m_driverId; }

//! Getter for drivers first name field
QString DriversFilterModel::filterFirstName() const { return m_firstName; }

//! Getter for drivers last name field
QString DriversFilterModel::filterLastName() const { return m_lastName; }

//! Getter for drivers driving category field
QString DriversFilterModel::filterDrivingCategory() const { return m_drivingCategory; }

//! Getter for drivers minimum experience field
quint64 DriversFilterModel::filterExperience() const { return m_experience; }


/*!
 * \brief Setter for driver id filter field.
 * \param driverId  Drivers id to set.
 */
void DriversFilterModel::setFilterDriverId(quint64 driverId)
{
    m_driverId = driverId;
    invalidateFilter();
}

/*!
 * \brief Setter for drivers first name filter field.
 * \param firstName Drivers first name to set
 */
void DriversFilterModel::setFilterFirstName(const QString& firstName)
{
    m_firstName = firstName;
    invalidateFilter();
}

/*!
 * \brief Setter for drivers last name filter field.
 * \param lastName  Drivers last name to set.
 */
void DriversFilterModel::setFilterLastName(const QString& lastName)
{
    m_lastName = lastName;
    invalidateFilter();
}

/*!
 * \brief Setter for drivers driving category filter field.
 * \param drivingCategory Drivers driving category to set.
 */
void DriversFilterModel::setFilterDrivingCategory(const QString& drivingCategory)
{
    m_drivingCategory = drivingCategory;
    invalidateFilter();
}

/*!
 * \brief Setter for drivers experience filter field.
 * \param experince Drivers experience to set.
 */
void DriversFilterModel::setFilterExperience(quint64 experience)
{
    m_experience = experience;
    invalidateFilter();
}

/*!
 * \brief Setter for all filters fields. Invalidated filter just once.
 * \param driverId  Drivers id to set.
 * \param firstName Drivers first name to set.
 * \param lastName  Drivers last name to set.
 * \param drivingCategory   Drivers driving category to set.
 * \param experience    Drivers experience to set.
 */
void DriversFilterModel::setFilters
(
    quint64 driverId, const QString& firstName,
    const QString& lastName, const QString& drivingCategory,
    quint64 experience
)
{
    m_driverId = driverId;
    m_firstName = firstName;
    m_lastName = lastName;
    m_drivingCategory = drivingCategory;
    m_experience = experience;
    invalidateFilter();
}

/*! \brief Defines if row gonning to be filter out or not. Depends on source model getValue method.
 *  \param  sourceRow   Identificator of a row from source model.
 *  \param  sourceParent    Current index from source parent (currently unused).
 */
bool DriversFilterModel::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const
{
    quint64 driverId = m_sourceModel->getValue(source_row, "DriverId").toInt();
    QString firstName = m_sourceModel->getValue(source_row, "FirstName").toString();
    QString lastName = m_sourceModel->getValue(source_row, "LastName").toString();
    QString drivingCategory = m_sourceModel->getValue(source_row, "DrivingCategory").toString();
    quint64 experience = m_sourceModel->getValue(source_row, "Experience").toInt();

    return
        (m_driverId == driverId || m_driverId == 0) &&
        (QString::compare(firstName, m_firstName, Qt::CaseInsensitive) == 0
            || m_firstName.isEmpty()) &&
        (QString::compare(lastName, m_lastName, Qt::CaseInsensitive) == 0
            || m_lastName.isEmpty()) &&
        (QString::compare(drivingCategory, m_drivingCategory, Qt::CaseInsensitive) == 0
            || m_drivingCategory.isEmpty()) &&
        (m_experience >= experience  || m_experience == 0)
    ;
}
