#ifndef USERMODEL_H
#define USERMODEL_H

#include <QSqlQueryModel>
#include <QObject>

class UserModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    explicit UserModel(QObject *parent = nullptr);
};

#endif // USERMODEL_H
