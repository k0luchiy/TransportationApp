#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QSettings>

class Settings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool rememberUser READ rememberUser WRITE setRememberUser NOTIFY rememberUserChanged)
    Q_PROPERTY(bool darkMode READ darkMode WRITE setDarkMode NOTIFY darkModeChanged)
    Q_PROPERTY(quint64 userId READ userId WRITE setUserId NOTIFY userIdChanged)

private:
    QSettings* settingsConfig;
    QString fileName = "settings/settingsConfig.ini";
    bool m_rememberUser = false;
    bool m_darkMode = false;
    quint64 m_userId = 0;

public:
    explicit Settings(QObject *parent = nullptr);

public Q_SLOTS:
    void loadSettings();
    void dumpSettings();

//
// Getters
//
public:
    bool rememberUser() const;
    bool darkMode() const;
    quint64 userId() const;

//
// Setters
//
public:
    void setRememberUser(bool rememberUser);
    void setDarkMode(bool darkMode);
    void setUserId(quint64 userId);

//
// Property's signals
//
signals:
    void rememberUserChanged(); //!< Emits signal if userId changed
    void darkModeChanged(); //!< Emits signal if userId changed
    void userIdChanged(); //!< Emits signal if userId changed

};

#endif // SETTINGS_H
