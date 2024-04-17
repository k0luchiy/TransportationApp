/*! \file rolesmodel.h
 *  \brief Declaration of RolesModel.
 *  Containt declarartion of RolesModell class that represents users roles and priorities.
 *
 */

#ifndef ROLESMODEL_H
#define ROLESMODEL_H

#include <QSqlQueryModel>
#include <QSqlRecord>

/*!
 * \brief The RolesModel class represents users roles.
 *
 *  Stores roles data  and allows basic roles manupulation.
 *
 */
class RolesModel : public QSqlQueryModel
{
public:
    explicit RolesModel(QObject *parent = nullptr);

    QVariant data(const QModelIndex& ind, int role) const;
    QHash<int, QByteArray> roleNames() const;
    void setQuery(const QString& query, const QSqlDatabase& db = QSqlDatabase());
    void setQuery(QString&& query);

private:
    void generateRoleNames();

public Q_SLOTS:
    quint32 get_minPriority() const;
    quint32 get_maxPriority() const;
    quint32 get_minPriority_roleId() const;
    quint32 get_maxPriority_roleId() const;
    void updateModel();

private:
    const static char* SELECT_QUERY;        //!< Query to database for selecting all roles information.
    QHash<int, QByteArray> m_roleNames;     //!< Stores all role names of a model from columns names.
};

#endif // ROLESMODEL_H
