#include "settings.h"

Settings::Settings(QObject *parent)
    : QObject{parent}
{
    settingsConfig = new QSettings(fileName, QSettings::IniFormat);
}

bool Settings::rememberUser() const { return m_rememberUser; }
bool Settings::darkMode() const { return m_darkMode; }
quint64 Settings::userId() const { return m_userId; }

void Settings::setRememberUser(bool rememberUser) { m_rememberUser = rememberUser; rememberUserChanged(); }
void Settings::setDarkMode(bool darkMode) { m_darkMode = darkMode; darkModeChanged(); }
void Settings::setUserId(quint64 userId) { m_userId = userId; userIdChanged(); }

void Settings::loadSettings()
{
    settingsConfig->beginGroup("settings");
    bool rememberUser = settingsConfig->value("rememberUser").toBool();
    bool darkMode = settingsConfig->value("darkMode").toBool();
    quint64 userId = settingsConfig->value("userId").toUInt();
    settingsConfig->endGroup();

    setRememberUser(rememberUser);
    setDarkMode(darkMode);
    setUserId(userId);
}

void Settings::dumpSettings()
{
    settingsConfig->beginGroup("settings");
    settingsConfig->setValue("rememberUser", m_rememberUser);
    settingsConfig->setValue("darkMode", m_darkMode);
    if(m_rememberUser){
        settingsConfig->setValue("userId", m_userId);
    }
    else{
        settingsConfig->remove("userId");
    }
    settingsConfig->endGroup();
}
