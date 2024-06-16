/*! \file user.cpp
 *  \brief User class source file.
 *
 *  This file contains User class implementation.
 *
 */

#include "user.h"
#include <QDebug>

User::User(QObject *parent)
    : QObject{parent}
{

}


User::User(const User& other)
{
    quint64 userId = other.userId();
    QString email = other.email();
    QString firstName = other.firstName();
    QString lastName = other.lastName();
    quint64 roleId = other.roleId();
    QString roleTitle = other.roleTitle();
    quint64 rolePriority = other.rolePriority();
    bool isAuthenticated = other.isAuthenticated();

    setUserData(userId, email, firstName, lastName, roleId, roleTitle, rolePriority, isAuthenticated);
}


//
// Getters
//
quint64 User::userId() const { return m_userId; } //!< Getter for userId field
QString User::firstName() const { return m_firstName; } //!< Getter for firstName field
QString User::lastName() const { return m_lastName; } //!< Getter for lastName field
QString User::email() const { return m_email; } //!< Getter for email field
quint64 User::roleId() const { return m_roleId; } //!< Getter for roleId field
QString User::roleTitle() const { return m_roleTitle; } //!< Getter for roleTitle field
quint64 User::rolePriority() const { return m_rolePriority; } //!< Getter for rolePriority field
bool User::isAuthenticated() const { return m_isAuthenticated; } //!< Getter for roleTitle field

//
// Setters
//
void User::setUserId(quint64 userId)  { m_userId = userId; emit userIdChanged(); } //!< Setter for userId field, emmiting userIdChanged signal
void User::setFirstName(const QString& firstName) { m_firstName = firstName; emit firstNameChanged(); } //!< Setter for firstName field, emmiting firstNameChanged signal
void User::setLastName(const QString& lastName) { m_lastName = lastName; emit lastNameChanged(); } //!< Setter for lastName field, emmiting lastNameChanged signal
void User::setEmail(const QString& email) { m_email = email; emit emailChanged(); } //!< Setter for email field, emmiting emailChanged signal
void User::setRoleId(quint64 roleId) { m_roleId = roleId; emit roleIdChanged(); } //!< Setter for roleId field, emmiting roleIdChanged signal
void User::setRoleTitle(const QString& roleTitle) { m_roleTitle = roleTitle; emit roleTitleChanged(); } //!< Setter for roleTitle field, emmiting roleTitleChanged signal
void User::setRolePriority(quint64 rolePriority) { m_rolePriority = rolePriority; emit rolePriorityChanged(); } //!< Setter for roleId field, emmiting roleIdChanged signal
void User::setIsAuthenticated(bool isAuthenticated) { m_isAuthenticated = isAuthenticated; emit isAuthenticatedChanged(); } //!< Setter for isAuthenticated field, emmiting isAuthenticatedChanged signal


/*! \brief Setter for all user data, calls all user's fields setters
 *  @param userId user id to set
 *  @param email user's email to set
 *  @param firstName user's first name to set
 *  @param lastName user's last name to set
 *  @param roleId user's role id to set
 *  @param roleTitle user's role title to set
 *  @param rolePriority role's priority to set, identifies users rights
 *  @param isAuthenticated sets if current user authenticated or nor.
 */
void User::setUserData(quint64 userId, const QString& email,
                 const QString& firstName, const QString& lastName,
                 quint64 roleId, const QString& roleTitle,
                 quint64 rolePriority, bool isAuthenticated)
{
    setUserId(userId);
    setEmail(email);
    setFirstName(firstName);
    setLastName(lastName);
    setRoleId(roleId);
    setRoleTitle(roleTitle);
    setRolePriority(rolePriority);
    setIsAuthenticated(isAuthenticated);
}

/*!
 * \brief Sets user data from record
 * \param record Record that contains user data
 */
void User::setRecord(const QSqlRecord& record)
{
    quint64 userId = record.value("UserId").toInt();
    QString email = record.value("Email").toString();
    QString firstName = record.value("FirstName").toString();
    QString lastName = record.value("LastName").toString();
    quint64 roleId = record.value("RoleId").toInt();
    QString roleTitle = record.value("RoleTitle").toString();
    quint64 rolePriority = record.value("RolePriority").toInt();
    bool isAuthenticated = true;

    setUserData(
        userId , email, firstName,
        lastName, roleId, roleTitle,
        rolePriority, isAuthenticated
    );
}

void User::setUser(quint64 userId)
{
    const QString select_query =
        " SELECT u.UserId, u.Email, u.FirstName, u.LastName, u.RoleId, ur.RoleTitle, ur.RolePriority  "
        " from Users u  "
        " join UserRoles ur on u.roleId = ur.roleId "
        " where u.userId = :userId ";

    QSqlQuery query;
    query.prepare(select_query);
    query.bindValue(":userId", userId);
    bool execSuccess = query.exec();
    if(execSuccess && query.next()){
        QSqlRecord record = query.record();
        setRecord(record);
    }
}

