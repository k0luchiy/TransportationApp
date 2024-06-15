#include "translationhandler.h"
#include <QGuiApplication>

TranslationHandler::TranslationHandler(QObject *parent)
    : QObject{parent}
{

}

QString TranslationHandler::language() const { return m_language; }

void TranslationHandler::setLanguage(const QString& language) {
    if (translator.load("translations/TransportationApp_" + language + ".qm")) {
        m_language = language;
        qApp->installTranslator(&translator);
        emit languageChanged();
    }
}
