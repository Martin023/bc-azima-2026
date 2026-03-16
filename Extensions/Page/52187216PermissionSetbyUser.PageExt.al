#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187216 pageextension52187216 extends "Permission Set by User" 
{
    layout
    {
        modify(SelectedCompany)
        {
            ApplicationArea = Basic;
        }
        modify(ShowDomainName)
        {
            ApplicationArea = Basic;
        }
        modify("Role ID")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("App ID")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""App ID"(Control 31)".

        }
        modify("App Name")
        {
            Caption = 'Nav App Name';
            ApplicationArea = Basic;
        }
        modify(AllUsersHavePermission)
        {
            ApplicationArea = Basic;
        }
        modify(Column1)
        {
            ApplicationArea = Basic;
        }
        modify(Column2)
        {
            ApplicationArea = Basic;
        }
        modify(Column3)
        {
            ApplicationArea = Basic;
        }
        modify(Column4)
        {
            ApplicationArea = Basic;
        }
        modify(Column5)
        {
            ApplicationArea = Basic;
        }
        modify(Column6)
        {
            ApplicationArea = Basic;
        }
        modify(Column7)
        {
            ApplicationArea = Basic;
        }
        modify(Column8)
        {
            ApplicationArea = Basic;
        }
        modify(Column9)
        {
            ApplicationArea = Basic;
        }
        modify(Column10)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "SelectedCompany(Control 24).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            UpdateCompany;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            Company.Name := SelectedCompany;
            IF SelectedCompany <> '' THEN BEGIN
              Company.FIND('=<>');
              SelectedCompany := Company.Name;
            END;
            CurrPage.UPDATE(FALSE);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "SelectedCompany(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowDomainName(Control 26)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Role ID"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Role ID"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (CaptionML) on ""App ID"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""App ID"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""App Name"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AllUsersHavePermission(Control 22)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control27(Control 27)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control30(Control 30)".

    }
    actions
    {
        // modify(Permissions)
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (RunObject) on "Permissions(Action 6)".


        //     //Unsupported feature: Property Insertion (RunPageLink) on "Permissions(Action 6)".

        //     Enabled = PermissionEditable;
        // }
        modify(CopyPermissionSet)
        {
            ApplicationArea = Basic;
            Enabled = true;
        }
        modify(AllColumnsLeft)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnLeft)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnRight)
        {
            ApplicationArea = Basic;
        }
        modify(AllColumnsRight)
        {
            ApplicationArea = Basic;
        }
        modify(Permissions)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Permissions(Action 6)".



        //Unsupported feature: Code Insertion (VariableCollection) on "CopyPermissionSet(Action 8).OnAction".

        //trigger (Variable: PermissionSet)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on "CopyPermissionSet(Action 8).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            AggregatePermissionSet.SETRANGE(Scope,Scope);
            AggregatePermissionSet.SETRANGE("App ID","App ID");
            AggregatePermissionSet.SETRANGE("Role ID","Role ID");

            REPORT.RUNMODAL(REPORT::"Copy Permission Set",TRUE,TRUE,AggregatePermissionSet);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            PermissionSet.SETRANGE("Role ID","Role ID");
            CopyPermissionSet.SETTABLEVIEW(PermissionSet);
            CopyPermissionSet.RUNMODAL;

            IF GET(Scope::System,"App ID",CopyPermissionSet.GetRoleId) THEN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CopyPermissionSet(Action 8)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "CopyPermissionSet(Action 8)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "CopyPermissionSet(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AllColumnsLeft(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ColumnLeft(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ColumnRight(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AllColumnsRight(Action 25)".

    }

    var
        PermissionSet: Record "Aggregate Permission Set";
        CopyPermissionSet: Report "Copy Permission Set";

    var
        PermissionEditable: Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        FindUsers;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        FindUsers;
        PermissionEditable := ISNULLGUID("App ID");
        */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SelectedCompany := COMPANYNAME;
        UpdateCompany;
        HideExternalUsers(User);
        NoOfRecords := User.COUNT;
        PermissionPagesMgt.Init(NoOfRecords,ARRAYLEN(UserNameCode));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        NoOfRecords := User.COUNT;
        PermissionPagesMgt.Init(NoOfRecords,ARRAYLEN(UserNameCode));
        */
    //end;


    //Unsupported feature: Code Modification on "FindUsers(PROCEDURE 5)".

    //procedure FindUsers();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEAR(UserNameCode);
        CLEAR(UserHasPermissionSet);
        User.SETCURRENTKEY("User Name");
        AllUsersHavePermission := TRUE;
        HideExternalUsers(User);
        IF User.FINDSET THEN
          REPEAT
            i += 1;
        #9..20
              IF AllUsersHavePermission THEN
                AllUsersHavePermission := UserHasPermission(Rec,User);
          UNTIL (User.NEXT = 0) OR (PermissionPagesMgt.IsPastColumnRange(i) AND NOT AllUsersHavePermission);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        #6..23
        */
    //end;


    //Unsupported feature: Code Modification on "SetColumnPermission(PROCEDURE 1)".

    //procedure SetColumnPermission();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ColumnNo > 0 THEN BEGIN
          SetUserPermission(UserSecurityIDArr[ColumnNo],UserHasPermission);
          AllUsersHavePermission := AllUsersHavePermission AND UserHasPermission;
        END ELSE BEGIN
          HideExternalUsers(User);
          IF User.FINDSET THEN
            REPEAT
              SetUserPermission(User."User Security ID",UserHasPermission);
            UNTIL User.NEXT = 0;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        END ELSE
        #6..9
        */
    //end;
}
