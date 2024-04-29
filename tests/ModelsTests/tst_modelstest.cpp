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

class ModelsTest : public QObject
{
    Q_OBJECT
private:
    QSharedPointer<QVector<AbstractSqlQueryModel*>> models;
    QSqlDatabase db;

public:
    ModelsTest();
    ~ModelsTest();

private slots:
    void initTestCase();
    void cleanupTestCase();
    void test_roleNames();
    void test_modelData();
};

ModelsTest::ModelsTest()
{

}

ModelsTest::~ModelsTest()
{

}

void ModelsTest::initTestCase()
{
    // trying to connect to QCoreApplication
    QTest::ignoreMessage(QtWarningMsg, QRegularExpression(".*?invalid nullptr parameter.*?"));

    db = QSqlDatabase::addDatabase("QODBC");
    db.setDatabaseName("Driver={MySQL ODBC 8.0 Unicode Driver};Server=localhost;Database=TransportationDB;Uid=root;Port=3306;Pwd=5555472Ao&;");
    db.open();

    models = QSharedPointer<QVector<AbstractSqlQueryModel*>> ( new QVector<AbstractSqlQueryModel*>() ) ;
    UserModel* userModel = new UserModel();
    RolesModel* rolesModel = new RolesModel();

    models->push_back(userModel);
    models->push_back(rolesModel);
    //userModel->updateModel();
}

void ModelsTest::cleanupTestCase()
{
    db.close();
}

void ModelsTest::test_roleNames()
{
    QVector<AbstractSqlQueryModel*>* temp_models = models.get();
    //for(auto model : temp_models){
    for(size_t i=0; i<temp_models->size(); ++i){
        AbstractSqlQueryModel* model = temp_models->at(i);

        QSqlRecord empty_record = model->record();
        auto roleNames = model->roleNames();

        QCOMPARE_EQ(roleNames.count(), empty_record.count());
        for(auto roleName : roleNames.values()){
            QVERIFY(empty_record.contains(roleName));
        }
    }
}

void ModelsTest::test_modelData()
{
    QVector<AbstractSqlQueryModel*>* temp_models = models.get();
    //for(auto model : temp_models){
    for(size_t i=0; i<temp_models->size(); ++i){
        AbstractSqlQueryModel* model = temp_models->at(i);

        QSqlRecord record = model->record(0);
        qDebug() << record;
        for(quint32 i=0; i < record.count(); ++i){
            QVariant record_value = record.value(i);
            QVariant data_value = model->data(model->index(0, i), i+Qt::UserRole+1);

            QCOMPARE_EQ(record_value, data_value);
        }
    }
}

QTEST_APPLESS_MAIN(ModelsTest)

#include "tst_modelstest.moc"
