/*! \file drivingcategoriesmodel.h
 *  \brief Header file for driving categories
 *
 *  Declaration of DrivingCategoryModel class.
 *
*/

#ifndef DRIVINGCATEGORIESMODEL_H
#define DRIVINGCATEGORIESMODEL_H

#include "abstractsqlquerymodel.h"


/*!
 * \brief Stores driving categories.
 *
 * DrivingCategoriesModel class store's categories after executing query.
 * Mainly for comboboxes.
 *
 */
class DrivingCategoriesModel : public AbstractSqlQueryModel
{
    Q_OBJECT
public:
    explicit DrivingCategoriesModel(QObject *parent = nullptr);

private:
    const static char* SELECT_QUERY;
};

#endif // DRIVINGCATEGORIESMODEL_H
