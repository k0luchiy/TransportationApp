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
    engine.loadFromModule("TransportationApp", "Main");

    //Database* db = new Database();
    QSqlDatabase db = QSqlDatabase::addDatabase("QODBC");//new Database();
    //db->addDatabase("QODBC");
    db.setDatabaseName("Driver={MySQL ODBC 8.0 Unicode Driver};Server=localhost;Database=TransportationDB;Uid=root;Port=3306;Pwd=5555472Ao&;");
    //db->setConnectionString();
    db.open();
    if(!db.isOpen()){
        qDebug() << "Db is not opened!\n";
        //return 0;
    }
    UserModel userModel;

    qDebug() << userModel.record(0);
    qDebug() << userModel.roleNames();
    qDebug() << userModel.record(9999).value("UserId");
    //qDebug() << userModel.getRecordByRowNum(0);
    //qDebug() << userModel.findRecord("UserId", 1);
    //qDebug() << userModel.findRecord("UserId", 0);
    //userModel.getRecordById(0,0);
    CarsModel* carsModel = new CarsModel();
    CarsFilterModel* carsFilterModel = new CarsFilterModel();
    carsFilterModel->setSourceModel(carsModel);
    carsFilterModel->setDynamicSortFilter(true);
    carsFilterModel->setFilterCaseSensitivity(Qt::CaseInsensitive);
    carsFilterModel->sort(0, Qt::AscendingOrder);
    //carsFilterModel->setFilterMinVolumeCapacity(30);
    carsFilterModel->setFilterDrivingCategory("C");

    qDebug() << carsModel->rowCount() << carsFilterModel->rowCount();
    qDebug() << carsFilterModel;


    if(db.isOpen()){
       db.close();
    }

    return app.exec();
}
