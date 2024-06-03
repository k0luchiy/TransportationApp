/*! \file abstractsqlquerymodel.h
 *  \brief Declaration of abstract sql query model.
 *
 *  File contains declaration of abstract sql query model.
 *
 */

#ifndef ABSTRACTSQLQUERYMODEL_H
#define ABSTRACTSQLQUERYMODEL_H

#include <QSqlQueryModel>
#include <QHash>
#include <QVariant>
#include <QSqlRecord>
#include <QSqlQuery>
#include <QSqlQueryModel>
#include <QSqlError>

/*!
 * \brief The AbstractSqlQueryModel class wrapper for interaction with database tables.
 *
 * AbstractSqlQueryModel represents abstract wrapper from witch all models are inherited.
 * Every derived class should pass select query to constructor witch class gonna execute.
 * After query execution sets rolenames to columns of selected table.
 *
 */
class AbstractSqlQueryModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    //explicit AbstractSqlQueryModel(QObject *parent = nullptr);
    explicit AbstractSqlQueryModel(const QString& select_query, QObject* parent = nullptr);
    virtual ~AbstractSqlQueryModel() = default;

public:
    virtual QVariant data(const QModelIndex& ind, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;
    QString get_query() const;
    virtual void setQuery(const QString& query, const QSqlDatabase& db = QSqlDatabase());
    virtual void setQuery(QString&& query);
    virtual void updateModel();
    virtual void generateRoleNames();

public Q_SLOTS:
    QSqlRecord getRecordByRowNum(quint64 rowNum) const;
    QModelIndex findIndex(const QString& fieldName, const QVariant& value) const;
    QSqlRecord findRecord(const QString& fieldName, const QVariant& value) const;
    QVariant getValue(quint64 recordId, const QString& fieldName) const;

private:
    QString m_select_query;        //!< Query to database for selecting all user information.
    QHash<int, QByteArray> m_roleNames;
};

#endif // ABSTRACTSQLQUERYMODEL_H


