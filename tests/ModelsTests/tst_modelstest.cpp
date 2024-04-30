#include <QtTest>
#include <QSqlDatabase>
#include <QSqlRecord>
#include <QVariant>
#include <QDebug>
#include <QVector>
#include <QSharedPointer>

#include "abstractsqlquerymodel.h"
#include "usermodel.h"
#include "rolesmodel.h"
#include "drivermodel.h"
#include "carsmodel.h"

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
    void test_getRecordByValue();
    void test_getRecordByValue_data();
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
    UserModel* userModel = new UserModel();
    RolesModel* rolesModel = new RolesModel();
    DriverModel* driverModel = new DriverModel();
    CarsModel* carsModel = new CarsModel();


    models->push_back(userModel);
    models->push_back(rolesModel);
    models->push_back(driverModel);
    models->push_back(carsModel);
}

void ModelsTest::initTestCase_data()
{
    QTest::ignoreMessage(QtWarningMsg, QRegularExpression(".*?invalid nullptr parameter.*?"));
    connect_database();
    fill_models();

    qDebug() << "Data";
    QTest::addColumn<AbstractSqlQueryModel*>("model");

    for(size_t i=0; i<models->size(); ++i){
        AbstractSqlQueryModel* model = models->at(i);
        QTest::newRow(typeid(*model).name()) << model;
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

void ModelsTest::test_getRecordByValue_data()
{
    QTest::addColumn<int>("columnIndex");
    QTest::addColumn<QVariant>("value");
    QTest::addColumn<QVariant>("expected");

    QTest::addRow("FirstValue") << 0 << QVariant{1} << QVariant{1};
    QTest::addRow("NonExistingValue") << 0 << QVariant{9999} << QVariant{};
    QTest::addRow("OutOfRange") << 9999 <<  QVariant{1} << QVariant{};
}

void ModelsTest::test_getRecordByValue()
{
    QFETCH_GLOBAL(AbstractSqlQueryModel*, model);
    QFETCH(int, columnIndex);
    QFETCH(QVariant, value);
    QFETCH(QVariant, expected);

    QVariant res_value = model->getRecordByValue(columnIndex, value).value(columnIndex);
    QCOMPARE_EQ(res_value, expected);
    //QCOMPARE_EQ(model->getRecordByRowNum(0, value), 0);

}

QTEST_APPLESS_MAIN(ModelsTest)

#include "tst_modelstest.moc"
