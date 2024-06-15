#ifndef DELIVERIESFILTERMODEL_H
#define DELIVERIESFILTERMODEL_H

#include <QSortFilterProxyModel>
#include "abstractsqlquerymodel.h"
#include <QDate>

class DeliveriesFilterModel : public QSortFilterProxyModel
{
    Q_OBJECT
public:
    explicit DeliveriesFilterModel(QObject *parent = nullptr);
    void setSourceModel(AbstractSqlQueryModel* sourceModel);

protected:
    bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const;
    bool isDateInRange(
        const QDate& date,
        const QDate& startDate,
        const QDate& endDate
        ) const;

public Q_SLOTS: // Getters
    void changeSort(quint64 index);
    quint64 filterDeliveryId() const;
    QString filterCarNumber() const;
    QString filterDriverName() const;
    QDate filterMinDepartureDate() const;
    QDate filterMaxDepartureDate() const;
    QDate filterMinReturnDate() const;
    QDate filterMaxReturnDate() const;
    QString filterStatus() const;
    QString filterToLocation() const;

public Q_SLOTS: //Setters
    void setFilterDriverId(quint64 deliveryId);
    void setFilterCarNumber(const QString& carNumber);
    void setFilterDriverName(const QString& driverName);
    void setFilterMinDepartureDate(const QDate& minDepartureDate);
    void setFilterMaxDepartureDate(const QDate& maxDepartureDate);
    void setFilterMinReturnDate(const QDate& minReturnDate);
    void setFilterMaxReturnDate(const QDate& maxReturnDate);
    void setFilterStatus(const QString& status);
    void setFilterToLocation(const QString& toLocation);

    void setFilters(
        quint64 deliveryId, const QString& carNumber,
        const QString& driverName, const QDate& minDepartureDate,
        const QDate& maxDepartureDate, const QDate& minReturnDate,
        const QDate& maxReturnDate, const QString& status//, const QString& toLocation
    );

private:
    AbstractSqlQueryModel* m_sourceModel;   //! Source model for filter.

    quint64 m_deliveryId = 0;   //!< Delivery id field for filter
    QString m_carNumber = "";   //!< Delivery car number field for filter
    QString m_driverName = "";   //!< Delivery drivers name field for filter
    QDate m_minDepartureDate;   //!< Delivery lower bound for departure date field for filter
    QDate m_maxDepartureDate;   //!< Delivery upper bound for departure date field for filter
    QDate m_minReturnDate;   //!< Delivery lower bound for return date field for filter
    QDate m_maxReturnDate;   //!< Delivery upper bound for return date field for filter
    QString m_status = "";    //!< Delivery status field for filter
    QString m_toLocation = "";   //!< Delivery last address field for filter
};

#endif // DELIVERIESFILTERMODEL_H
