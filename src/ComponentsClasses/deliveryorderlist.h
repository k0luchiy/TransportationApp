#ifndef DELIVERYORDERLIST_H
#define DELIVERYORDERLIST_H

#include <QObject>
#include <QList>
#include <QSqlQuery>
#include <QSqlRecord>
#include "order.h"

class DeliveryOrderList : public QObject
{
    Q_OBJECT
    Q_PROPERTY(quint64 deliveryId READ deliveryId WRITE setDeliveryId NOTIFY deliveryIdChanged) //!< delivery's id
    //Q_PROPERTY(QList<quint64> orderList READ orderList WRITE setOrderList NOTIFY orderListChanged) //!< delivery's id
    Q_PROPERTY(QList<Order*> orderList READ orderList WRITE setOrderList NOTIFY orderListChanged) //!< delivery's id

private:
    quint64 m_deliveryId = 0;
    //QList<quint64> m_orderList;
    QList<Order*> m_orderList;

public:
    explicit DeliveryOrderList(QObject *parent = nullptr);
    DeliveryOrderList(const DeliveryOrderList&) = default;

public Q_SLOTS:
    void setData(quint64 deliveryId, const QList<Order*>& orderList);
    void setDelivery(quint64 deliveryId);
    void appendOrderId(quint64 orderId);
    void removeByIndex(quint64 orderId);
    void insertOrderId(quint64 index, quint64 orderId);
    void saveOrderList();

//
// Getters
//
public:
    quint64 deliveryId() const;
    //QList<quint64> orderList() const;
    QList<Order*> orderList() const;

//
// Setters
//
public:
    void setDeliveryId(quint64 deliveryId);
    //void setOrderList(const QList<quint64>& orderList);
    void setOrderList(const QList<Order*>& orderList);

//
// Property's signals
//
signals:
    void deliveryIdChanged();
    void orderListChanged();

};

#endif // DELIVERYORDERLIST_H
