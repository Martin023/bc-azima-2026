namespace BCWMNS.BCWMNS;

using System.Security.AccessControl;

report 52186189 "User Roles and Permissions"
{
    Caption = 'User Roles and Permissions';
    dataset
    {
        dataitem(AccessControl; "Access Control")
        {
            column(User_Name;"User Name")
            {

            }
            column(Role_ID;"Role ID")
            {

            }
            column(Role_Name;"Role Name")
            {

            }
            column(Scope;Scope)
            {

            }
            // dataitem("User Setup";"User Setup")
            // {

            // }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
