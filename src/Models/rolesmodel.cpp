/*! \file rolesmodel.cpp
 *  \brief RolesModel class source file.
 *
 *  This file contains RolesModel class implementation.
 *
 */

#include "rolesmodel.h"

//! Query whitch AbstractSqlQueryModel will execute for selecting all roles information.
const char* RolesModel::SELECT_QUERY =
    " SELECT ur.RoleId, ur.RoleTitle, ur.RolePriority  "
    " from UserRoles ur  "
    " order by ur.RolePriority asc; ";


RolesModel::RolesModel(QObject *parent)
    : AbstractSqlQueryModel{SELECT_QUERY, parent}
{

}

/*!
 * \brief Returns lowest role priority or 0 if records empty
 * \return Returns lowest role priority or 0 if records empty
 */
quint32 RolesModel::get_minPriority() const
{
    try{
        return this->record(0).value("RolePriority").toInt();
    }
    catch(...){
        return 0;
    }
}

/*!
 * \brief Returns greatest role priority or 0 if records empty
 * \return Returns greatest role priority or 0 if records empty
 */
quint32 RolesModel::get_maxPriority() const
{
    try{
        quint32 recordsCount = this->rowCount();
        return this->record(recordsCount-1).value("RolePriority").toInt();
    }
    catch(...){
        return 0;
    }
}

/*!
 * \brief Returns role id of a lowest priority or 0 if records empty
 * \return Returns role id of a lowest priority or 0 if records empty
 */
quint32 RolesModel::get_minPriority_roleId() const
{
    try{
        return this->record(0).value("RoleId").toInt();
    }
    catch(...){
        return 0;
    }
}

/*!
 * \brief Returns role id of a greatest priority or 0 if records empty
 * \return Returns role id of a greatest priority or 0 if records empty
 */
quint32 RolesModel::get_maxPriority_roleId() const
{
    try{
        quint32 recordsCount = this->rowCount();
        return this->record(recordsCount-1).value("RoleId").toInt();
    }
    catch(...){
        return 0;
    }
}
