/*! \file rolesmodel.cpp
 *  \brief RolesModel class source file.
 *
 *  This file contains RolesModel class implementation.
 *
 */

#include "rolesmodel.h"

//! Query to database for selecting all user information.
const char* RolesModel::SELECT_QUERY =
    " SELECT ur.RoleId, ur.RoleTitle, ur.RolePriority  "
    " from UserRoles ur  "
    " order by or.RolePriority asc; ";


RolesModel::RolesModel(QObject *parent)
    : QSqlQueryModel{parent}
{
    setQuery(SELECT_QUERY);
}


//! Getter for role names
QHash<int, QByteArray> RolesModel::roleNames() const
{
    return m_roleNames;
}

//! Generates role names from record columns
void RolesModel::generateRoleNames()
{
    m_roleNames.clear();
    QSqlRecord empty_record = record(); // gets empty record with fields information
    for(size_t i=0; i < empty_record.count(); ++i){
        m_roleNames.insert(Qt::UserRole + i +1, empty_record.fieldName(i).toUtf8());
    }
}

//! Sets given query to model
void RolesModel::setQuery(const QString& query, const QSqlDatabase& db)
{
    QSqlQueryModel::setQuery(query, db);
    generateRoleNames();
}

//! Sets given query to model
void RolesModel::setQuery(QString&& query)
{
    QSqlQueryModel::setQuery(std::move(query));
    generateRoleNames();
}

/*! \brief Returns the value for the specified index and role.
 *  If item is out of bounds or if an error occurred, an invalid QVariant is returned.
 *
 *  @param index Index of a record row
 *  @param role Role name to get value from. Simply column index.
 *  @return Returns value of a specified row and column or empty QVariant on error.
 */
QVariant RolesModel::data(const QModelIndex& index, int role) const
{
    QVariant value;
    if(role < Qt::UserRole){
        value = QSqlQueryModel::data(index, role);
        return value;
    }

    int columnInd = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(index.row(), columnInd);
    value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);

    return value;
}

/*!
 * \brief Updates data in the model by running setted query.
 */
void RolesModel::updateModel()
{
    setQuery(SELECT_QUERY);
}

/*!
 * \brief Returns lowest role priority or 0 if records empty
 * \return Returns lowest role priority or 0 if records empty
 */
quint32 RolesModel::get_minPriority() const
{
    try{
        return this->record(0).value("RolePriority").toInt();
    }
    catch(...){
        return 0;
    }
}

/*!
 * \brief Returns greatest role priority or 0 if records empty
 * \return Returns greatest role priority or 0 if records empty
 */
quint32 RolesModel::get_maxPriority() const
{
    try{
        quint32 recordsCount = this->rowCount();
        return this->record(recordsCount-1).value("RolePriority").toInt();
    }
    catch(...){
        return 0;
    }
}

/*!
 * \brief Returns role id of a lowest priority or 0 if records empty
 * \return Returns role id of a lowest priority or 0 if records empty
 */
quint32 RolesModel::get_minPriority_roleId() const
{
    try{
        return this->record(0).value("RoleId").toInt();
    }
    catch(...){
        return 0;
    }
}

/*!
 * \brief Returns role id of a greatest priority or 0 if records empty
 * \return Returns role id of a greatest priority or 0 if records empty
 */
quint32 RolesModel::get_maxPriority_roleId() const
{
    try{
        quint32 recordsCount = this->rowCount();
        return this->record(recordsCount-1).value("RoleId").toInt();
    }
    catch(...){
        return 0;
    }
}
