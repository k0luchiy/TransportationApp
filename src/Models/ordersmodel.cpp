/*! \file ordersmodel.cpp
 *  \brief OrdersModel class source file.
 *
 *  This file contains OrdersModel class implementation.
 *
 */

#include "ordersmodel.h"


//! Query whitch AbstractSqlQueryModel will execute for selecting all user information.
const char* OrdersModel::SELECT_QUERY =
    "select \
        o.OrderId, o.CreatedDate, o.AskedDeliveryDate,  \
        s.StatusId, s.StatusTitle, o.Cost,  \
        o.Address, o.Volume, o.Weight   \
    from Orders o   \
    join OrderStatus s on o.StatusId = s.StatusId ";


OrdersModel::OrdersModel(QObject *parent)
    : AbstractSqlQueryModel{SELECT_QUERY, parent}
{

}

/*!
 * \brief Updates orders's data by car id
 * \param orderId Id of an order to update
 * \param askedDeliveryDate New asked delivery date to set
 * \param statusId New status to set
 * \param address New address to set
 * \param volume New volume to set
 * \param weight New weight to set
 * \param cost New cost of an order to set
 * \return True if query executed successfully, False otherwise
 */
bool OrdersModel::updateOrder(
    quint64 orderId, const QDate& askedDeliveryDate,
    quint64 statusId, const QString& address,
    quint64 volume, quint64 weight, float cost
)
{
    QSqlQuery query;
    const QString reg_query =
        "Update Orders set \
            askedDeliveryDate = :askedDeliveryDate, statusId = :statusId,   \
            cost = :cost, address = :address, volume = :volume, weight = :weight    \
        where orderId = :orderId";

    query.prepare(reg_query);
    query.bindValue(":orderId", orderId);
    query.bindValue(":askedDeliveryDate", askedDeliveryDate);
    query.bindValue(":statusId", statusId);
    query.bindValue(":address", address);
    query.bindValue(":volume", volume);
    query.bindValue(":weight", weight);
    query.bindValue(":cost", cost);
    bool res = query.exec();
    updateModel();
    return res;
}
