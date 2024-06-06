#include <QtTest>
#include <QSqlDatabase>
#include <QSqlRecord>
#include <QVariant>
#include <QDebug>

#include "user.h"

class UserModelTest : public QObject
{
    Q_OBJECT
private:
    User* user;
    QSqlDatabase db;

public:
    UserModelTest();
    ~UserModelTest();

private slots:
    void initTestCase();
    void cleanupTestCase();
    void test_isUserExist();
};

UserModelTest::UserModelTest()
{

}

UserModelTest::~UserModelTest()
{

}

void UserModelTest::initTestCase()
{
    // trying to connect to QCoreApplication
    QTest::ignoreMessage(QtWarningMsg, QRegularExpression(".*?invalid nullptr parameter.*?"));

    db = QSqlDatabase::addDatabase("QODBC");
    db.setDatabaseName("Driver={MySQL ODBC 8.0 Unicode Driver};Server=localhost;Database=TransportationDB;Uid=root;Port=3306;Pwd=5555472Ao&;");
    db.open();

    user = new User();
}

void UserModelTest::cleanupTestCase()
{
    db.close();
    delete user;
}

void UserModelTest::test_isUserExist()
{
    QVERIFY(user->isUserExist("antoshka.osipov.04@mail.ru"));
    QVERIFY(!user->isUserExist("imposible email"));
    QVERIFY(!user->isUserExist(""));
}

QTEST_APPLESS_MAIN(UserModelTest)

#include "tst_usermodelstest.moc"