/*!
 * \brief Checks if user with given email already registered.
 * \param email Email (login) of a user to find.
 * \return True if user already registered, False otherwise.
 */
bool User::isUserExist(const QString &email) const
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
bool User::authenticate(const QString& email, const QString& password)
{
    const QString auth_query =
        " SELECT u.UserId, u.Email, u.FirstName, u.LastName, u.RoleId, ur.RoleTitle, ur.RolePriority  "
        " from Users u  "
        " join UserRoles ur on u.roleId = ur.roleId "
        " where u.email = :email and u.pwd = md5(:password); ";

    QSqlQuery query;
    query.prepare(auth_query);
    query.bindValue(":email", email);
    query.bindValue(":password", password);
    bool execSuccess = query.exec();
    bool authSuccess = query.next();

    if(authSuccess){
        setRecord(query.record());
    }

    return execSuccess && authSuccess;
}

/*!
 * \brief Register user to database with basic role.
 * \param email Users email to witch account will be linked.
 * \param password  Users password for authentication in the future.
 * \param firstName Users first name.
 * \param lastName  Users last name.
 * \return Is registration was a success or not.
 */
bool User::registration(const QString& email, const QString& password,
                             const QString& firstName, const QString& lastName)
{
    if(isUserExist(email)){
        return 0;
    }

    //RolesModel roles;
    //quint32 roleId = roles.get_minPriority_roleId();
    quint32 roleId = 2;
    QSqlQuery query;
    const QString reg_query =
        " Insert into Users(email, pwd, firstName, lastName, roleId) "
        " values(:email, md5(:password), :firstName, :lastName, :roleId); ";
    query.prepare(reg_query);
    query.bindValue(":email", email);
    query.bindValue(":password", password);
    query.bindValue(":firstName", firstName);
    query.bindValue(":lastName", lastName);
    query.bindValue(":roleId", roleId);

    return query.exec();
}

/*!
 * \brief Checks whether given password is current
 * \param userId User id of a user to check
 * \param password Password to check
 * \return true if password is matches and query executed successfuly, false otherwise
 */
bool User::checkPassword(quint64 userId, const QString& password)
{
    QSqlQuery query;
    const QString select_query =
        "Select userId from Users \
        where userId = :userId and pwd = md5(:password)";
    query.prepare(select_query);
    query.bindValue(":userId", userId);
    query.bindValue(":password", password);
    bool execSuccess = query.exec();
    return execSuccess && query.next();
}

/*!
 * \brief Updates user info by user id
 * \param userId User id of a user to update
 * \param lastName New last name to set
 * \param firstName New first name to set
 * \param email New email to set
 * \return true if query executed successfuly, false otherwise
 */
bool User::updateUserInfo(
    quint64 userId, const QString& lastName,
    const QString& firstName, const QString& email)
{
    QSqlQuery query;
    const QString update_query =
        "Update users set lastName = :lastName, firstName = :firstName, \
        email = :email \
        where userId = :userId";
    query.prepare(update_query);
    query.bindValue(":lastName", lastName);
    query.bindValue(":firstName", firstName);
    query.bindValue(":email", email);
    query.bindValue(":userId", userId);
    bool execSuccess = query.exec();
    if(execSuccess){
        qDebug() << "Updated";
        setLastName(lastName);
        setFirstName(firstName);
        setEmail(email);
    }

    return execSuccess;
}


/*!
 * \brief User::updateUserPassword
 * \param userId User id of a user to update
 * \param oldPassword Current password of a user
 * \param newPassword New password to set
 * \return true if query executed successfuly, false otherwise
 */
bool User::updateUserPassword(
    quint64 userId, const QString& oldPassword, const QString& newPassword)
{
    QSqlQuery query;
    const QString update_query =
        "Update users set pwd = md5(:newPassword) \
        where userId = :userId and pwd = md5(:oldPassword)";
    query.prepare(update_query);
    query.bindValue(":newPassword", newPassword);
    query.bindValue(":oldPassword", oldPassword);
    query.bindValue(":userId", userId);

    return query.exec();
}

/*!
 * \brief Updates user data by userId
 * \param userId User id of a user to update
 * \param lastName New last name to set
 * \param firstName New first name to set
 * \param email New email to set
 * \param oldPassword Current password of a user
 * \param newPassword New password to set
 * \return true if query executed successfuly, false otherwise
 */
bool User::updateUserData(
    quint64 userId, const QString& lastName,
    const QString& firstName, const QString& email,
    const QString& oldPassword, const QString& newPassword
)
{
    bool infoSuccess = updateUserInfo(userId, lastName, firstName, email);
    bool passwordSuccess = updateUserPassword(userId, oldPassword, newPassword);

    return infoSuccess && passwordSuccess;
}
