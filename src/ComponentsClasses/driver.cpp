#include "driver.h"

Driver::Driver(QObject *parent)
    : QObject{parent}
{

}


quint64 Driver::driverId() const { return m_driverId; }
quint64 Driver::personId() const { return m_personId; }
QString Driver::lastName() const { return m_lastName; }
QString Driver::firstName() const { return m_firstName; }
QString Driver::drivingCategory() const { return m_drivingCategory; }
quint64 Driver::experience() const { return m_experience; }
quint64 Driver::salary() const { return m_salary; }


void Driver::setDriverId(quint64 driverId) { m_driverId = driverId; driverIdChanged(); }
void Driver::setPersonId(quint64 personId) { m_personId = personId; personIdChanged(); }
void Driver::setLastName(const QString& lastName) { m_lastName = lastName; lastNameChanged(); }
void Driver::setFirstName(const QString& firstName) { m_firstName = firstName; firstNameChanged(); }
void Driver::setDrivingCategory(const QString& drivingCategory) { m_drivingCategory = drivingCategory; drivingCategoryChanged(); }
void Driver::setExperience(quint64 experience) { m_experience = experience; experienceChanged(); }
void Driver::setSalary(quint64 salary) { m_salary = salary; salaryChanged(); }


void Driver::setData(
    quint64 driverId, quint64 personId, const QString& lastName,
    const QString& firstName, const QString& drivingCategory,
    quint64 experience, quint64 salary
)
{
    setDriverId(driverId);
    setPersonId(personId);
    setLastName(lastName);
    setFirstName(firstName);
    setDrivingCategory(drivingCategory);
    setExperience(experience);
    setSalary(salary);
}

void Driver::setRecord(const QSqlRecord& record)
{
    quint64 driverId = record.value("DriverId").toInt();
    quint64 personId = record.value("PersonId").toInt();
    QString lastName = record.value("LastName").toString();
    QString firstName = record.value("FirstName").toString();
    QString drivingCategory = record.value("DrivingCategory").toString();
    quint64 experience = record.value("Experience").toInt();
    quint64 salary = record.value("Salary").toInt();

    setData(driverId, personId, lastName, firstName,
            drivingCategory, experience, salary
    );

}
