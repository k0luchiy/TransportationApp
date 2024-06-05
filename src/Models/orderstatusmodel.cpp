/*! \file orderstatusmodel.cpp
 *  \brief OrderStatusModel class source file.
 *
 *  This file contains OrderStatusModel class implementation.
 *
 */

#include "orderstatusmodel.h"

//! Query whitch AbstractSqlQueryModel will execute for selecting all user information.
const char* OrderStatusModel::SELECT_QUERY =
    "Select 0 as StatusId, '' as StatusTitle union " \
    "Select StatusId, StatusTitle from OrderStatus order by StatusId";

OrderStatusModel::OrderStatusModel(QObject *parent)
    : AbstractSqlQueryModel{SELECT_QUERY, parent}
{

}
