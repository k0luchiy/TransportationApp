#include <QtTest>
#include <QSqlDatabase>
#include <QSqlRecord>
#include <QVariant>
#include <QDebug>

#include "usermodel.h"

class UserModelTest : public QObject
{
    Q_OBJECT
private:
    UserModel* userModel;
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

    userModel = new UserModel();
    //userModel->updateModel();
}

void UserModelTest::cleanupTestCase()
{
    db.close();
    delete userModel;
}

void UserModelTest::test_isUserExist()
{
    QSqlRecord user_record = userModel->record(0);
    QString email = user_record.value("Email").toString();
    QVERIFY(userModel->isUserExist(email));
    QVERIFY(!userModel->isUserExist("imposible email"));
    QVERIFY(!userModel->isUserExist(""));
}

QTEST_APPLESS_MAIN(UserModelTest)

#include "tst_usermodelstest.moc"
