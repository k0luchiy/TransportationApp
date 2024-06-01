/*! \file ordersmodel.h
 *  \brief Header file for order model
 *
 *  Declaration of order model class.
 *
*/

#ifndef ORDERSMODEL_H
#define ORDERSMODEL_H

#include "abstractsqlquerymodel.h"
#include <QDate>


/*!
 * \brief Stores orders records.
 *
 * OrdersModel class store's orders records after executing query.
 *
 */
class OrdersModel : public AbstractSqlQueryModel
{
public:
    explicit OrdersModel(QObject *parent = nullptr);

    //int rowCount( const QModelIndex & parent = QModelIndex() ) const;

public Q_SLOTS:
    bool updateOrder(
        quint64 orderId, const QDate& askedDeliveryDate,
        quint64 statusId, float cost, const QString& address,
        quint64 volume, quint64 weight
    );

private:
    const static char* SELECT_QUERY;
};

#endif // ORDERSMODEL_H
