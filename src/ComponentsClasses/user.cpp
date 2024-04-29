/*! \file user.cpp
 *  \brief User class source file.
 *
 *  This file contains User class implementation.
 *
 */

#include "user.h"

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
