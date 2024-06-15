#include "deliveriesfiltermodel.h"

DeliveriesFilterModel::DeliveriesFilterModel(QObject *parent)
    : QSortFilterProxyModel{parent}
{

}

/*!
 * \brief Sets source model to filter.
*
*  Sets source model that have to be inherited from AbstractSqlQueryModel.
*
*  \param sourceModel Source model to set.
*/
void DeliveriesFilterModel::setSourceModel(AbstractSqlQueryModel* sourceModel)
{
    m_sourceModel = sourceModel;
    this->QSortFilterProxyModel::setSourceModel(sourceModel);
}

/*!
 * \brief Changes sorting by column index
 * \param index Column index to sort by
 */
void DeliveriesFilterModel::changeSort(quint64 index)
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

//! Getter for delivery id fitler.
quint64 DeliveriesFilterModel::filterDeliveryId() const { return m_deliveryId; }

//! Getter for car number fitler.
QString DeliveriesFilterModel::filterCarNumber() const { return m_carNumber; }

//! Getter for drivers name fitler.
QString DeliveriesFilterModel::filterDriverName() const { return m_driverName; }

//! Getter for delivery departure lower bound date fitler.
QDate DeliveriesFilterModel::filterMinDepartureDate() const { return m_minDepartureDate; }

//! Getter for delivery departure upper bound date fitler.
QDate DeliveriesFilterModel::filterMaxDepartureDate() const { return m_maxDepartureDate; }

//! Getter for delivery return lower bound date fitler.
QDate DeliveriesFilterModel::filterMinReturnDate() const { return m_minReturnDate; }

//! Getter for delivery return upper bound date fitler.
QDate DeliveriesFilterModel::filterMaxReturnDate() const { return m_maxReturnDate; }

//! Getter for delivery status fitler.
QString DeliveriesFilterModel::filterStatus() const { return m_status; }

//! Getter for delivery last location fitler.
QString DeliveriesFilterModel::filterToLocation() const { return m_toLocation; }

/*!
 * \brief Setter for delivery id filter field.
 * \param deliveryId Delivery id to set.
 */
void DeliveriesFilterModel::setFilterDriverId(quint64 deliveryId)
{
    m_deliveryId = deliveryId;
    invalidateFilter();
}

/*!
 * \brief Setter for current car number for delivery filter field.
 * \param carNumber Car number to set.
 */
void DeliveriesFilterModel::setFilterCarNumber(const QString& carNumber)
{
    m_carNumber = carNumber;
    invalidateFilter();
}

/*!
 * \brief Setter for drivers name for delivery filter field.
 * \param driverName Driver name for delivery
 */
void DeliveriesFilterModel::setFilterDriverName(const QString& driverName)
{
    m_driverName = driverName;
    invalidateFilter();
}

/*!
 * \brief Setter for departure date lower bound for delivery filter field.
 * \param minDepartureDate Departure date lower bound to set.
 */
void DeliveriesFilterModel::setFilterMinDepartureDate(const QDate& minDepartureDate)
{
    m_minDepartureDate = minDepartureDate;
    invalidateFilter();
}

/*!
 * \brief Setter for departure date upper bound for delivery filter field.
 * \param maxDepartureDate Departure date upper bound to set.
 */
void DeliveriesFilterModel::setFilterMaxDepartureDate(const QDate& maxDepartureDate)
{
    m_maxDepartureDate = maxDepartureDate;
    invalidateFilter();
}

/*!
 * \brief Setter for return date lower bound for delivery filter field.
 * \param minReturnDate Return date lower bound to set.
 */
void DeliveriesFilterModel::setFilterMinReturnDate(const QDate& minReturnDate)
{
    m_minReturnDate = minReturnDate;
    invalidateFilter();
}

/*!
 * \brief Setter for return date upper bound for delivery filter field.
 * \param maxReturnDate Return date upper bound to set.
 */
