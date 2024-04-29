/*! \file rolesmodel.h
 *  \brief Declaration of RolesModel.
 *  Containt declarartion of RolesModell class that represents users roles and priorities.
 *
 */

#ifndef ROLESMODEL_H
#define ROLESMODEL_H

#include <QSqlRecord>
#include "abstractsqlquerymodel.h"

/*!
 * \brief The RolesModel class represents users roles.
 *
 *  Stores roles data  and allows basic roles manupulation.
 *
 */
class RolesModel : public AbstractSqlQueryModel
{
public:
    explicit RolesModel(QObject *parent = nullptr);


public Q_SLOTS:
    quint32 get_minPriority() const;
    quint32 get_maxPriority() const;
    quint32 get_minPriority_roleId() const;
    quint32 get_maxPriority_roleId() const;

private:
    const static char* SELECT_QUERY;
};

#endif // ROLESMODEL_H
