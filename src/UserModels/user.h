/*! \file user.h
 *  \brief Header file for user component.
 *
 *  Declaration of all properties of user component.
 *
*/

#ifndef USER_H
#define USER_H

#include <QObject>
#include <QSqlRecord>

/*!
 * \brief Class defining user component.
 *
 *  Class for represantation of a user connects qml frontend with backend.
 *  Contains all properties of a user.
 *  Properties working through Q_PROPERTY macros.
 *
 */
class User : public QObject
{
    Q_OBJECT
    Q_PROPERTY(quint64 userId READ userId WRITE setUserId NOTIFY userIdChanged) //!< User's id property to identify each user
    Q_PROPERTY(QString email READ email WRITE setEmail NOTIFY emailChanged) //!< Email of a user
    Q_PROPERTY(QString firstName READ firstName WRITE setFirstName NOTIFY firstNameChanged) //!< User's first name
    Q_PROPERTY(QString lastName READ lastName WRITE setLastName NOTIFY lastNameChanged) //!< User's last name
    Q_PROPERTY(quint64 roleId READ roleId WRITE setRoleId NOTIFY roleIdChanged) //!< Role id of a user to identify role
    Q_PROPERTY(QString roleTitle READ roleTitle WRITE setRoleTitle NOTIFY roleTitleChanged) //!< Role title
    Q_PROPERTY(quint64 rolePriority READ rolePriority WRITE setRolePriority NOTIFY rolePriorityChanged) //!< Role id of a user to identify role
    Q_PROPERTY(bool isAuthenticated READ isAuthenticated WRITE setIsAuthenticated NOTIFY isAuthenticatedChanged) //!< Role title

private:
    quint64 m_userId = 0;       //!< User id
    QString m_email= "";        //!< User email
    QString m_firstName = "";   //!< User first name
    QString m_lastName = "";    //!< User last name
    quint64 m_roleId = 0;       //!< Role id of a user to identify role
    QString m_roleTitle = "";   //!< Role title
    quint64 m_rolePriority = 0;   //!< Role priority to set users rights
    bool m_isAuthenticated = false; //!< Is current user authenticated or not

public:
    explicit User(QObject *parent = nullptr);
    User(const User& other);
    User(User&& other) = default;

public Q_SLOTS:
    void setUserData(quint64 userId, const QString& email,
                     const QString& firstName, const QString& lastName,
                     quint64 roleId, const QString& roleTitle,
                     quint64 rolePriority, bool isAuthenticated);
//
// Getters
//
public:
    quint64 userId() const;
    QString email() const;
    QString firstName() const;
    QString lastName() const;
    quint64 roleId() const;
    QString roleTitle() const;
    quint64 rolePriority() const;
    bool isAuthenticated() const;

//
// Setters
//
public:
    void setUserId(quint64 userId);
    void setEmail(const QString& email);
    void setFirstName(const QString& firstName);
    void setLastName(const QString& lastName);
    void setRoleId(quint64 roleId);
    void setRoleTitle(const QString& roleeTitle);
    void setRolePriority(quint64 rolePriority);
    void setIsAuthenticated(bool isAuthenticated);


//
// Property's signals
//
signals:
    void userIdChanged();       //!< Emits signal if userId changed
    void emailChanged();        //!< Emits signal if email changed
    void firstNameChanged();    //!< Emits signal if firstName changed
    void lastNameChanged();     //!< Emits signal if lastName changed
    void roleIdChanged();       //!< Emits signal if roleId changed
    void roleTitleChanged();    //!< Emits signal if roleTitle changed
    void rolePriorityChanged();       //!< Emits signal if rolePriority changed
    bool isAuthenticatedChanged();  //!< Emits signal if isAuthenticated changed


};

#endif // USER_H
