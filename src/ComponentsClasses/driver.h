#ifndef DRIVER_H
#define DRIVER_H

#include <QObject>
#include <QSqlRecord>
#include <QString>
#include <QVariant>

class Driver : public QObject
{
    Q_OBJECT
    Q_PROPERTY(quint64 driverId READ driverId WRITE setDriverId NOTIFY driverIdChanged) //!< Drivers id property to identify each driver
    Q_PROPERTY(quint64 personId READ personId WRITE setPersonId NOTIFY personIdChanged) //!< Drivers person id for table PersonInfo
    Q_PROPERTY(QString lastName READ lastName WRITE setLastName NOTIFY lastNameChanged) //!< Drivers last name
    Q_PROPERTY(QString firstName READ firstName WRITE setFirstName NOTIFY firstNameChanged) //!< Drivers first name
    Q_PROPERTY(QString drivingCategory READ drivingCategory WRITE setDrivingCategory NOTIFY drivingCategoryChanged) //!< Drivers driving category
    Q_PROPERTY(quint64 experience READ experience WRITE setExperience NOTIFY experienceChanged) //!< Drivers experience
    Q_PROPERTY(quint64 salary READ salary WRITE setSalary NOTIFY salaryChanged) //!< Drivers experience

private:
    quint64 m_driverId = 0; //!< Driver id
    quint64 m_personId = 0; //!< Person id
    QString m_lastName = ""; //!< Driver last name
    QString m_firstName = ""; //!< Driver first name
    QString m_drivingCategory = ""; //!< Driver driving category
    quint64 m_experience = 0; //!< Driver experience
    quint64 m_salary = 0; //!< Driver salary

public:
    explicit Driver(QObject *parent = nullptr);
    Driver(const Driver&) = default;

public Q_SLOTS:
    void setRecord(const QSqlRecord& record);
    void setData(
        quint64 driverId, quint64 personId, const QString& lastName,
        const QString& firstName, const QString& drivingCategory,
        quint64 experience, quint64 salary
    );

//
// Getters
//
public:
    quint64 driverId() const;
    quint64 personId() const;
    QString lastName() const;
    QString firstName() const;
    QString drivingCategory() const;
    quint64 experience() const;
    quint64 salary() const;

//
// Setters
//
public:
    void setDriverId(quint64 driverId);
    void setPersonId(quint64 personId);
    void setLastName(const QString& lastName);
    void setFirstName(const QString& firstName);
    void setDrivingCategory(const QString& drivingCategory);
    void setExperience(quint64 experience);
    void setSalary(quint64 salary);

//
// Property's signals
//
signals:
    void driverIdChanged();
    void personIdChanged();
    void lastNameChanged();
    void firstNameChanged();
    void drivingCategoryChanged();
    void experienceChanged();
    void salaryChanged();

};

#endif // DRIVER_H
