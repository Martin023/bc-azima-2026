namespace BCWMNS.BCWMNS;

using System.Security.AccessControl;

page 52186615 "User Permission Roles"
{
    Caption = 'Users Permissions Roles';
    PageType = List;
    SourceTable = "Access Control";
    ApplicationArea = All;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;


    layout
    {
        area(Content)
        {
            repeater(General)
            {


                field("User Name"; Rec."User Name")
                {

                }
                field("Role ID"; Rec."Role ID")
                {

                }
                field("Role Name"; Rec."Role Name")
                {

                }
                field("Company Name"; Rec."Company Name")
                {

                }

            }
        }
    }
    actions
    {
        // Define any actions here
    }
}

