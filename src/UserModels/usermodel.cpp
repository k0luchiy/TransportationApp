/*! \file usermodel.cpp
 *  \brief UserModel class source file.
 *
 *  This file contains UserModel class implementation.
 *
 */

#include "usermodel.h"

//! Query to database for selecting all user information.
const char* UserModel::SELECT_QUERY =
    " SELECT u.UserId, u.Email, u.FirstName, u.LastName, u.RoleId, ur.RoleTitle, ur.RolePriority  "
    " from Users u  "
    " join UserRoles ur on u.roleId = ur.roleId ";

UserModel::UserModel(QObject *parent)
    : QSqlQueryModel{parent}
{
    setQuery(SELECT_QUERY);
}

//! Getter for role names
QHash<int, QByteArray> UserModel::roleNames() const
{
    return m_roleNames;
}

//! Generates role names from record columns
void UserModel::generateRoleNames()
{
    m_roleNames.clear();
    QSqlRecord empty_record = record(); // gets empty record with fields information
    for(size_t i=0; i < empty_record.count(); ++i){
        m_roleNames.insert(Qt::UserRole + i +1, empty_record.fieldName(i).toUtf8());
    }
}

//! Sets given query to model
void UserModel::setQuery(const QString& query, const QSqlDatabase& db)
{
    QSqlQueryModel::setQuery(query, db);
    generateRoleNames();
}

//! Sets given query to model
void UserModel::setQuery(QString&& query)
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

/*!
 * \brief Updates data in the model by running setted query.
 */
void UserModel::updateModel()
{
    setQuery(SELECT_QUERY);
}


/*!
 * \brief Checks if user with given email already registered.
 * \param email Email (login) of a user to find.
 * \return True if user already registered, False otherwise.
 */
bool UserModel::isUserExist(const QString &email) const
{
    const QString find_query =
        " select UserId form Users u "
        " where u.email = :email; ";
    QSqlQuery query;
    query.prepare(find_query);
    query.bindValue(":email", email);
    bool isSuccess = query.exec();

    return isSuccess && query.next();
}


/*!
 * \brief Authenticate user by email (login) and password.
 * \param email Users email (login) to witch the account is linked.
 * \param password Users password.
 * \return Is authntication was a success or not.
 */
bool UserModel::authenticate(const QString& email, const QString& password) const
{
    const QString auth_query =
        " select UserId form Users u "
        " where u.email = :email and u.password = mda5(:password); ";
    QSqlQuery query;
    query.prepare(auth_query);
    query.bindValue(":email", email);
    query.bindValue(":password", password);
    bool isSuccess = query.exec();

    return isSuccess && query.next();
}

/*!
 * \brief Register user to database with basic role.
 * \param email Users email to witch account will be linked.
 * \param password  Users password for authentication in the future.
 * \param firstName Users first name.
 * \param lastName  Users last name.
 * \return Is registration was a success or not.
 */
bool UserModel::registration(const QString& email, const QString& password,
                  const QString& firstName, const QString& lastName)
{
    if(isUserExist(email)){
        return 0;
    }

    RolesModel roles;
    quint32 roleId = roles.get_minPriority_roleId();
    QSqlQuery query;
    const QString reg_query =
        " Insert into Users(email, password, firstName, lastName, roleId) "
        " values(:email, :password, :firstName, :lastName, :roleId); ";
    query.prepare(reg_query);
    query.bindValue(":email", email);
    query.bindValue(":password", password);
    query.bindValue(":firstName", firstName);
    query.bindValue(":lastName", lastName);
    query.bindValue(":roleId", roleId);

    return query.exec();
}


