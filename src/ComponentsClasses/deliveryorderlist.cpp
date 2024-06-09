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
        //quint64 orderId = record.value("OrderId").toInt();
        //qDebug() << order.orderId() << order.createdDate();
        m_orderList.append(order);
        //m_orderList.append(orderId);
    }
    qDebug() << m_orderList.size();
    setDeliveryId(deliveryId);
    //setOrderList(ordersList);
    orderListChanged();
}


void DeliveryOrderList::appendOrderId(quint64 orderId)
{
    //m_orderList.append(orderId);
    orderListChanged();
}

void DeliveryOrderList::removeByIndex(quint64 index)
{
    //m_orderList.remove(index);
}

void DeliveryOrderList::insertOrderId(quint64 index, quint64 orderId)
{
    //m_orderList.insert(index, orderId);
    orderListChanged();
}

void DeliveryOrderList::saveOrderList()
{

}
