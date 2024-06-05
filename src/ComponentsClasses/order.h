/*! \file order.h
 *  \brief Header file for order component.
 *
 *  Declaration of all properties of order component.
 *
*/

#ifndef ORDER_H
#define ORDER_H

#include <QObject>
#include <QDate>
#include <QString>
#include <QSqlRecord>

/*!
 * \brief Class defining order component.
 *
 *  Class for represantation of a order connects qml frontend with backend.
 *  Contains all order properties.
 *  Properties working through Q_PROPERTY macros.
 *
 */
class Order : public QObject
{
    Q_OBJECT
    Q_PROPERTY(quint64 orderId READ orderId WRITE setOrderId NOTIFY orderIdChanged) //!< order's id property to identify each order
    Q_PROPERTY(QDate createdDate READ createdDate WRITE setCreatedDate NOTIFY createdDateChanged) //!< Date that order was created
    Q_PROPERTY(QDate askedDeliveryDate READ askedDeliveryDate WRITE setAskedDeliveryDate NOTIFY askedDeliveryDateChanged) //!< Asked delivery date
    Q_PROPERTY(quint64 statusId READ statusId WRITE setStatusId NOTIFY statusIdChanged) //!< Order status id
    Q_PROPERTY(QString statusTitle READ statusTitle WRITE setStatusTitle NOTIFY statusTitleChanged) //!< Order status title
    Q_PROPERTY(quint64 cost READ cost WRITE setCost NOTIFY costChanged) //!< Cost of an order
    Q_PROPERTY(QString address READ address WRITE setAddress NOTIFY addressChanged) //!< Address of the order
    Q_PROPERTY(quint64 volume READ volume WRITE setVolume NOTIFY volumeChanged) //!< Volume of the order
    Q_PROPERTY(quint64 weight READ weight WRITE setWeight NOTIFY weightChanged) //!< Weight of the order

private:
    quint64 m_orderId = 0; //!< Order id
    QDate m_createdDate; //!< Date that order was created
    QDate m_askedDeliveryDate; //!< Asked delivery date
    quint64 m_statusId = 0; //!< Order status id
    QString m_statusTitle = ""; //!< Order status title
    quint64 m_cost = 0; //!< Cost of an order
    QString m_address = ""; //!< Address of the order
    quint64 m_volume = 0; //!< Volume of the order
    quint64 m_weight = 0; //!< Weight of the order

public:
    explicit Order(QObject *parent = nullptr);
    Order(const Order&) = default;

public Q_SLOTS:
    void setData(
        quint64 orderId, const QDate& createdDate,
        const QDate& askedDeliveryDate, quint64 statusId,
        const QString& statusTitle, quint64 cost,
        const QString& address, quint64 volume, quint64 weight
    );
    void setRecord(const QSqlRecord& record);

//
// Getters
//
public:
    quint64 orderId() const;
    QDate createdDate() const;
    QDate askedDeliveryDate() const;
    quint64 statusId() const;
    QString statusTitle() const;
    quint64 cost() const;
    QString address() const;
    quint64 volume() const;
    quint64 weight() const;

//
// Setters
//
public:
    void setOrderId(quint64 orderId);
    void setCreatedDate(const QDate &createdDate);
    void setAskedDeliveryDate(const QDate &askedDeliveryDate);
    void setStatusId(quint64 statusId);
    void setStatusTitle(const QString &statusTitle);
    void setCost(quint64 cost);
    void setAddress(const QString &address);
    void setVolume(quint64 volume);
    void setWeight(quint64 weight);

//
// Property's signals
//
signals:
    void orderIdChanged();
    void createdDateChanged();
    void askedDeliveryDateChanged();
    void statusIdChanged();
    void statusTitleChanged();
    void costChanged();
    void addressChanged();
    void volumeChanged();
    void weightChanged();
};

#endif // ORDER_H
