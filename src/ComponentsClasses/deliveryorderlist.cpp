#include "deliveryorderlist.h"
#include <QDebug>

DeliveryOrderList::DeliveryOrderList(QObject *parent)
    : QObject{parent}
{

}

quint64 DeliveryOrderList::deliveryId() const { return m_deliveryId; }
QList<Order*> DeliveryOrderList::orderList() const { return m_orderList; }


void DeliveryOrderList::setDeliveryId(quint64 deliveryId)
{
    m_deliveryId = deliveryId;
    deliveryIdChanged();
}

void DeliveryOrderList::setOrderList(const QList<Order*>& orderList)
{
    m_orderList = orderList;
    orderListChanged();
}

void DeliveryOrderList::setData(quint64 deliveryId, const QList<Order*>& orderList)
{
    setDeliveryId(deliveryId);
    setOrderList(orderList);
}

void DeliveryOrderList::setDelivery(quint64 deliveryId)
{
    QString query_str =
//        "Select DeliveryId, OrderId, SequenceNum \
//        From DeliveryOrders \
//        Where DeliveryId=:deliveryId";
        "select \
            o.OrderId, o.CreatedDate, o.AskedDeliveryDate,  \
            s.StatusId, s.StatusTitle, o.Cost,  \
            o.Address, o.Volume, o.Weight   \
        From DeliveryOrders do \
        join Orders o on do.OrderId = o.OrderId \
        join OrderStatus s on o.StatusId = s.StatusId \
        Where DeliveryId=:deliveryId \
        order by do.SequenceNum ";

    QSqlQuery query;
    query.prepare(query_str);
    query.bindValue(":deliveryId", deliveryId);
    query.exec();

    m_orderList.clear();
    //QList<Order> ordersList;
    while (query.next())
    {
        QSqlRecord record = query.record();
        Order* order = new Order();
        order->setRecord(record);
        m_orderList.append(order);
    }
    setDeliveryId(deliveryId);
    orderListChanged();
}


void DeliveryOrderList::appendOrder(const QSqlRecord& record)
{
    Order* order = new Order();
    order->setRecord(record);
    m_orderList.append(order);
    orderListChanged();
}

void DeliveryOrderList::removeByIndex(quint64 index)
{
    m_orderList.remove(index);
    orderListChanged();
}

void DeliveryOrderList::insertOrderId(quint64 index, quint64 orderId)
{
    //m_orderList.insert(index, orderId);
    orderListChanged();
}

void DeliveryOrderList::saveOrderList()
{

}
