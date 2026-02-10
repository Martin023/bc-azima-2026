#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187201 pageextension52187201 extends "User Subform" 
{
    layout
    {
        modify(PermissionSet)
        {

            //Unsupported feature: Property Modification (Name) on "PermissionSet(Control 3)".

            ApplicationArea = Basic;
        }
        modify(Description)
        {

            //Unsupported feature: Property Modification (Name) on "Description(Control 4)".

            ApplicationArea = Basic;
        }
        modify(Company)
        {

            //Unsupported feature: Property Modification (Name) on "Company(Control 5)".

            ApplicationArea = Basic;
        }
        modify(ExtensionName)
        {

            //Unsupported feature: Property Modification (Name) on "ExtensionName(Control 6)".

            Caption = 'NAV App Name';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "PermissionSet(Control 3).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            PermissionSetLookup.LOOKUPMODE := TRUE;
            IF PermissionSetLookup.RUNMODAL = ACTION::LookupOK THEN BEGIN
              PermissionSetLookup.GETRECORD(PermissionSetLookupRecord);
              Scope := PermissionSetLookupRecord.Scope;
              "App ID" := PermissionSetLookupRecord."App ID";
              "Role ID" := PermissionSetLookupRecord."Role ID";
              CALCFIELDS("App Name","Role Name");
              SkipValidation := TRUE;
              PermissionScope := FORMAT(PermissionSetLookupRecord.Scope);
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..8
            END;
            */
        //end;


        //Unsupported feature: Code Modification on "PermissionSet(Control 3).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            // If the user used the lookup, skip validation
            IF SkipValidation THEN BEGIN
              SkipValidation := FALSE;
            #4..12

            Scope := AggregatePermissionSet.Scope;
            "App ID" := AggregatePermissionSet."App ID";
            PermissionScope := FORMAT(AggregatePermissionSet.Scope);

            CALCFIELDS("App Name","Role Name");

            SkipValidation := FALSE; // re-enable validation
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..15
            #17..20
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "PermissionSet(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Company(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ExtensionName(Control 6)".

        modify(PermissionScope)
        {
            Visible = false;
        }
    }
    actions
    {
        // modify(Permissions)
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (RunObject) on "Permissions(Action 9)".


        //     //Unsupported feature: Property Insertion (RunPageLink) on "Permissions(Action 9)".

        //     Enabled = PermissionEditable;
        // }
        // modify(Permissions)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Permissions(Action 9)".

    }

    var
        PermissionEditable: Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF User."User Name" <> '' THEN
          CurrPage.CAPTION := User."User Name";

        PermissionScope := FORMAT(Scope);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF User."User Name" <> '' THEN
          CurrPage.CAPTION := User."User Name";
        PermissionEditable := ISNULLGUID("App ID");
        */
    //end;


    //Unsupported feature: Code Modification on "OnDeleteRecord".

    //trigger OnDeleteRecord(): Boolean
    //>>>> ORIGINAL CODE:
    //begin
        /*
        UserGroupAccessControl.SETFILTER("User Group Code",'<>%1','');
        UserGroupAccessControl.SETRANGE("User Security ID","User Security ID");
        UserGroupAccessControl.SETRANGE("Role ID","Role ID");
        UserGroupAccessControl.SETRANGE("Company Name","Company Name");
        IF UserGroupAccessControl.FINDFIRST THEN
          ERROR(InUserGroupErr,UserGroupAccessControl."User Group Code");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
        PermissionEditable := ISNULLGUID("App ID");
        */
    //end;


    //Unsupported feature: Code Modification on "OnInsertRecord".

    //trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    //>>>> ORIGINAL CODE:
    //begin
        /*
        User.TESTFIELD("User Name");
        CALCFIELDS("App Name","Role Name");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        User.TESTFIELD("User Name");
        PermissionEditable := ISNULLGUID("App ID");
        CALCFIELDS("App Name","Role Name");
        */
    //end;


    //Unsupported feature: Code Modification on "OnModifyRecord".

    //trigger OnModifyRecord(): Boolean
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CALCFIELDS("App Name","Role Name");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        PermissionEditable := ISNULLGUID("App ID");
        CALCFIELDS("App Name","Role Name");
        */
    //end;


    //Unsupported feature: Code Modification on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF User.GET("User Security ID") THEN;
        CALCFIELDS("App Name","Role Name");
        PermissionScope := '';
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF User.GET("User Security ID") THEN;
        PermissionEditable := ISNULLGUID("App ID");
        CALCFIELDS("App Name","Role Name");
        */
    //end;
}
