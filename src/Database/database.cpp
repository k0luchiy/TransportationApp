#include "database.h"

Database::Database()
{

}


bool Database::connectToDatabase(){
    this->addDatabase("QMYSQL");
    this->setHostName("127.0.0.1");
    this->setDatabaseName("TransportationDb");
    this->setUserName("root");
    this->setPassword("5555472Ao&");
    this->setPort(3306);

    return this->open();
}
