#ifndef CAR_H
#define CAR_H

#include <QObject>
#include <QSqlRecord>
#include <QString>
#include <QVariant>

class Car : public QObject
{
    Q_OBJECT
    Q_PROPERTY(quint64 carId READ carId WRITE setCarId NOTIFY carIdChanged) //!< car's id property to identify each order
    Q_PROPERTY(QString carType READ carType WRITE setCarType NOTIFY carTypeChanged) //!< Car type
    Q_PROPERTY(QString carModel READ carModel WRITE setCarModel NOTIFY carModelChanged) //!< Car model
    Q_PROPERTY(QString carNumber READ carNumber WRITE setCarNumber NOTIFY carNumberChanged) //!< Car number
    Q_PROPERTY(quint64 volumeCapacity READ volumeCapacity WRITE setVolumeCapacity NOTIFY volumeCapacityChanged) //!< Car volume capacity
    Q_PROPERTY(quint64 weightCapacity READ weightCapacity WRITE setWeightCapacity NOTIFY weightCapacityChanged) //!< Car weight capacity
    Q_PROPERTY(QString drivingCategory READ drivingCategory WRITE setDrivingCategory NOTIFY drivingCategoryChanged) //!< Car driving category

private:
    quint64 m_carId = 0; //!< Car id
    QString m_carType = ""; //!< Car type
    QString m_carModel = ""; //!< Car model
    QString m_carNumber = ""; //!< Car number
    quint64 m_volumeCapacity = 0; //!< Car volume capacity
    quint64 m_weightCapacity = 0;  //!< Car weight capacity
    QString m_drivingCategory= ""; //!< Car driving category

public:
    explicit Car(QObject *parent = nullptr);
    Car(const Car&) = default;

public Q_SLOTS:
    void setData(
        quint64 carId, const QString& carType,
        const QString& carModel, const QString& carNumber,
        quint64 volumeCapacity, quint64 weightCapacity,
        const QString& drivingCategory
    );
    void setRecord(const QSqlRecord& record);

//
// Getters
//
public:
    quint64 carId() const;
    QString carType() const;
    QString carModel() const;
    QString carNumber() const;
    quint64 volumeCapacity() const;
    quint64 weightCapacity() const;
    QString drivingCategory() const;

//
// Setters
//
public:
    void setCarId(quint64 carId);
    void setCarType(const QString &carType);
    void setCarModel(const QString &carModel);
    void setCarNumber(const QString &carNumber);
    void setVolumeCapacity(quint64 volumeCapacity);
    void setWeightCapacity(quint64 weightCapacity);
    void setDrivingCategory(const QString &drivingCategory);

//
// Property's signals
//
signals:
    void carIdChanged();
    void carTypeChanged();
    void carModelChanged();
    void carNumberChanged();
    void volumeCapacityChanged();
    void weightCapacityChanged();
    void drivingCategoryChanged();
};

#endif // CAR_H
