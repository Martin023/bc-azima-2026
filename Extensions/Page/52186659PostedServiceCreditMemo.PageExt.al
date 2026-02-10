#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186659 pageextension52186659 extends "Posted Service Credit Memo" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {

            //Unsupported feature: Property Modification (Level) on "Name(Control 53)".

            ApplicationArea = Basic;
        }
        modify(Address)
        {

            //Unsupported feature: Property Modification (Level) on "Address(Control 55)".

            ApplicationArea = Basic;
        }
        modify("Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Address 2"(Control 57)".

            ApplicationArea = Basic;
        }
        modify(City)
        {

            //Unsupported feature: Property Modification (Level) on "City(Control 59)".

            ApplicationArea = Basic;
        }
        modify("Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Post Code"(Control 6)".

            ApplicationArea = Basic;
        }
        modify("Contact Name")
        {

            //Unsupported feature: Property Modification (Level) on ""Contact Name"(Control 61)".

            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Exchange Status")
        {

            //Unsupported feature: Property Modification (Level) on ""Document Exchange Status"(Control 3)".

            ApplicationArea = Basic;
        }
        modify("Pre-Assigned No.")
        {
            ApplicationArea = Basic;
        }
        modify("Salesperson Code")
        {
            ApplicationArea = Basic;
        }
        modify("Responsibility Center")
        {
            ApplicationArea = Basic;
        }
        modify("No. Printed")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Name")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Name"(Control 22)".

            ApplicationArea = Basic;
        }
        modify("Bill-to Address")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Address"(Control 24)".

            ApplicationArea = Basic;
        }
        modify("Bill-to Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Address 2"(Control 26)".

            ApplicationArea = Basic;
        }
        modify("Bill-to City")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to City"(Control 28)".

            ApplicationArea = Basic;
        }
        modify("Bill-to Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Post Code"(Control 70)".

            ApplicationArea = Basic;
        }
        modify("Bill-to Contact")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Contact"(Control 30)".

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
        modify("Ship-to Code")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Name")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Name"(Control 34)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Address")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Address"(Control 36)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Address 2"(Control 38)".

            ApplicationArea = Basic;
        }
        modify("Ship-to City")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to City"(Control 40)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Post Code"(Control 72)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Contact")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Contact"(Control 42)".

            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("EU 3-Party Trade")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 4)".

        modify("Sell-to")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Address(Control 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address 2"(Control 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on "City(Control 59)".

        modify(Control18)
        {
            Visible = false;
        }
        modify(County)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Code"(Control 6)".

        modify("Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Name"(Control 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 29)".

        modify(Control11)
        {
            Visible = false;
        }

        //Unsupported feature: Code Modification on ""Document Exchange Status"(Control 3).OnDrillDown".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Exchange Status"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pre-Assigned No."(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Responsibility Center"(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. Printed"(Control 14)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "ServCrMemoLines(Control 46)".


        //Unsupported feature: Property Deletion (PartType) on "ServCrMemoLines(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Customer No."(Control 20)".

        modify("Bill-to")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Name"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Name"(Control 22)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Address"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Address"(Control 24)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Address 2"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Address 2"(Control 26)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to City"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to City"(Control 28)".

        modify(Control25)
        {
            Visible = false;
        }
        modify("Bill-to County")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Post Code"(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Post Code"(Control 70)".

        modify("Bill-to Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Contact"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Contact"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 32)".

        modify("Ship-to")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Name"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Name"(Control 34)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Address"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Address"(Control 36)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Address 2"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Address 2"(Control 38)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to City"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to City"(Control 40)".

        modify(Control27)
        {
            Visible = false;
        }
        modify("Ship-to County")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Post Code"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Post Code"(Control 72)".

        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Contact"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Contact"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""EU 3-Party Trade"(Control 44)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        moveafter("Address 2";"Post Code")
        moveafter("Bill-to Address 2";"Bill-to Post Code")
        moveafter("Ship-to Address 2";"Ship-to Post Code")
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
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Service Document Lo&g")
        {
            ApplicationArea = Basic;
        }
        modify(SendCustom)
        {
            ApplicationArea = Basic;
        }
        modify("&Print")
        {
            ApplicationArea = Basic;
        }
        modify("&Navigate")
        {
            ApplicationArea = Basic;
        }
        modify(ActivityLog)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 77)".



        //Unsupported feature: Code Insertion (VariableCollection) on ""Service Document Lo&g"(Action 17).OnAction".

        //trigger (Variable: ServDocLog)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Service Document Lo&g"(Action 17).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TempServDocLog.RESET;
            TempServDocLog.DELETEALL;
            TempServDocLog.CopyServLog(TempServDocLog."Document Type"::"Credit Memo","Pre-Assigned No.");
            TempServDocLog.CopyServLog(TempServDocLog."Document Type"::"Credit Memo","No.");

            TempServDocLog.RESET;
            TempServDocLog.SETCURRENTKEY("Change Date","Change Time");
            TempServDocLog.ASCENDING(FALSE);

            PAGE.RUN(0,TempServDocLog);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TempServDocLog.RESET;
            TempServDocLog.DELETEALL;

            ServDocLog.RESET;
            ServDocLog.SETRANGE("Document Type",ServDocLog."Document Type"::"Credit Memo");
            ServDocLog.SETRANGE("Document No.","Pre-Assigned No.");
            IF ServDocLog.FINDSET THEN
              REPEAT
                TempServDocLog := ServDocLog;
                TempServDocLog.INSERT;
              UNTIL ServDocLog.NEXT = 0;

            ServDocLog.RESET;
            ServDocLog.SETRANGE("Document Type",ServDocLog."Document Type"::"Posted Credit Memo");
            ServDocLog.SETRANGE("Document No.","No.");
            IF ServDocLog.FINDSET THEN
              REPEAT
                TempServDocLog := ServDocLog;
                TempServDocLog.INSERT;
              UNTIL ServDocLog.NEXT = 0;
            #5..10
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Document Lo&g"(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SendCustom(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ActivityLog(Action 5)".

        addafter(Dimensions)
        {
            separator(Action16)
            {
            }
        }
    }

    var
        ServDocLog: Record "Service Document Log";


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        DocExchStatusStyle := GetDocExchStatusStyle;
        DocExchStatusVisible := "Document Exchange Status" <> "Document Exchange Status"::"Not Sent";
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
        SetSecurityFilterOnRespCenter;

        ActivateFields;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SetSecurityFilterOnRespCenter;
        */
    //end;
}
