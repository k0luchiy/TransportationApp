/*! \file abstractsqlquerymodel.cpp
 *  \brief Defifnition of AbstractSqlQueryModel class.
 */

#include "abstractsqlquerymodel.h"

AbstractSqlQueryModel::AbstractSqlQueryModel(const QString& select_query, QObject* parent)
    : QSqlQueryModel{parent}
{
    setQuery(select_query);
}


//! Getter for role names
QHash<int, QByteArray> AbstractSqlQueryModel::roleNames() const
{
    return m_roleNames;
}

//! Generates role names from record columns
void AbstractSqlQueryModel::generateRoleNames()
{
    m_roleNames.clear();
    QSqlRecord empty_record = record(); // gets empty record with fields information
    for(size_t i=0; i < empty_record.count(); ++i){
        m_roleNames.insert(Qt::UserRole + i +1, empty_record.fieldName(i).toUtf8());
    }
}

//! Get current query from model
QString AbstractSqlQueryModel::get_query() const {
    return m_select_query;
}

//! Sets given query to model
void AbstractSqlQueryModel::setQuery(const QString& query, const QSqlDatabase& db)
{
    QSqlQueryModel::setQuery(query, db);
    generateRoleNames();
}

//! Sets given query to model
void AbstractSqlQueryModel::setQuery(QString&& query)
{
    QSqlQueryModel::setQuery(std::move(query));
    generateRoleNames();
}

/*! \brief Returns the value for the specified index and role.
 *  If item is out of bounds or if an error occurred, an invalid QVariant is returned.
 *
 *  @param index Index of a record row
 *  @param role Role name to get value from. Simply column index.
 *  @return Returns value of a specified row and column or empty QVariant on error.
 */
QVariant AbstractSqlQueryModel::data(const QModelIndex& index, int role) const
{
    QVariant value;
    if(role < Qt::UserRole){
        value = QSqlQueryModel::data(index, role);
        return value;
    }

    int columnInd = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(index.row(), columnInd);
    value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);

    return value;
}

/*!
 * \brief Updates data in the model by running current query.
 */
void AbstractSqlQueryModel::updateModel()
{
    setQuery(get_query());
}




