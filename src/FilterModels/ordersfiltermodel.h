/*! \file ordersfiltermodel.h
 *  \brief Header file for OrdersFilterModel class
 *
 *  Declaration of orders filter model class.
 *
 */

#ifndef ORDERSFILTERMODEL_H
#define ORDERSFILTERMODEL_H

#include <QSortFilterProxyModel>
#include "abstractsqlquerymodel.h"
#include <QString>
#include <QDate>

class OrdersFilterModel : public QSortFilterProxyModel
{
    Q_OBJECT
public:
    explicit OrdersFilterModel(QObject *parent = nullptr);
    void setSourceModel(AbstractSqlQueryModel* sourceModel);

protected:
    bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const;
    bool isDateInRange(
        const QDate& date,
        const QDate& startDate,
        const QDate& endDate
    ) const;

public Q_SLOTS: //Getters
    quint64 filterOrderId() const;
    QDate filterMinCreatedDate() const;
    QDate filterMaxCreatedDate() const;
    QDate filterMinDeliveryDate() const;
    QDate filterMaxDeliveryDate() const;
    QString filterAddress() const;
    QString filterStatus() const;
    quint64 filterCost() const;

public Q_SLOTS: // Setters
    void setFilterOrderId(quint64 orderId);
    void setFilterMinCreatedDate(const QDate& minCreatedDate);
    void setFilterMaxCreatedDate(const QDate& maxCreatedDate);
    void setFilterMinDeliveryDate(const QDate& minDeliveryDate);
    void setFilterMaxDeliveryDate(const QDate& maxDeliveryDate);
    void setFilterAddress(const QString& address);
    void setFilterStatus(const QString& status);
    void setFilterCost(quint64 cost);
    void setFilters(
        quint64 orderId, const QDate& minCreatedDate,
        const QDate& maxCreatedDate, const QDate& minDeliveryDate,
        const QDate& maxDeliveryDate, const QString& address,
        const QString& status, quint64 cost
    );

private:
    AbstractSqlQueryModel* m_sourceModel;    //! Source model for filter.

    quint64 m_orderId = 0;  //!< Order id field for filter
    QDate m_minCreatedDate; //!< Order minimum created date field for filter
    QDate m_maxCreatedDate; //!< Order maximum created date field for filter
    QDate m_minDeliveryDate;    //!< Order minimum delivery date field for filter
    QDate m_maxDeliveryDate;    //!< Order minimum delivery date field for filter
    QString m_address = "";   //!< Order street address field for filter
    QString m_status = "";   //!< Order status field for filter
    quint64 m_cost = 0; //!< Order cost field for filter
};

#endif // ORDERSFILTERMODEL_H
