/*! \file usermodel.h
 *  \brief Header file for user model
 *
 *  Declaration of user model.
 *
*/

#ifndef USERMODEL_H
#define USERMODEL_H

#include <QObject>
#include <QHash>
#include <QVariant>
#include <QSqlRecord>
#include <QSqlQuery>
#include <QSqlQueryModel>
#include "rolesmodel.h"

/*!
 * \brief Stores user records.
 *
 * UserModel class store's user records after executing query.
 *
 */
class UserModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    explicit UserModel(QObject *parent = nullptr);
    QVariant data(const QModelIndex& ind, int role) const;
    QHash<int, QByteArray> roleNames() const;
    void setQuery(const QString& query, const QSqlDatabase& db = QSqlDatabase());
    void setQuery(QString&& query);
    void updateModel();

private:
    void generateRoleNames();

public Q_SLOTS:
    bool isUserExist(const QString& email) const;
    bool authenticate(const QString& email, const QString& password) const;
    bool registration(const QString& email, const QString& password,
                      const QString& firstName, const QString& lastName);

private:
    const static char* SELECT_QUERY;        //!< Query to database for selecting all user information.
    QHash<int, QByteArray> m_roleNames;     //!< Stores all role names of a model from columns names.
};

#endif // USERMODEL_H
