#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>
#include <QSqlDatabase>

#include "abstractsqlquerymodel.h"
#include "carsfiltermodel.h"
#include "carsmodel.h"
#include "drivingcategoriesmodel.h"
#include "ordersfiltermodel.h"
#include "ordersmodel.h"
#include "orderstatusmodel.h"
#include "drivermodel.h"
#include "driversfiltermodel.h"

#include "user.h"
#include "order.h"
#include "car.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.addImportPath(":/TransportationApp.com/qml");


    QSqlDatabase db = QSqlDatabase::addDatabase("QODBC");
    db.setDatabaseName("Driver={MySQL ODBC 8.0 Unicode Driver};Server=localhost;Database=TransportationDB;Uid=root;Port=3306;Pwd=5555472Ao&;");
    db.open();

    User* user = new User();
    OrderStatusModel* ordersStatusModel = new OrderStatusModel();
    DrivingCategoriesModel* drivingCatefories = new DrivingCategoriesModel();

    OrdersModel* ordersModel = new OrdersModel();
    OrdersFilterModel* ordersFilterModel = new OrdersFilterModel();
    ordersFilterModel->setSourceModel(ordersModel);
    ordersFilterModel->setDynamicSortFilter(true);
    ordersFilterModel->setFilterCaseSensitivity(Qt::CaseInsensitive);
    ordersFilterModel->sort(0, Qt::AscendingOrder);

    CarsModel* carsModel = new CarsModel();
    CarsFilterModel* carsFilterModel = new CarsFilterModel();
    carsFilterModel->setSourceModel(carsModel);
    carsFilterModel->setDynamicSortFilter(true);
    carsFilterModel->setFilterCaseSensitivity(Qt::CaseInsensitive);
    carsFilterModel->sort(0, Qt::AscendingOrder);

    DriverModel* driversModel = new DriverModel();
    DriversFilterModel* driversFilterModel = new DriversFilterModel();
    driversFilterModel->setSourceModel(driversModel);
    driversFilterModel->setDynamicSortFilter(true);
    driversFilterModel->setFilterCaseSensitivity(Qt::CaseInsensitive);
    driversFilterModel->sort(0, Qt::AscendingOrder);

    engine.rootContext()->setContextProperty("user", user);
    engine.rootContext()->setContextProperty("drivingCatefories", drivingCatefories);
    engine.rootContext()->setContextProperty("ordersStatusModel", ordersStatusModel);
    engine.rootContext()->setContextProperty("ordersModel", ordersModel);
    engine.rootContext()->setContextProperty("ordersFilterModel", ordersFilterModel);
    engine.rootContext()->setContextProperty("carsModel", carsModel);
    engine.rootContext()->setContextProperty("carsFilterModel", carsFilterModel);

    //qmlRegisterType<User>("TransportationsApp.Models", 1, 0, "User");
    qmlRegisterType<Order>("TransportationsApp.Models", 1, 0, "Order");
    qmlRegisterType<Car>("TransportationsApp.Models", 1, 0, "Car");

    engine.loadFromModule("TransportationApp", "Main");

//    if(db.isOpen()){
//       db.close();
//    }

    return app.exec();
}
