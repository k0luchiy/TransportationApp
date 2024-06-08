#include "order.h"

Order::Order(QObject *parent)
    : QObject{parent}
{

}

Order::Order(const Order& other)
{
    m_orderId = other.orderId();
    m_createdDate = other.createdDate();
    m_askedDeliveryDate = other.askedDeliveryDate();
    m_statusId = other.statusId();
    m_statusTitle = other.statusTitle();
    m_cost = other.cost();
    m_address = other.address();
    m_volume = other.volume();
    m_weight = other.weight();
}


void Order::operator=(const Order& other)
{
    m_orderId = other.orderId();
    m_createdDate = other.createdDate();
    m_askedDeliveryDate = other.askedDeliveryDate();
    m_statusId = other.statusId();
    m_statusTitle = other.statusTitle();
    m_cost = other.cost();
    m_address = other.address();
    m_volume = other.volume();
    m_weight = other.weight();
}

// Getters
quint64 Order::orderId() const { return m_orderId; }
QDate Order::createdDate() const { return m_createdDate; }
QDate Order::askedDeliveryDate() const { return m_askedDeliveryDate; }
quint64 Order::statusId() const { return m_statusId; }
QString Order::statusTitle() const { return m_statusTitle; }
quint64 Order::cost() const { return m_cost; }
QString Order::address() const { return m_address; }
quint64 Order::volume() const { return m_volume; }
quint64 Order::weight() const { return m_weight; }

// Setters
void Order::setOrderId(quint64 orderId) { m_orderId = orderId; emit orderIdChanged(); }
void Order::setCreatedDate(const QDate &createdDate) { m_createdDate = createdDate; emit createdDateChanged(); }
void Order::setAskedDeliveryDate(const QDate &askedDeliveryDate) { m_askedDeliveryDate = askedDeliveryDate; emit askedDeliveryDateChanged(); }
void Order::setStatusId(quint64 statusId) { m_statusId = statusId; emit statusIdChanged(); }
void Order::setStatusTitle(const QString &statusTitle) { m_statusTitle = statusTitle; emit statusTitleChanged(); }
void Order::setCost(quint64 cost) { m_cost = cost; emit costChanged(); }
void Order::setAddress(const QString &address) { m_address = address; emit addressChanged(); }
void Order::setVolume(quint64 volume) { m_volume = volume; emit volumeChanged(); }
void Order::setWeight(quint64 weight) { m_weight = weight; emit weightChanged(); }

void Order::setData(
    quint64 orderId, const QDate& createdDate,
    const QDate& askedDeliveryDate, quint64 statusId,
    const QString& statusTitle, quint64 cost,
    const QString& address, quint64 volume, quint64 weight
)
{
    setOrderId(orderId);
    setCreatedDate(createdDate);
    setAskedDeliveryDate(askedDeliveryDate);
    setStatusId(statusId);
    setStatusTitle(statusTitle);
    setCost(cost);
    setAddress(address);
    setVolume(volume);
    setWeight(weight);
}

void Order::setRecord(const QSqlRecord& record){
    quint64 orderId = record.value("OrderId").toInt();
    QDate createdDate = record.value("CreatedDate").toDate();//.toString("dd.MM.yyyy");
    QDate askedDeliveryDate = record.value("AskedDeliveryDate").toDate();//.toString("dd.MM.yyyy");
    quint64 statusId = record.value("StatusId").toInt();
    QString statusTitle = record.value("StatusTitle").toString();
    quint64 cost = record.value("Cost").toFloat();
    QString address = record.value("Address").toString();
    quint64 volume = record.value("Volume").toInt();
    quint64 weight = record.value("Weight").toInt();

    setData(
        orderId, createdDate, askedDeliveryDate,
        statusId, statusTitle, cost,
        address, volume, weight
    );
}
