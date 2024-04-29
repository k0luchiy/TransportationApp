#include <QtTest>
#include <QSqlDatabase>

class DatabaseTest : public QObject
{
    Q_OBJECT

public:
    QSqlDatabase db;
public:
    DatabaseTest();
    ~DatabaseTest();

private slots:
    void initTestCase();
    void cleanupTestCase();
    void test_connectionOptions();
    void test_connectionOpen();
    void test_connectionClose();
};

DatabaseTest::DatabaseTest()
{

}

DatabaseTest::~DatabaseTest()
{

}

void DatabaseTest::initTestCase()
{
    //    db.setDatabaseName("Driver={MySQL ODBC 8.0 Unicode Driver};Server=localhost;Database=TransportationDB;Uid=root;Port=3306;Pwd=5555472Ao&;");

    // trying to connect to QCoreApplication
    QTest::ignoreMessage(QtWarningMsg, QRegularExpression(".*?invalid nullptr parameter.*?"));
    db = QSqlDatabase::addDatabase("QODBC");
    db.setDatabaseName("Driver={MySQL ODBC 8.0 Unicode Driver};Database=TransportationDB;");
    db.setHostName("localhost");
    db.setPort(3306);
    db.setUserName("root");
    db.setPassword("5555472Ao&");
}

void DatabaseTest::cleanupTestCase()
{
}

void DatabaseTest::test_connectionOptions()
{
    QCOMPARE_EQ(db.hostName(), "localhost");
    QCOMPARE_EQ(db.databaseName(), "Driver={MySQL ODBC 8.0 Unicode Driver};Database=TransportationDB;");
    QCOMPARE_EQ(db.userName(), "root");
    QCOMPARE_EQ(db.port(), 3306);
    QVERIFY(db.isValid());
}

void DatabaseTest::test_connectionOpen()
{
    QVERIFY(!db.isOpen());
    db.open();
    QVERIFY(db.isOpen());
    QVERIFY(!db.isOpenError());
}

void DatabaseTest::test_connectionClose()
{
    if(!db.isOpen()){
        db.open();
    }
    db.close();

    QVERIFY(!db.isOpen());
}

QTEST_APPLESS_MAIN(DatabaseTest)

#include "tst_databasetest.moc"
