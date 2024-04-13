#include <QtTest>
#include "database.h"
// add necessary includes here

class DatabaseTest : public QObject
{
    Q_OBJECT

public:
    DatabaseTest();
    ~DatabaseTest();

private slots:
    void initTestCase();
    void cleanupTestCase();
    void test_connectionOpen();

private:
    Database* db;
};

DatabaseTest::DatabaseTest()
{

}

DatabaseTest::~DatabaseTest()
{

}

void DatabaseTest::initTestCase()
{
    this->db = new Database();
}

void DatabaseTest::cleanupTestCase()
{

}

void DatabaseTest::test_connectionOpen()
{
    QVERIFY(true);
    //QVERIFY(db->connectToDatabase());
    //QCOMPARE_EQ(db->port(), 3306);
}


QTEST_APPLESS_MAIN(DatabaseTest)

#include "tst_databasetest.moc"
