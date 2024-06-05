/*! \file orderstatusmodel.h
 *  \brief Header file for order status.
 *
 *  Declaration of OrderStatusModel class.
 *
*/

#ifndef ORDERSTATUSMODEL_H
#define ORDERSTATUSMODEL_H

#include "abstractsqlquerymodel.h"


/*!
 * \brief Stores status records.
 *
 * OrderStatusModel class store's status records after executing query.
 * Mainly for comboboxes.
 *
 */
class OrderStatusModel : public AbstractSqlQueryModel
{
    Q_OBJECT
public:
    explicit OrderStatusModel(QObject *parent = nullptr);

private:
    const static char* SELECT_QUERY;
};

#endif // ORDERSTATUSMODEL_H
