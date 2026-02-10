#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186716 pageextension52186716 extends "Service Contract Quote"
{
    layout
    {
        modify("Contract No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Contact No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {

            //Unsupported feature: Property Modification (Level) on "Name(Control 40)".

            ApplicationArea = Basic;
        }
        modify(Address)
        {

            //Unsupported feature: Property Modification (Level) on "Address(Control 10)".

            ApplicationArea = Basic;
        }
        modify("Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Address 2"(Control 19)".

            ApplicationArea = Basic;
        }
        modify(City)
        {

            //Unsupported feature: Property Modification (Level) on "City(Control 111)".

            ApplicationArea = Basic;
        }
        modify("Contact Name")
        {

            //Unsupported feature: Property Modification (Level) on ""Contact Name"(Control 42)".

            ApplicationArea = Basic;
        }
        modify("Phone No.")
        {
            ApplicationArea = Basic;
        }
        modify("E-Mail")
        {
            ApplicationArea = Basic;
        }
        modify("Contract Group Code")
        {
            ApplicationArea = Basic;
        }
        modify("Salesperson Code")
        {
            ApplicationArea = Basic;
        }
        modify("Quote Type")
        {
            ApplicationArea = Basic;
        }
        modify("Starting Date")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Responsibility Center")
        {
            ApplicationArea = Basic;
        }
        modify("Change Status")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Contact No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Name")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Name"(Control 84)".

            ApplicationArea = Basic;
        }
        modify("Bill-to Address")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Address"(Control 80)".

            ApplicationArea = Basic;
        }
        modify("Bill-to Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Address 2"(Control 79)".

            ApplicationArea = Basic;
        }
        modify("Bill-to City")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to City"(Control 87)".

            ApplicationArea = Basic;
        }
        // modify("Bill-to Post Code")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""Bill-to Post Code"(Control 26)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on ""Bill-to Post Code"(Control 26)".


        //     //Unsupported feature: Property Modification (Name) on ""Bill-to Post Code"(Control 26)".

        // }
        modify("Bill-to Contact")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Contact"(Control 105)".

            ApplicationArea = Basic;
        }
        modify("Your Reference")
        {
            ApplicationArea = Basic;
        }
        modify("Serv. Contract Acc. Gr. Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Terms Code")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Code")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Name")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Address")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Address 2")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to City")
        {
            ApplicationArea = Basic;
        }
        modify("Service Zone Code")
        {
            ApplicationArea = Basic;
        }
        modify("Service Period")
        {
            ApplicationArea = Basic;
        }
        modify("First Service Date")
        {
            ApplicationArea = Basic;
        }
        modify("Response Time (Hours)")
        {
            ApplicationArea = Basic;
        }
        modify("Service Order Type")
        {
            ApplicationArea = Basic;
        }
        modify("Annual Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Unbalanced Amounts")
        {
            ApplicationArea = Basic;
        }
        modify("Calcd. Annual Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Invoice Period")
        {
            ApplicationArea = Basic;
        }
        modify("Next Invoice Date")
        {
            ApplicationArea = Basic;
        }
        modify("Amount per Period")
        {
            ApplicationArea = Basic;
        }
        modify(NextInvoicePeriod)
        {
            ApplicationArea = Basic;
        }
        modify(Prepaid)
        {
            ApplicationArea = Basic;
        }
        modify("Automatic Credit Memos")
        {
            ApplicationArea = Basic;
        }
        modify("Invoice after Service")
        {
            ApplicationArea = Basic;
            Enabled = "Invoice after ServiceEnable";
        }
        modify("Combine Invoices")
        {
            ApplicationArea = Basic;
        }
        modify("Contract Lines on Invoice")
        {
            ApplicationArea = Basic;
        }
        modify("Price Update Period")
        {
            ApplicationArea = Basic;
        }
        modify("Next Price Update Date")
        {
            ApplicationArea = Basic;
        }
        modify("Price Inv. Increase Code")
        {
            ApplicationArea = Basic;
        }
        modify("Expiration Date")
        {
            ApplicationArea = Basic;
        }
        modify("Max. Labor Unit Price")
        {
            ApplicationArea = Basic;
        }
        modify("Accept Before")
        {
            ApplicationArea = Basic;
        }
        modify(Probability)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact No."(Control 21)".

        modify("Sell-to")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Address(Control 10)".


        //Unsupported feature: Property Deletion (QuickEntry) on "Address(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address 2"(Control 19)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Address 2"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "City(Control 111)".


        //Unsupported feature: Property Deletion (QuickEntry) on "City(Control 111)".

        modify(Control13)
        {
            Visible = false;
        }
        modify(County)
        {
            Visible = false;
        }
        modify("Post Code")
        {
            Visible = false;
        }
        modify("Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Name"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No."(Control 82)".


        //Unsupported feature: Property Deletion (ExtendedDatatype) on ""E-Mail"(Control 124)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E-Mail"(Control 124)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract Group Code"(Control 108)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 93)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quote Type"(Control 125)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Responsibility Center"(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Change Status"(Control 38)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "ServContractLines(Control 18)".


        //Unsupported feature: Property Deletion (PartType) on "ServContractLines(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Customer No."(Control 106)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Contact No."(Control 109)".

        modify(Control14)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Name"(Control 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Address"(Control 80)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Bill-to Address"(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Address 2"(Control 79)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Bill-to Address 2"(Control 79)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to City"(Control 87)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Bill-to City"(Control 87)".

        modify(Control23)
        {
            Visible = false;
        }
        modify("Bill-to County")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Post Code"(Control 26)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Bill-to Post Code"(Control 26)".

        modify("Bill-to Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Contact"(Control 105)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Your Reference"(Control 104)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serv. Contract Acc. Gr. Code"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Terms Code"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 22)".

        modify(Control25)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Name"(Control 127)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Address"(Control 129)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Address 2"(Control 131)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to City"(Control 112)".

        modify(Control33)
        {
            Visible = false;
        }
        modify("Ship-to County")
        {
            Visible = false;
        }
        // modify("Ship-to Post Code")
        // {
        //     Visible = false;
        // }
        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Zone Code"(Control 159)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Period"(Control 144)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""First Service Date"(Control 143)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Response Time (Hours)"(Control 142)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Order Type"(Control 139)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Annual Amount"(Control 90)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Unbalanced Amounts"(Control 154)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calcd. Annual Amount"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Period"(Control 95)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Next Invoice Date"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount per Period"(Control 99)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NextInvoicePeriod(Control 147)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Prepaid(Control 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Automatic Credit Memos"(Control 138)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice after Service"(Control 133)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Combine Invoices"(Control 145)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract Lines on Invoice"(Control 92)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Price Update Period"(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Next Price Update Date"(Control 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Price Inv. Increase Code"(Control 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expiration Date"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Max. Labor Unit Price"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Accept Before"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Probability(Control 46)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter("Bill-to Contact No.")
        {
            // field("Bill-to Post Code"; Rec."Bill-to Post Code")
            // {
            //     ApplicationArea = Basic;
            //     DrillDown = false;
            // }
        }
        addafter("Ship-to Address 2")
        {
            // field("Ship-to Post Code";Rec."Ship-to Post Code")
            // {
            //     ApplicationArea = Basic;
            //     DrillDown = false;
            //     Importance = Promoted;
            // }
        }
        // moveafter("Address 2";"Bill-to Post Code")
    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("Service Dis&counts")
        {
            ApplicationArea = Basic;
        }
        modify("Service &Hours")
        {
            ApplicationArea = Basic;
        }
        modify("&Filed Contract Quotes")
        {
            ApplicationArea = Basic;
        }
        modify("&Select Contract Quote Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Copy &Document...")
        {
            ApplicationArea = Basic;
        }
        modify("&File Contract Quote")
        {
            ApplicationArea = Basic;
        }
        modify("Update &Discount % on All Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Update with Contract &Template")
        {
            ApplicationArea = Basic;
        }
        modify("Loc&k")
        {
            ApplicationArea = Basic;
        }
        modify("&Open")
        {
            ApplicationArea = Basic;
        }
        modify("&Make Contract")
        {
            ApplicationArea = Basic;
        }
        modify("&Print")
        {
            ApplicationArea = Basic;
        }
        modify("Service Quote Details")
        {
            ApplicationArea = Basic;
        }
        modify("Contract Quotes to be Signed")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 71)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Dis&counts"(Action 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service &Hours"(Action 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Filed Contract Quotes"(Action 98)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Select Contract Quote Lines"(Action 103)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy &Document..."(Action 36)".



        //Unsupported feature: Code Modification on ""&File Contract Quote"(Action 122).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ConfirmManagement.ConfirmProcess(Text001,TRUE) THEN
          FiledServContract.FileContract(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF CONFIRM(Text001) THEN
          FiledServContract.FileContract(Rec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""&File Contract Quote"(Action 122)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update &Discount % on All Lines"(Action 77)".



        //Unsupported feature: Code Modification on ""Update with Contract &Template"(Action 15).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT ConfirmManagement.ConfirmProcess(Text002,TRUE) THEN
          EXIT;
        CurrPage.UPDATE(TRUE);
        CLEAR(ServContrQuoteTmplUpd);
        ServContrQuoteTmplUpd.RUN(Rec);
        CurrPage.UPDATE(TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF NOT CONFIRM(Text002,TRUE) THEN
        #2..6
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Update with Contract &Template"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Loc&k"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Open"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Make Contract"(Action 86)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 141)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Quote Details"(Action 1905622906)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract Quotes to be Signed"(Action 1905017306)".

        addafter("Service &Hours")
        {
            separator(Action97)
            {
            }
        }
        addafter("Copy &Document...")
        {
            separator(Action102)
            {
            }
        }
    }

    var

        "Invoice after ServiceEnable": Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InvoiceAfterServiceEnable := TRUE;
    PrepaidEnable := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Invoice after ServiceEnable" := TRUE;
    PrepaidEnable := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF UserMgt.GetServiceFilter <> '' THEN BEGIN
      FILTERGROUP(2);
      SETRANGE("Responsibility Center",UserMgt.GetServiceFilter);
      FILTERGROUP(0);
    END;

    ActivateFields;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    */
    //end;


    //Unsupported feature: Code Modification on "ActivateFields(PROCEDURE 2)".

    //procedure ActivateFields();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PrepaidEnable := (NOT "Invoice after Service" OR Prepaid);
    InvoiceAfterServiceEnable := (NOT Prepaid OR "Invoice after Service");
    IsSellToCountyVisible := FormatAddress.UseCounty("Country/Region Code");
    IsShipToCountyVisible := FormatAddress.UseCounty("Ship-to Country/Region Code");
    IsBillToCountyVisible := FormatAddress.UseCounty("Bill-to Country/Region Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    PrepaidEnable := (NOT "Invoice after Service" OR Prepaid);
    "Invoice after ServiceEnable" := (NOT Prepaid OR "Invoice after Service");
    */
    //end;


    //Unsupported feature: Code Modification on "GetServItemLine(PROCEDURE 5)".

    //procedure GetServItemLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CLEAR(ContractLineSelection);
    ContractLineSelection.SetSelection("Customer No.","Ship-to Code","Contract Type","Contract No.");
    ContractLineSelection.RUNMODAL;
    CurrPage.UPDATE(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CLEAR(ContractLineSelection);
    ContractLineSelection.SetSelection("Customer No.","Ship-to Code","Contract Type","Contract No.",FALSE);
    ContractLineSelection.RUNMODAL;
    CurrPage.UPDATE(FALSE);
    */
    //end;
}
