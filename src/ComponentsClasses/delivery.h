#ifndef DELIVERY_H
#define DELIVERY_H

#include <QObject>
#include <QDate>
#include <QString>
#include <QSqlRecord>

class Delivery : public QObject
{
    Q_OBJECT
    Q_PROPERTY(quint64 deliveryId READ deliveryId WRITE setDeliveryId NOTIFY deliveryIdChanged) //!< delivery's id property to identify each delivery
    Q_PROPERTY(quint64 carId READ carId WRITE setCarId NOTIFY carIdChanged) //!< Car id fot delivery
    Q_PROPERTY(quint64 driverId READ driverId WRITE setDriverId NOTIFY driverIdChanged) //!< Driver id for delivery
    Q_PROPERTY(QDate departureDate READ departureDate WRITE setDepartureDate NOTIFY departureDateChanged) //!< Departure date
    Q_PROPERTY(QDate returnDate READ returnDate WRITE setReturnDate NOTIFY returnDateChanged) //!< Departure date
    Q_PROPERTY(quint64 statusId READ statusId WRITE setStatusId NOTIFY statusIdChanged) //!< Delivery status id
    Q_PROPERTY(QString statusTitle READ statusTitle WRITE setStatusTitle NOTIFY statusTitleChanged) //!< Delivery status title


private:
    quint64 m_deliveryId = 0; //!< Delivery id
    quint64 m_carId = 0; //!< Car id
    quint64 m_driverId = 0; //!< Driver id
    QDate m_departureDate; //!< Departure date
    QDate m_returnDate; //!< Return date
    quint64 m_statusId = 0; //!< Order status id
    QString m_statusTitle = ""; //!< Order status title

public:
    explicit Delivery(QObject *parent = nullptr);
    Delivery(const Delivery&) = default;

public Q_SLOTS:
    void setData(
        quint64 deliveryId, quint64 carId, quint64 driverId,
        const QDate& departureDate, const QDate& returnDate,
        quint64 statusId, const QString& statusTitle
    );
    void setRecord(const QSqlRecord& record);

//
// Getters
//
public:
    quint64 deliveryId() const;
    quint64 carId() const;
    quint64 driverId() const;
    QDate departureDate() const;
    QDate returnDate() const;
    quint64 statusId() const;
    QString statusTitle() const;

//
// Setters
//
public:
    void setDeliveryId(quint64 deliveryId);
    void setCarId(quint64 carId);
    void setDriverId(quint64 driverId);
    void setDepartureDate(const QDate &departureDate);
    void setReturnDate(const QDate &returnDate);
    void setStatusId(quint64 statusId);
    void setStatusTitle(const QString &statusTitle);

//
// Property's signals
//
signals:
    void deliveryIdChanged();
    void carIdChanged();
    void driverIdChanged();
    void departureDateChanged();
    void returnDateChanged();
    void statusIdChanged();
    void statusTitleChanged();

};

#endif // DELIVERY_H
