/*! \file drivingcategoriesmodel.cpp
 *  \brief DrivingCategoriesModel class source file.
 *
 *  This file contains DrivingCategoriesModel class implementation.
 *
 */

#include "drivingcategoriesmodel.h"

//! Query whitch AbstractSqlQueryModel will execute for selecting all user information.
const char* DrivingCategoriesModel::SELECT_QUERY =
    "Select 0 as StatusId, '' as StatusTitle union " \
    "select CategoryName, FullName, CategoryPriority \
    from DrivingCategories \
    order by CategoryPriority";

DrivingCategoriesModel::DrivingCategoriesModel(QObject *parent)
    : AbstractSqlQueryModel{SELECT_QUERY, parent}
{

}
