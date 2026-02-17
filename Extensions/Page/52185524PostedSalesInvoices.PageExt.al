#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185524 pageextension52185524 extends "Posted Sales Invoices"
{

    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Customer Name")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("Amount Including VAT")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Contact")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Name")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Contact")
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
        modify("Ship-to Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Contact")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Salesperson Code")
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
        modify("Location Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Location Code"(Control 93)".

        }
        modify("No. Printed")
        {
            ApplicationArea = Basic;
        }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Terms Code")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Discount %")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Method Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Exchange Status")
        {
            ApplicationArea = Basic;
        }
        // modify("<Document Exchange Status>")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""<Document Exchange Status>"(Control 18)".

        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Insertion (Visible) on "Control1905767507(Control 1905767507)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".

        modify("Order No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Sell-to Customer No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Customer No."(Control 4)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Sell-to Customer Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Customer Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 37)".

        // modify("Due Date")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Code Modification on "Amount(Control 13).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DoDrillDown;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SETRANGE("No.");
        PAGE.RUNMODAL(PAGE::"Posted Sales Invoice",Rec)
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 13)".



        //Unsupported feature: Code Modification on ""Amount Including VAT"(Control 15).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DoDrillDown;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SETRANGE("No.");
        PAGE.RUNMODAL(PAGE::"Posted Sales Invoice",Rec)
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Including VAT"(Control 15)".

        modify("Remaining Amount")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Post Code"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Country/Region Code"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Contact"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Customer No."(Control 147)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Name"(Control 145)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Post Code"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Country/Region Code"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Contact"(Control 129)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 125)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Name"(Control 123)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Post Code"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Country/Region Code"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Contact"(Control 113)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 109)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 69)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 91)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 89)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 93)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. Printed"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 1102601001)".

        modify("External Document No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Terms Code"(Control 1102601003)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Discount %"(Control 1102601009)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Method Code"(Control 1102601011)".

        modify("Shipping Agent Code")
        {
            Visible = false;
        }
        modify(Closed)
        {
            Visible = false;
        }
        modify(Cancelled)
        {
            Visible = false;
        }
        modify(Corrective)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 1102601013)".



        //Unsupported feature: Code Modification on ""Document Exchange Status"(Control 11).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DocExchServDocStatus.DocExchStatusDrillDown(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        DocExchStatusDrillDown;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Exchange Status"(Control 11)".


        //Unsupported feature: Property Deletion (Visible) on ""Document Exchange Status"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""<Document Exchange Status>"(Control 18)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "IncomingDocAttachFactBox(Control 5)".


        //Unsupported feature: Property Deletion (Visible) on "IncomingDocAttachFactBox(Control 5)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter("Payment Terms Code")
        {
            // field("Due Date";Rec."Due Date")
            // {
            //     ApplicationArea = Basic;
            //     Visible = false;
            // }
        }

        addafter(Corrective)
        {
            field("Invoice Start Date"; Rec."Invoice Start Date")
            {

            }
            field("Invoice End Date"; Rec."Invoice End Date")
            {

            }
            field("Period Type"; Rec."Period Type")
            {

            }
            field(Tenor; Rec.Tenor)
            {

            }
            field("Frequency Period"; Rec."Frequency Period")
            {

            }
            field(Invoiced; Rec.Invoiced)
            {

            }
        }
    }
    actions
    {
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (PromotedIsBig) on ""Co&mments"(Action 32)".

        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(IncomingDoc)
        {
            ApplicationArea = Basic;
        }
        modify(ActionGroupCRM)
        {
            Caption = 'Dynamics CRM';
        }
        modify(CRMGotoInvoice)
        {
            ToolTip = 'Open the coupled Microsoft Dynamics CRM account.';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Image) on "CRMGotoInvoice(Action 14)".

        }
        modify(CreateInCRM)
        {
            Caption = 'Create Invoice in Dynamics CRM';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Image) on "CreateInCRM(Action 12)".

        }
        modify(SendCustom)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "SendCustom(Action 7)".

        }
        modify(Print)
        {

            //Unsupported feature: Property Modification (Name) on "Print(Action 20)".

            ApplicationArea = Basic;
            Visible = false;

            //Unsupported feature: Property Modification (PromotedCategory) on "Print(Action 20)".

        }
        // addafter("Update Document")
        // {
        //     action("Customer Report")
        //     {
        //         Caption = 'Print Out';
        //         Image = Report2;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         Visible = true;
        //         trigger OnAction()
        //         var
        //             Customer: Record Customer;
        //         begin
        //             Customer.SetRange("No.", Rec."Sell-to Customer No.");
        //             Report.Run(Report::"Sales Invoice Printout", true, false, rec);
        //         end;
        //     }
        // }
        modify(Email)
        {

            //Unsupported feature: Property Modification (Name) on "Email(Action 3)".

            Caption = '&Email';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Email(Action 3)".

        }
        modify(Navigate)
        {

            //Unsupported feature: Property Modification (Name) on "Navigate(Action 25)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Navigate(Action 25)".


            //Unsupported feature: Property Insertion (PromotedIsBig) on "Navigate(Action 25)".

        }
        modify(ActivityLog)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1102601000)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IncomingDoc(Action 9)".



        //Unsupported feature: Code Modification on "CreateInCRM(Action 12).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(SalesInvoiceHeader);
        CRMIntegrationManagement.CreateNewRecordsInCRM(SalesInvoiceHeader);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(SalesInvoiceHeader);
        SalesInvoiceHeader.NEXT;

        IF SalesInvoiceHeader.COUNT = 1 THEN
          CRMIntegrationManagement.CreateNewRecordInCRM(RECORDID,FALSE)
        ELSE BEGIN
          SalesInvoiceHeaderRecordRef.GETTABLE(SalesInvoiceHeader);
          CRMIntegrationManagement.CreateNewRecordsInCRM(SalesInvoiceHeaderRecordRef);
        END;

        REPEAT
          IF CRMCouplingManagement.IsRecordCoupledToCRM(SalesInvoiceHeader.RECORDID) THEN BEGIN
            SalesInvoiceHeader.VALIDATE("Coupled to CRM",TRUE);
            SalesInvoiceHeader.MODIFY;
          END;
        UNTIL SalesInvoiceHeader.NEXT = 0;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CreateInCRM(Action 12)".

        modify(ShowLog)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "SendCustom(Action 7)".


        //Unsupported feature: Property Deletion (Enabled) on "SendCustom(Action 7)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "SendCustom(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Print(Action 20)".


        //Unsupported feature: Property Deletion (Promoted) on "Print(Action 20)".


        //Unsupported feature: Property Deletion (Visible) on "Print(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Email(Action 3)".


        //Unsupported feature: Property Deletion (Promoted) on "Email(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Navigate(Action 25)".


        //Unsupported feature: Property Deletion (Visible) on "Navigate(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ActivityLog(Action 10)".

        modify(Correct)
        {
            Visible = false;
        }
        modify(CorrectInvoice)
        {
            Visible = false;
        }
        modify(CancelInvoice)
        {
            Visible = false;
        }
        modify(CreateCreditMemo)
        {
            Visible = false;
        }
        modify(ShowCreditMemo)
        {
            Visible = false;
        }
        modify(Invoice)
        {
            Visible = false;
        }
        modify(Customer)
        {
            Visible = false;
        }
        addfirst("&Invoice")
        {
            action(Card)
            {
                ApplicationArea = Basic;
                Caption = 'Card';
                Image = EditLines;
                ShortCutKey = 'Shift+F7';

                trigger OnAction()
                begin
                    Page.Run(Page::"Posted Sales Invoice", Rec)
                end;
            }
        }
    }

    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
        SalesInvoiceHeaderRecordRef: RecordRef;


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    HasPostedSalesInvoices := TRUE;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    CRMIsCoupledToRecord := CRMIntegrationEnabled;
    IF CRMIsCoupledToRecord THEN
      CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DocExchStatusStyle := GetDocExchStatusStyle;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
    */
    //end;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF DocExchStatusVisible THEN
      DocExchStatusStyle := GetDocExchStatusStyle;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DocExchStatusStyle := GetDocExchStatusStyle;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    HasFilters := GETFILTERS <> '';
    SetSecurityFilterOnRespCenter;
    CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    IF HasFilters THEN
      IF FINDFIRST THEN;
    IsOfficeAddin := OfficeMgt.IsAvailable;
    IsFoundationEnabled := ApplicationAreaMgmtFacade.IsFoundationEnabled;
    SalesInvoiceHeader.COPYFILTERS(Rec);
    SalesInvoiceHeader.SETFILTER("Document Exchange Status",'<>%1',"Document Exchange Status"::"Not Sent");
    DocExchStatusVisible := NOT SalesInvoiceHeader.ISEMPTY;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetSecurityFilterOnRespCenter;
    CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (SourceTableView).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (QueryCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


    //Unsupported feature: Property Deletion (RefreshOnActivate).

}
