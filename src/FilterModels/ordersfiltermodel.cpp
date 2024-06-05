#include "ordersfiltermodel.h"

OrdersFilterModel::OrdersFilterModel(QObject *parent)
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
void OrdersFilterModel::setSourceModel(AbstractSqlQueryModel* sourceModel)
{
    m_sourceModel = sourceModel;
    this->QSortFilterProxyModel::setSourceModel(sourceModel);
}


//! Getter for order id field
quint64 OrdersFilterModel::filterOrderId() const { return m_orderId; }

//! Getter for order minimum created field
QDate OrdersFilterModel::filterMinCreatedDate() const { return m_minCreatedDate; }

//! Getter for order maximum created date field
QDate OrdersFilterModel::filterMaxCreatedDate() const { return m_maxCreatedDate; }

//! Getter for order minimum delivery date field
QDate OrdersFilterModel::filterMinDeliveryDate() const { return m_minDeliveryDate; }

//! Getter for order maximum delivery field
QDate OrdersFilterModel::filterMaxDeliveryDate() const { return m_maxDeliveryDate; }

//! Getter for order street field
QString OrdersFilterModel::filterAddress() const { return m_address; }

//! Getter for order street field
QString OrdersFilterModel::filterStatus() const { return m_status; }

//! Getter for order cost field
quint64 OrdersFilterModel::filterCost() const { return m_cost; }

/*!
 * \brief Setter for order id filter field.
 * \param orderId Order id to set.
 */
void OrdersFilterModel::setFilterOrderId(quint64 orderId)
{
    m_orderId = orderId;
    invalidateRowsFilter();
}

/*!
 * \brief  Setter for order minimum created date filter field.
 * \param minCreatedDate Lower bound for order created date value to set.
 */
void OrdersFilterModel::setFilterMinCreatedDate(const QDate& minCreatedDate)
{
    m_minCreatedDate = minCreatedDate;
    invalidateRowsFilter();
}

/*!
 * \brief Setter for order maximum created date filter field.
 * \param maxCreatedDate Upper bound for order created date value to set.
 */
void OrdersFilterModel::setFilterMaxCreatedDate(const QDate& maxCreatedDate)
{
    m_maxCreatedDate = maxCreatedDate;
    invalidateRowsFilter();
}

/*!
 * \brief Setter for order minimum delivery date filter field.
 * \param minDeliveryDate Lower bound for order delivery date value to set.
 */
void OrdersFilterModel::setFilterMinDeliveryDate(const QDate& minDeliveryDate)
{
    m_minDeliveryDate = minDeliveryDate;
    invalidateRowsFilter();
}

/*!
 * \brief Setter for order maximum delivery date filter field.
 * \param maxDeliveryDate Upper bound for order delivery date value to set.
 */
void OrdersFilterModel::setFilterMaxDeliveryDate(const QDate& maxDeliveryDate)
{
    m_maxDeliveryDate = maxDeliveryDate;
    invalidateRowsFilter();
}

/*!
 * \brief Setter for order address street filter field.
 * \param street Street address to set.
 */
void OrdersFilterModel::setFilterAddress(const QString& address)
{
    m_address = address;
    invalidateRowsFilter();
}

/*!
 * \brief Setter for order address street filter field.
 * \param street Street address to set.
 */
void OrdersFilterModel::setFilterStatus(const QString& status)
{
    m_status = status;
    invalidateRowsFilter();
}

/*!
 * \brief Setter for order address cost filter field.
 * \param cost Order cost to set.
 */
void OrdersFilterModel::setFilterCost(quint64 cost)
{
    m_cost = cost;
    invalidateRowsFilter();
}

/*!
 * \brief Setter for all filters fields. Invalidated filter just once.
 * \param orderId Order id to set.
 * \param minCreatedDate Lower bound for order created date value to set.
 * \param maxCreatedDate Upper bound for order created date value to set.
 * \param minDeliveryDate Lower bound for order delivery date value to set.
 * \param maxDeliveryDate Upper bound for order delivery date value to set.
 * \param street Street address to set.
 * \param cost Order cost to set.
 */
void OrdersFilterModel::setFilters
(
    quint64 orderId, const QDate& minCreatedDate,
    const QDate& maxCreatedDate, const QDate& minDeliveryDate,
    const QDate& maxDeliveryDate, const QString& address,
    const QString& status, quint64 cost
)
{
    m_orderId = orderId;
    m_minCreatedDate = minCreatedDate;
    m_maxCreatedDate = maxCreatedDate;
    m_minDeliveryDate = minDeliveryDate;
    m_maxDeliveryDate = maxDeliveryDate;
    m_address = address;
    m_status = status;
    m_cost = cost;
    invalidateRowsFilter();
}


/*!
 * \brief Checks if given date is between two others.
 * \param date  Date to check.
 * \param startDate Lower bound date for validation.
 * \param endDate   Upper bound date for validation.
 * \return True if given date is between startDate and endDate, false otherwise.
 */
bool OrdersFilterModel::isDateInRange(const QDate& date, const QDate& startDate, const QDate& endDate) const
{
    return (!startDate.isValid() || date >= startDate)
           && (!endDate.isValid() || date <= endDate);
}


/*! \brief Defines if row gonning to be filter out or not. Depends on source model getValue method.
 *  \param  sourceRow   Identificator of a row from source model.
 *  \param  sourceParent    Current index from source parent (currently unused).
 */
bool OrdersFilterModel::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const
{
    quint64 orderId = m_sourceModel->getValue(source_row, "OrderId").toInt();
    QDate createdDate = m_sourceModel->getValue(source_row, "CreatedDate").toDate();
    QDate deliveryDate = m_sourceModel->getValue(source_row, "AskedDeliveryDate").toDate();
    QString address = m_sourceModel->getValue(source_row, "Address").toString();
    QString status = m_sourceModel->getValue(source_row, "StatusTitle").toString();
    quint64 cost = m_sourceModel->getValue(source_row, "Cost").toInt();

    return
        (m_orderId == orderId || m_orderId == 0) &&
        isDateInRange(createdDate, m_minCreatedDate, m_maxCreatedDate) &&
        isDateInRange(deliveryDate, m_minDeliveryDate, m_maxDeliveryDate) &&
        address.contains(QRegularExpression(m_address, QRegularExpression::CaseInsensitiveOption)) &&
        (QString::compare(status, m_status, Qt::CaseInsensitive) == 0 || m_status.isEmpty()) &&
        (m_cost < cost  || m_cost == 0)
        ;
}
