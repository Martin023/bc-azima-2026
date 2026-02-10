#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186418 pageextension52186418 extends "CRM Account List" 
{
    Caption = 'Microsoft Dynamics CRM Accounts';
    layout
    {
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Address1_PrimaryContactName")
        {
            ApplicationArea = Basic;
        }
        modify("Address1_Line1")
        {
            ApplicationArea = Basic;
        }
        modify("Address1_Line2")
        {
            ApplicationArea = Basic;
        }
        modify("Address1_PostalCode")
        {
            ApplicationArea = Basic;
        }
        modify("Address1_City")
        {
            ApplicationArea = Basic;
        }
        modify("Address1_Country")
        {
            ApplicationArea = Basic;
        }
        modify(Coupled)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address1_PrimaryContactName"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address1_Line1"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address1_Line2"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address1_PostalCode"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address1_City"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address1_Country"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Coupled(Control 3)".

    }
    actions
    {
        modify(CreateFromCRM)
        {
            Caption = 'Create Customer in Dynamics NAV';
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on "CreateFromCRM(Action 21)".

        }

        //Unsupported feature: Code Modification on "CreateFromCRM(Action 21).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(CRMAccount);
            CRMIntegrationManagement.CreateNewRecordsFromCRM(CRMAccount);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(CRMAccount);
            CRMAccount.NEXT;

            IF CRMAccount.COUNT = 1 THEN
              CRMIntegrationManagement.CreateNewRecordFromCRM(CRMAccount.AccountId,DATABASE::Customer)
            ELSE BEGIN
              CRMAccountRecordRef.GETTABLE(CRMAccount);
              CRMIntegrationManagement.CreateNewRecordsFromCRM(CRMAccountRecordRef);
            END
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CreateFromCRM(Action 21)".

    }

    var
        CRMAccountRecordRef: RecordRef;

    var
        AllowCreateFromCRM: Boolean;

    //Unsupported feature: Property Deletion (Attributes) on "SetCurrentlyCoupledCRMAccount(PROCEDURE 2)".


    procedure SetAllowCreateFromCRM(Allow: Boolean)
    begin
        AllowCreateFromCRM := Allow;
    end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
