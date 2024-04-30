/*! \file usermodel.cpp
 *  \brief UserModel class source file.
 *
 *  This file contains UserModel class implementation.
 *
 */

#include "usermodel.h"


//! Query whitch AbstractSqlQueryModel will execute for selecting all user information.
const char* UserModel::SELECT_QUERY =
    " SELECT u.UserId, u.Email, u.FirstName, u.LastName, u.RoleId, ur.RoleTitle  "
    " from Users u  "
    " join UserRoles ur on u.roleId = ur.roleId ";

UserModel::UserModel(QObject* parent)
    : AbstractSqlQueryModel{SELECT_QUERY, parent}
{

}


/*!
 * \brief Checks if user with given email already registered.
 * \param email Email (login) of a user to find.
 * \return True if user already registered, False otherwise.
 */
bool UserModel::isUserExist(const QString &email) const
{
    const QString find_query =
        " select UserId from Users u "
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


