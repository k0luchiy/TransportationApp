/*! \file usermodel.h
 *  \brief Header file for user model
 *
 *  Declaration of user model class.
 *
*/

#ifndef USERMODEL_H
#define USERMODEL_H

#include <QObject>
#include <QVariant>
#include <QSqlRecord>
#include <QSqlQuery>
#include "rolesmodel.h"
#include "abstractsqlquerymodel.h"

/*!
 * \brief Stores user records.
 *
 * UserModel class store's user records after executing query.
 *
 */
class UserModel : public AbstractSqlQueryModel
{
    Q_OBJECT
public:
    explicit UserModel(QObject* parent = nullptr);

public Q_SLOTS:
    bool isUserExist(const QString& email) const;
    bool authenticate(const QString& email, const QString& password) const;
    bool registration(const QString& email, const QString& password,
                      const QString& firstName, const QString& lastName);

private:
    const static char* SELECT_QUERY;
};

#endif // USERMODEL_H
