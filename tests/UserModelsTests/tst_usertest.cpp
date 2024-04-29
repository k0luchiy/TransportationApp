#include <QtQuickTest>
#include <QQmlEngine>
#include <QQmlContext>
#include <QGuiApplication>
//#include "user.h"

//class UserTest : public QObject
//{
//    Q_OBJECT
//private:
//    QGuiApplication app;

//public:
//    UserTest() {}

//public slots:
//    void applicationAvailable()
//    {
//        // Initialization that only requires the QGuiApplication object to be available
//        QGuiApplication app;

//        QQmlApplicationEngine engine;

//        User* user = new User();

//        QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
//            &app, []() { QCoreApplication::exit(-1); },
//            Qt::QueuedConnection);

//        engine.addImportPath("qrc:/");
//        engine.addImportPath("qrc:/Icons/");

//        engine.rootContext()->setContextProperty("user", user);
//        engine.loadFromModule("Diploma_Transportation", "LoginForm");
//        app.exec();

//    }

//    void qmlEngineAvailable(QQmlEngine *engine)
//    {
//        // Initialization requiring the QQmlEngine to be constructed

//        engine->rootContext()->setContextProperty("myContextProperty", QVariant(true));
//        //qmlRegisterType<User>("UserModel", 1, 0, "User");
//    }

//    void cleanupTestCase()
//    {
//        // Implement custom resource cleanup
//    }
//};

//QUICK_TEST_MAIN_WITH_SETUP(MyTest, UserTest)
QUICK_TEST_MAIN(UserTest)

#include "tst_usertest.moc"