void DeliveriesFilterModel::setFilterMaxReturnDate(const QDate& maxReturnDate)
{
    m_maxReturnDate = maxReturnDate;
    invalidateFilter();
}

/*!
 * \brief Setter for delivery status filter field.
 * \param status Delivery status filter to set.
 */
void DeliveriesFilterModel::setFilterStatus(const QString& status)
{
    m_status = status;
    invalidateFilter();
}

/*!
 * \brief Setter for delivery last address filter field.
 * \param toLocation Delivery last address filter to set.
 */
void DeliveriesFilterModel::setFilterToLocation(const QString& toLocation)
{
    m_toLocation = toLocation;
    invalidateFilter();
}

/*!
 * \brief setFilters Setter for all filters fields. Invalidated filter just once.
 * \param deliveryId Delivery id to set.
 * \param carNumber Car number to set.
 * \param driverName Driver name to set.
 * \param minDepartureDate Lower bound of departure date to set.
 * \param maxDepartureDate upper bound of departure date to set.
 * \param minReturnDate Lower bound of return date to set.
 * \param maxReturnDate Upper bound of return date to set.
 * \param status Delivery status to set.
 * \param toLocation Delivery last address to set.
 */
void DeliveriesFilterModel::setFilters(
    quint64 deliveryId, const QString& carNumber,
    const QString& driverName, const QDate& minDepartureDate,
    const QDate& maxDepartureDate, const QDate& minReturnDate,
    const QDate& maxReturnDate, const QString& status//, const QString& toLocation
)
{
    m_deliveryId = deliveryId;
    m_carNumber = carNumber;
    m_driverName = driverName;
    m_minDepartureDate = minDepartureDate;
    m_maxDepartureDate = maxDepartureDate;
    m_minReturnDate= minReturnDate;
    m_maxReturnDate = maxReturnDate;
    m_status = status;
    //m_toLocation = toLocation;

    invalidateFilter();
}

/*!
 * \brief Checks if given date is between two others.
 * \param date  Date to check.
 * \param startDate Lower bound date for validation.
 * \param endDate   Upper bound date for validation.
 * \return True if given date is between startDate and endDate, false otherwise.
 */
bool DeliveriesFilterModel::isDateInRange(const QDate& date, const QDate& startDate, const QDate& endDate) const
{
    return (!startDate.isValid() || date >= startDate)
           && (!endDate.isValid() || date <= endDate);
}

/*! \brief Defines if row gonning to be filter out or not. Depends on source model getValue method.
 *  \param  sourceRow   Identificator of a row from source model.
 *  \param  sourceParent    Current index from source parent (currently unused).
 */
bool DeliveriesFilterModel::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const
{
    quint64 deliveryId = m_sourceModel->getValue(source_row, "DeliveryId").toInt();
    QString carNumber = m_sourceModel->getValue(source_row, "CarNumber").toString();
    QString driverName = m_sourceModel->getValue(source_row, "DriverName").toString();
    QDate departureDate = m_sourceModel->getValue(source_row, "DepartureDate").toDate();
    QDate returnDate = m_sourceModel->getValue(source_row, "ReturnDate").toDate();
    QString status = m_sourceModel->getValue(source_row, "StatusTitle").toString();
    //QString toLocation = m_sourceModel->getValue(source_row, "ToLocation").toString();

    return
        (m_deliveryId == 0 || m_deliveryId == deliveryId) &&
        carNumber.contains(QRegularExpression(m_carNumber, QRegularExpression::CaseInsensitiveOption)) &&
        driverName.contains(QRegularExpression(m_driverName, QRegularExpression::CaseInsensitiveOption)) &&
        isDateInRange(departureDate, m_minDepartureDate, m_maxDepartureDate) &&
        isDateInRange(returnDate, m_minReturnDate, m_maxReturnDate) &&
        //toLocation.contains(QRegularExpression(m_toLocation, QRegularExpression::CaseInsensitiveOption)) &&
        (QString::compare(status, m_status, Qt::CaseInsensitive) == 0 || m_status.isEmpty())
    ;
}

