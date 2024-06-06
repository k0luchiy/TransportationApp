#include <QtTest>
#include <QSqlDatabase>
#include <QSqlRecord>
#include <QVariant>
#include <QDebug>
#include <QVector>
#include <QSharedPointer>

#include "abstractsqlquerymodel.h"
//#include "usermodel.h"
#include "rolesmodel.h"
#include "drivermodel.h"
#include "carsmodel.h"
#include "ordersmodel.h"
#include "orderstatusmodel.h"
#include "drivingcategoriesmodel.h"

class ModelsTest : public QObject
{
    Q_OBJECT
private:
    QSharedPointer<QVector<AbstractSqlQueryModel*>> models;
    QSqlDatabase db;

public:
    ModelsTest();
    ~ModelsTest();

private:
    void connect_database();
    void fill_models();
    void setDataForTest();

private slots:
    void initTestCase_data();
    void initTestCase();
    void cleanupTestCase();

    void test_roleNames();
    void test_modelData();
    void test_getRecordByRowNum();
    //void test_getRecordByRowNum_data();
    void test_findRecord();
    void test_getValue();
};

ModelsTest::ModelsTest()
{

}

ModelsTest::~ModelsTest()
{

}

void ModelsTest::connect_database()
{
    db = QSqlDatabase::addDatabase("QODBC");
    db.setDatabaseName("Driver={MySQL ODBC 8.0 Unicode Driver};Server=localhost;Database=TransportationDB;Uid=root;Port=3306;Pwd=5555472Ao&;");
    db.open();
}

void ModelsTest::fill_models()
{
    models = QSharedPointer< QVector<AbstractSqlQueryModel*> > ( new QVector<AbstractSqlQueryModel*>() ) ;
    //UserModel* userModel = new UserModel();
    RolesModel* rolesModel = new RolesModel();
    DriverModel* driverModel = new DriverModel();
    CarsModel* carsModel = new CarsModel();
    OrdersModel* ordersModel = new OrdersModel();
    DrivingCategoriesModel* drivingCategoriesModel = new DrivingCategoriesModel();
    OrderStatusModel* statusModel = new OrderStatusModel();


    //models->push_back(userModel);
    models->push_back(rolesModel);
    models->push_back(driverModel);
    models->push_back(carsModel);
    models->push_back(ordersModel);
    models->push_back(drivingCategoriesModel);
    models->push_back(statusModel);
}

void ModelsTest::initTestCase_data()
{
    QTest::ignoreMessage(QtWarningMsg, QRegularExpression(".*?invalid nullptr parameter.*?"));
    connect_database();
    fill_models();

    qDebug() << "Data";
    QTest::addColumn<AbstractSqlQueryModel*>("model");
    QTest::addColumn<quint64>("index");

    for(size_t i=0; i<models->size(); ++i){
        AbstractSqlQueryModel* model = models->at(i);
        QTest::newRow(typeid(*model).name()) << model << i;
    }
}

void ModelsTest::initTestCase()
{
    // all implementation now in initTestCase_data
}

void ModelsTest::cleanupTestCase()
{
    for(size_t i=0; i<models->size(); ++i){
        AbstractSqlQueryModel* model = models->at(i);
        delete model;
    }

    db.close();
}

void ModelsTest::test_roleNames()
{
    QFETCH_GLOBAL(AbstractSqlQueryModel*, model);

    QSqlRecord empty_record = model->record();
    auto roleNames = model->roleNames();

    QCOMPARE_NE(empty_record.count(), 0);
    QCOMPARE_EQ(roleNames.count(), empty_record.count());

    for(auto roleName : roleNames.values()){
        QVERIFY(empty_record.contains(roleName));
    }
}

void ModelsTest::test_modelData()
{
    QFETCH_GLOBAL(AbstractSqlQueryModel*, model);
    QSqlRecord record = model->record(0);

    QCOMPARE_NE(model->rowCount(), 0);
    QCOMPARE_NE(record.count(), 0);

    for(quint32 i=0; i < record.count(); ++i){
        QVariant record_value = record.value(i);
        QVariant data_value = model->data(model->index(0, i), i+Qt::UserRole+1);

        QCOMPARE_EQ(record_value, data_value);
    }
}


void ModelsTest::test_getRecordByRowNum()
{
    QFETCH_GLOBAL(AbstractSqlQueryModel*, model);
    QCOMPARE_EQ(model->getRecordByRowNum(0), model->record(0));
    QCOMPARE_EQ(model->getRecordByRowNum(-1), QSqlRecord());
    QCOMPARE_EQ(model->getRecordByRowNum(model->rowCount() + 1), QSqlRecord());
}

void ModelsTest::test_findRecord()
{
    QFETCH_GLOBAL(AbstractSqlQueryModel*, model);

    QString fieldName = model->record().fieldName(0);
    QVariant value = model->record(0).value(0);

    QCOMPARE_NE(model->rowCount(), 0);
    QCOMPARE_NE(fieldName, "");
    QVERIFY(value.isValid());

    QSqlRecord record = model->findRecord(fieldName, value);
    QVariant res_value = record.value(fieldName);
    QCOMPARE_EQ(res_value, value);

    record = model->findRecord("NonExistingField", value);
    QVERIFY(record.isEmpty());

    record = model->findRecord(fieldName, "NonExistingValue");
    QVERIFY(record.isEmpty());
}

void ModelsTest::test_getValue()
{
    QFETCH_GLOBAL(AbstractSqlQueryModel*, model);

    quint64 recordId = 0;
    QString fieldName = model->record().fieldName(0);
    QVariant value = model->record(recordId).value(fieldName);

    QCOMPARE_NE(model->rowCount(), 0);
    QCOMPARE_NE(fieldName, "");
    QVERIFY(value.isValid());

    QCOMPARE_EQ(model->getValue(recordId, fieldName), value);
    QVERIFY(!model->getValue(recordId, "NonExistingField").isValid());
    QVERIFY(!model->getValue(model->rowCount()+1, fieldName).isValid());
}

QTEST_APPLESS_MAIN(ModelsTest)

#include "tst_modelstest.moc"
