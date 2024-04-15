#include "usermodel.h"

//! Select query to get user info from database
const char* UserModel::SELECT_QUERY =
    " SELECT u.UserId, u.Email, u.FirstName, u.LastName, u.RoleId, ur.RoleTitle "
    " from Users u  "
    " join UserRoles ur on u.roleId = ur.roleId ";

UserModel::UserModel(QObject *parent)
    : QSqlQueryModel{parent}
{
    setQuery(SELECT_QUERY);
}

//! Role names getter
QHash<int, QByteArray> UserModel::roleNames() const
{
    return m_roleNames;
}

//! Generate role names from record columns
void UserModel::generateRoleNames()
{
    m_roleNames.clear();
    QSqlRecord empty_record = record();
    for(size_t i=0; i < empty_record.count(); ++i){
        m_roleNames.insert(Qt::UserRole + i +1, empty_record.fieldName(i).toUtf8());
    }
}

//! Query setter
void UserModel::setQuery(const QString& query, const QSqlDatabase& db)
{
    QSqlQueryModel::setQuery(query, db);
    generateRoleNames();
}

//! Query setter
void UserModel::setQuery(QString&& query)
{
    QSqlQueryModel::setQuery(std::move(query));
    generateRoleNames();
}

//! Data getter by index and role
QVariant UserModel::data(const QModelIndex& index, int role) const
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


