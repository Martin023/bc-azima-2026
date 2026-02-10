#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185475 pageextension52185475 extends "Resource Card"
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Importance) on ""No."(Control 2)".

        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("Base Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify("Search Name")
        {
            ApplicationArea = Basic;
        }
        modify("Resource Group No.")
        {
            ApplicationArea = Basic;
        }
        modify(Blocked)
        {
            ApplicationArea = Basic;
        }
        modify("Last Date Modified")
        {
            ApplicationArea = Basic;
        }
        modify("Use Time Sheet")
        {
            ApplicationArea = Basic;
        }
        modify("Time Sheet Owner User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Time Sheet Approver User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Direct Unit Cost")
        {
            ApplicationArea = Basic;
        }
        modify("Indirect Cost %")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Cost")
        {
            ApplicationArea = Basic;
        }
        modify("Price/Profit Calculation")
        {
            ApplicationArea = Basic;
        }
        modify("Profit %")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Price")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Default Deferral Template Code")
        {
            ApplicationArea = Basic;
        }
        modify("Automatic Ext. Texts")
        {
            ApplicationArea = Basic;
        }
        modify("IC Partner Purch. G/L Acc. No.")
        {
            ApplicationArea = Basic;
        }
        modify("Job Title")
        {
            ApplicationArea = Basic;
        }
        modify(Address)
        {
            ApplicationArea = Basic;
        }
        modify("Address 2")
        {
            ApplicationArea = Basic;
        }
        modify(City)
        {
            ApplicationArea = Basic;
        }
        modify("Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Social Security No.")
        {
            ApplicationArea = Basic;
        }
        modify(Education)
        {
            ApplicationArea = Basic;
        }
        modify("Contract Class")
        {
            ApplicationArea = Basic;
        }
        modify("Employment Date")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (Visible) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Base Unit of Measure"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Search Name"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Group No."(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Blocked(Control 24)".

        modify("Privacy Blocked")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Date Modified"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Use Time Sheet"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Time Sheet Owner User ID"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Time Sheet Approver User ID"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Unit Cost"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Indirect Cost %"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Price/Profit Calculation"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Profit %"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Price"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Prod. Posting Group"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Prod. Posting Group"(Control 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Default Deferral Template Code"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Automatic Ext. Texts"(Control 71)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Purch. G/L Acc. No."(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Title"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Address(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address 2"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "City(Control 10)".

        modify(Control47)
        {
            Visible = false;
        }
        modify(County)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Code"(Control 11)".

        modify("Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Social Security No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Education(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract Class"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Employment Date"(Control 18)".

        modify(Control39)
        {
            Visible = false;
        }
        modify("Attached Documents")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1906609707(Control 1906609707)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        moveafter("Address 2"; "Post Code")
    }
    actions
    {
        modify(Statistics)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 58)".

        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("&Picture")
        {
            ApplicationArea = Basic;
        }
        modify("E&xtended Texts")
        {
            ApplicationArea = Basic;
        }
        modify("Units of Measure")
        {
            ApplicationArea = Basic;
        }
        modify("S&kills")
        {
            ApplicationArea = Basic;
        }
        modify("Resource L&ocations")
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("Online Map")
        {
            ApplicationArea = Basic;
        }
        modify(ActionGroupCRM)
        {
            Caption = 'Dynamics CRM';
        }
        modify(CRMGoToProduct)
        {
            ToolTip = 'Open the coupled Microsoft Dynamics CRM product.';
            ApplicationArea = Basic;
        }
        modify(CRMSynchronizeNow)
        {
            Caption = 'Synchronize Now';
            ToolTip = 'Send updated data to Microsoft Dynamics CRM.';
            ApplicationArea = Basic;
        }
        modify(Coupling)
        {
            ToolTip = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.';
        }
        modify(ManageCRMCoupling)
        {
            ToolTip = 'Create or modify the coupling to a Microsoft Dynamics CRM product.';
            ApplicationArea = Basic;
        }
        modify(DeleteCRMCoupling)
        {
            ToolTip = 'Delete the coupling to a Microsoft Dynamics CRM product.';
            ApplicationArea = Basic;
        }
        modify(Costs)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Costs(Action 61)".

        }
        modify(Prices)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Prices(Action 62)".

        }
        modify("Resource &Capacity")
        {
            ApplicationArea = Basic;
        }
        modify("Resource &Allocated per Job")
        {
            ApplicationArea = Basic;
        }
        modify("Resource Allocated per Service &Order")
        {
            ApplicationArea = Basic;
        }
        modify("Resource A&vailability")
        {
            ApplicationArea = Basic;
        }
        modify("Service &Zones")
        {
            ApplicationArea = Basic;
        }
        modify("Ledger E&ntries")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunPageView) on ""Ledger E&ntries"(Action 60)".


            //Unsupported feature: Property Modification (PromotedCategory) on ""Ledger E&ntries"(Action 60)".

        }
        modify("Resource Statistics")
        {
            ApplicationArea = Basic;
        }
        modify("Resource Usage")
        {
            ApplicationArea = Basic;
        }
        // modify("Resource - Cost Breakdown")
        // {
        //     ApplicationArea = Basic;
        // }
        modify(CreateTimeSheets)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 58)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Statistics(Action 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 84)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 84)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Dimensions(Action 84)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Picture"(Action 73)".


        //Unsupported feature: Property Deletion (Promoted) on ""&Picture"(Action 73)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""&Picture"(Action 73)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xtended Texts"(Action 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Units of Measure"(Action 77)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""S&kills"(Action 36)".


        //Unsupported feature: Property Deletion (Promoted) on ""S&kills"(Action 36)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""S&kills"(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource L&ocations"(Action 37)".


        //Unsupported feature: Property Deletion (Promoted) on ""Resource L&ocations"(Action 37)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Resource L&ocations"(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 59)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 59)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 59)".

        modify(Attachments)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Online Map"(Action 80)".


        //Unsupported feature: Code Modification on "ManageCRMCoupling(Action 25).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CRMIntegrationManagement.DefineCoupling(RECORDID);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CRMIntegrationManagement.CreateOrUpdateCoupling(RECORDID);
        */
        //end;
        modify(ShowLog)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Costs(Action 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Prices(Action 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource &Capacity"(Action 63)".


        //Unsupported feature: Property Deletion (Promoted) on ""Resource &Capacity"(Action 63)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Resource &Capacity"(Action 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource &Allocated per Job"(Action 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Allocated per Service &Order"(Action 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource A&vailability"(Action 66)".


        //Unsupported feature: Property Deletion (Promoted) on ""Resource A&vailability"(Action 66)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Resource A&vailability"(Action 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service &Zones"(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 60)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on ""Ledger E&ntries"(Action 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Statistics"(Action 1901205806)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Usage"(Action 1907688806)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource - Cost Breakdown"(Action 1907042906)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CreateTimeSheets(Action 9)".


        //Unsupported feature: Property Deletion (Promoted) on "CreateTimeSheets(Action 9)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "CreateTimeSheets(Action 9)".

    }

    var
        MapMgt: Codeunit "Online Map Management";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";

    var

        MapPointVisible: Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF CRMIntegrationEnabled THEN BEGIN
      CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
      IF "No." <> xRec."No." THEN
        CRMIntegrationManagement.SendResultNotification(Rec);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
    */
    //end;


    //Unsupported feature: Code Insertion on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //begin
    /*
    MapPointVisible := TRUE;
    */
    //end;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnOpenPage".

    //trigger (Variable: MapMgt)()
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    SetNoFieldVisible;
    IsCountyVisible := FormatAddress.UseCounty("Country/Region Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT MapMgt.TestSetup THEN
      MapPointVisible := FALSE;

    CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    */
    //end;

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
