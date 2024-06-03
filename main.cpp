#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>
#include <QSqlDatabase>

#include "usermodel.h"
#include "abstractsqlquerymodel.h"
#include "carsfiltermodel.h"
#include "carsmodel.h"
#include "ordersfiltermodel.h"
#include "ordersmodel.h"

#include "order.h"

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

//    QString query =
//        "select \
//          o.OrderId, o.CreatedDate, o.AskedDeliveryDate,  \
//          s.StatusId, s.StatusTitle, o.Cost,  \
//          o.Address, o.Volume, o.Weight   \
//          from Orders o   \
//          join OrderStatus s on o.StatusId = s.StatusId ";

    UserModel* userModel = new UserModel();
    //qDebug() << userModel->rowCount() << userModel->record(0);

    OrdersModel* ordersModel = new OrdersModel();
    //ordersModel->setQuery(query);
    OrdersFilterModel* ordersFilterModel = new OrdersFilterModel();
    ordersFilterModel->setSourceModel(ordersModel);
    ordersFilterModel->setDynamicSortFilter(true);
    ordersFilterModel->setFilterCaseSensitivity(Qt::CaseInsensitive);
    ordersFilterModel->sort(0, Qt::AscendingOrder);
    //ordersFilterModel->setFilterOrderId(3);

    engine.rootContext()->setContextProperty("orders", ordersModel);
    engine.rootContext()->setContextProperty("ordersFilterModel", ordersFilterModel);


    qmlRegisterType<Order>("TransportationsApp.Models", 1, 0, "Order");
    engine.loadFromModule("TransportationApp", "Main");

//    if(db.isOpen()){
//       db.close();
//    }

    return app.exec();
}
