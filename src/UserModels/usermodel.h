/*! \file usermodel.h
 * \brief Header file for user model
 *
 * Declaration of user model.
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


/*!
 * \brief The UserModel class
 *
 * UserModel class store's user records
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

private:
    void generateRoleNames();

private:
    const static char* SELECT_QUERY;
    QHash<int, QByteArray> m_roleNames;
};

#endif // USERMODEL_H
