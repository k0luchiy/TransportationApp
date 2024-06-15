#ifndef TRANSLATIONHANDLER_H
#define TRANSLATIONHANDLER_H

#include <QObject>
#include <QTranslator>

class TranslationHandler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString language READ language WRITE setLanguage NOTIFY languageChanged)

private:
    QTranslator translator;
    QString m_language = "";

public:
    explicit TranslationHandler(QObject *parent = nullptr);

public:
    QString language() const;

public:
    void setLanguage(const QString& language);

signals:
    void languageChanged();

};

#endif // TRANSLATIONHANDLER_H
