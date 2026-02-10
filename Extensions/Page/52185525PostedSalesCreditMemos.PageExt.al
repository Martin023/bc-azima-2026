#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185525 pageextension52185525 extends "Posted Sales Credit Memos"
{

    //Unsupported feature: Property Modification (PromotedActionCategoriesML) on ""Posted Sales Credit Memos"(Page 144)".

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

            //Unsupported feature: Property Insertion (Visible) on ""Location Code"(Control 91)".

        }
        modify("No. Printed")
        {
            ApplicationArea = Basic;
        }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Doc. Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document Exchange Status")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Modification (Visible) on "Control1905767507(Control 1905767507)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Customer No."(Control 4)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Sell-to Customer Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Customer Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 37)".

        modify("Due Date")
        {
            Visible = false;
        }

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
        PAGE.RUNMODAL(PAGE::"Posted Sales Credit Memo",Rec)
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
        PAGE.RUNMODAL(PAGE::"Posted Sales Credit Memo",Rec)
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Including VAT"(Control 15)".

        modify("Remaining Amount")
        {
            Visible = false;
        }
        modify(Paid)
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Post Code"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Country/Region Code"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Contact"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Customer No."(Control 127)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Name"(Control 125)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Post Code"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Country/Region Code"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Contact"(Control 115)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 111)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Name"(Control 109)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Post Code"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Country/Region Code"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Contact"(Control 99)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 97)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 89)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 87)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 91)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. Printed"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 1102601003)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Doc. Type"(Control 1102601005)".



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


        //Unsupported feature: Property Deletion (ApplicationArea) on "IncomingDocAttachFactBox(Control 7)".


        //Unsupported feature: Property Deletion (Visible) on "IncomingDocAttachFactBox(Control 7)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("&Credit Memo")
        {
            Caption = '&Cr. Memo';

            //Unsupported feature: Property Modification (Name) on ""&Credit Memo"(Action 19)".

        }
        modify(Card)
        {
            ApplicationArea = Basic;
        }
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
        modify("&Navigate")
        {

            //Unsupported feature: Property Modification (Level) on ""&Navigate"(Action 25)".

            ApplicationArea = Basic;
        }
        modify(SendCustom)
        {

            //Unsupported feature: Property Modification (Level) on "SendCustom(Action 5)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "SendCustom(Action 5)".

        }
        modify("&Print")
        {

            //Unsupported feature: Property Modification (Level) on ""&Print"(Action 20)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Print"(Action 20)".

        }
        modify("Send by &Email")
        {

            //Unsupported feature: Property Modification (Level) on ""Send by &Email"(Action 3)".

            Caption = '&Email';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Send by &Email"(Action 3)".

        }
        modify(ActivityLog)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1102601000)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IncomingDoc(Action 10)".

        modify(Customer)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 25)".


        //Unsupported feature: Property Deletion (Visible) on ""&Navigate"(Action 25)".


        //Unsupported feature: Property Deletion (Scope) on ""&Navigate"(Action 25)".

        modify(Cancel)
        {
            Visible = false;
        }
        modify(CancelCrMemo)
        {
            Visible = false;
        }
        modify(ShowInvoice)
        {
            Visible = false;
        }
        modify(Send)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "SendCustom(Action 5)".


        //Unsupported feature: Property Deletion (Scope) on "SendCustom(Action 5)".



        //Unsupported feature: Code Modification on ""&Print"(Action 20).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SalesCrMemoHeader := Rec;
        CurrPage.SETSELECTIONFILTER(SalesCrMemoHeader);
        OnBeforePrintRecords(SalesCrMemoHeader);
        SalesCrMemoHeader.PrintRecords(TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SalesCrMemoHeader := Rec;
        CurrPage.SETSELECTIONFILTER(SalesCrMemoHeader);
        SalesCrMemoHeader.PrintRecords(TRUE);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 20)".


        //Unsupported feature: Property Deletion (Promoted) on ""&Print"(Action 20)".


        //Unsupported feature: Property Deletion (Visible) on ""&Print"(Action 20)".


        //Unsupported feature: Property Deletion (Scope) on ""&Print"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Send by &Email"(Action 3)".


        //Unsupported feature: Property Deletion (Scope) on ""Send by &Email"(Action 3)".



        //Unsupported feature: Code Insertion (VariableCollection) on "ActivityLog(Action 9).OnAction".

        //trigger (Variable: ActivityLog)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "ActivityLog(Action 9).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowActivityLog;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ActivityLog.ShowEntries(RECORDID);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ActivityLog(Action 9)".

        addfirst(navigation)
        {
        }
        //moveafter("&Credit Memo")
        //moveafter(ActionContainer1900000004;SendCustom)
    }

    var
        ActivityLog: Record "Activity Log";


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DocExchStatusStyle := GetDocExchStatusStyle;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
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
    IF HasFilters THEN
      IF FINDFIRST THEN;
    IsOfficeAddin := OfficeMgt.IsAvailable;
    IsFoundationEnabled := ApplicationAreaMgmtFacade.IsFoundationEnabled;
    SalesCrMemoHeader.COPYFILTERS(Rec);
    SalesCrMemoHeader.SETFILTER("Document Exchange Status",'<>%1',"Document Exchange Status"::"Not Sent");
    DocExchStatusVisible := NOT SalesCrMemoHeader.ISEMPTY;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetSecurityFilterOnRespCenter;
    */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (SourceTableView).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (QueryCategory).

}

