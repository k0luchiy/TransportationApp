/*! \file abstractsqlquerymodel.cpp
 *  \brief Defifnition of AbstractSqlQueryModel class.
 */

#include "abstractsqlquerymodel.h"

AbstractSqlQueryModel::AbstractSqlQueryModel(const QString& select_query, QObject* parent)
    : QSqlQueryModel{parent}, m_select_query(select_query)
{
    updateModel();
}

//int AbstractSqlQueryModel::rowCount(const QModelIndex& parent) const
//{
//    return QSqlQueryModel::rowCount();
//}

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
    this->QSqlQueryModel::setQuery(query, db);
    generateRoleNames();
}

//! Sets given query to model
void AbstractSqlQueryModel::setQuery(QString&& query)
{
    this->QSqlQueryModel::setQuery(std::move(query));
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
    this->setQuery(m_select_query);
    if (this->lastError().isValid()) {
        qDebug() << "Failed to execute query:" << this->lastError();
    }
    generateRoleNames();
}

/*!
 * \brief Returns record by specified id.
 * \param rowNum Record id
 * \return  Record from model or empty record.
 */
QSqlRecord AbstractSqlQueryModel::getRecordByRowNum(quint64 rowNum) const
{
    if(rowNum < 0 || rowNum >= rowCount()){
        return QSqlRecord();//record();
    }
    return record(rowNum);
}

/*!
 * \brief Gets record index of specified value and column index.
 * \param columnIndex Index of a column in a model in witch value will be searched.
 * \param value Value to find in a model.
 * \return Index of record with specified value or empty index on error.
 */
QModelIndex AbstractSqlQueryModel::findIndex(const QString& fieldName, const QVariant& value) const {
    int columnIndex = this->record().indexOf(fieldName);
    if(columnIndex==-1){
        return QModelIndex();
    }

    QModelIndex startIndex = this->index(0, columnIndex);

    QModelIndexList indexes = this->match(startIndex, columnIndex, value);
    if(indexes.empty()){
        return QModelIndex();
    }

    return indexes.at(0);
}

/*!
 * \brief Gets record of specified value and column index.
 * \param columnIndex Index of a column in a model in witch value will be searched.
 * \param value Value to find in a model.
 * \return Record with specified value or empty record otherwise.
 */
QSqlRecord AbstractSqlQueryModel::findRecord(const QString& fieldName, const QVariant& value) const
{
    QModelIndex rowInd = findIndex(fieldName, value);
    if(!rowInd.isValid()){
        return QSqlRecord();
    }

    return this->record(rowInd.row());
}

/*!
 * \brief Gets value by record id and fieldName.
 * \param recordId Id of record in model to get data from.
 * \param fieldName Field name to get data from.
 * \return Returns value in record or QVariant(Invalid) on error.
 */
QVariant AbstractSqlQueryModel::getValue(quint64 recordId, const QString& fieldName) const
{
    return record(recordId).value(fieldName);
}

