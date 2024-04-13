#ifndef DATABASE_H
#define DATABASE_H

#include <QSqlDatabase>


class Database : public QSqlDatabase
{
public:
    Database();

public:
    bool connectToDatabase();

};

#endif // DATABASE_H
