#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "usermodel.h"
#include <QDebug>
#include <QSqlDatabase>
#include "abstractsqlquerymodel.h"
#include "carsfiltermodel.h"
#include "carsmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.addImportPath(":/TransportationApp.com/qml");
    engine.loadFromModule("TransportationApp", "Main");

//    QSqlDatabase db = QSqlDatabase::addDatabase("QODBC");

//    db.setDatabaseName("Driver={MySQL ODBC 8.0 Unicode Driver};Server=localhost;Database=TransportationDB;Uid=root;Port=3306;Pwd=5555472Ao&;");

//    db.open();


//    if(db.isOpen()){
//       db.close();
//    }

    return app.exec();
}
