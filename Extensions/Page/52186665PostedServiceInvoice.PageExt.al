#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186665 pageextension52186665 extends "Posted Service Invoice" 
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
        modify("Contact No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {

            //Unsupported feature: Property Modification (Level) on "Name(Control 61)".

            ApplicationArea = Basic;
        }
        modify(Address)
        {

            //Unsupported feature: Property Modification (Level) on "Address(Control 63)".

            ApplicationArea = Basic;
        }
        modify("Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Address 2"(Control 65)".

            ApplicationArea = Basic;
        }
        modify(City)
        {

            //Unsupported feature: Property Modification (Level) on "City(Control 67)".

            ApplicationArea = Basic;
        }
        modify("Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Post Code"(Control 6)".

            ApplicationArea = Basic;
        }
        modify("Contact Name")
        {

            //Unsupported feature: Property Modification (Level) on ""Contact Name"(Control 69)".

            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Exchange Status")
        {

            //Unsupported feature: Property Modification (Level) on ""Document Exchange Status"(Control 5)".

            ApplicationArea = Basic;
        }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify("Order No.")
        {
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
        modify("Bill-to Contact No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Name")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Name"(Control 18)".

            ApplicationArea = Basic;
        }
        modify("Bill-to Address")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Address"(Control 20)".

            ApplicationArea = Basic;
        }
        modify("Bill-to Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Address 2"(Control 22)".

            ApplicationArea = Basic;
        }
        modify("Bill-to City")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to City"(Control 24)".

            ApplicationArea = Basic;
        }
        modify("Bill-to Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Post Code"(Control 78)".

            ApplicationArea = Basic;
        }
        modify("Bill-to Contact")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Contact"(Control 26)".

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
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Code")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Name")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Name"(Control 38)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Address")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Address"(Control 40)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Address 2"(Control 42)".

            ApplicationArea = Basic;
        }
        modify("Ship-to City")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to City"(Control 44)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Post Code"(Control 80)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Contact")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Contact"(Control 46)".

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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact No."(Control 96)".

        modify("Sell-to")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Address(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address 2"(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on "City(Control 67)".

        modify(Control19)
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Name"(Control 69)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 12)".

        modify(Control11)
        {
            Visible = false;
        }

        //Unsupported feature: Code Modification on ""Document Exchange Status"(Control 5).OnDrillDown".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Exchange Status"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pre-Assigned No."(Control 73)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Responsibility Center"(Control 92)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. Printed"(Control 32)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "ServInvLines(Control 54)".


        //Unsupported feature: Property Deletion (PartType) on "ServInvLines(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Customer No."(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Contact No."(Control 98)".

        modify("Bill-to")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Name"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Name"(Control 18)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Address"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Address"(Control 20)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Address 2"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Address 2"(Control 22)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to City"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to City"(Control 24)".

        modify(Control28)
        {
            Visible = false;
        }
        modify("Bill-to County")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Post Code"(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Post Code"(Control 78)".

        modify("Bill-to Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Contact"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Contact"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 36)".

        modify("Ship-to")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Name"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Name"(Control 38)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Address"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Address"(Control 40)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Address 2"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Address 2"(Control 42)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to City"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to City"(Control 44)".

        modify(Control31)
        {
            Visible = false;
        }
        modify("Ship-to County")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Post Code"(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Post Code"(Control 80)".

        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Contact"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Contact"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 87)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""EU 3-Party Trade"(Control 52)".


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

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 8)".

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

            //Unsupported feature: Property Modification (PromotedCategory) on "SendCustom(Action 3)".

        }
        modify("&Print")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Print"(Action 58)".

        }
        modify("&Navigate")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Navigate"(Action 59)".

        }
        modify(ActivityLog)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 8)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Statistics(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 57)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 57)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 89)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 89)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Dimensions(Action 89)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 89)".



        //Unsupported feature: Code Insertion (VariableCollection) on ""Service Document Lo&g"(Action 35).OnAction".

        //trigger (Variable: ServDocLog)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Service Document Lo&g"(Action 35).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TempServDocLog.RESET;
            TempServDocLog.DELETEALL;
            TempServDocLog.CopyServLog(TempServDocLog."Document Type"::"Posted Invoice","No.");
            TempServDocLog.CopyServLog(TempServDocLog."Document Type"::Order,"Order No.");
            TempServDocLog.CopyServLog(TempServDocLog."Document Type"::Invoice,"Pre-Assigned No.");

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
            ServDocLog.SETRANGE("Document Type",ServDocLog."Document Type"::"Posted Invoice");
            ServDocLog.SETRANGE("Document No.","No.");
            IF ServDocLog.FINDSET THEN
              REPEAT
                TempServDocLog := ServDocLog;
                TempServDocLog.INSERT;
              UNTIL ServDocLog.NEXT = 0;

            ServDocLog.RESET;
            ServDocLog.SETRANGE("Document Type",ServDocLog."Document Type"::Order);
            ServDocLog.SETRANGE("Document No.","Order No.");
            IF ServDocLog.FINDSET THEN
              REPEAT
                TempServDocLog := ServDocLog;
                TempServDocLog.INSERT;
              UNTIL ServDocLog.NEXT = 0;

            ServDocLog.RESET;
            ServDocLog.SETRANGE("Document Type",ServDocLog."Document Type"::Invoice);
            ServDocLog.SETRANGE("Document No.","Pre-Assigned No.");
            IF ServDocLog.FINDSET THEN
              REPEAT
                TempServDocLog := ServDocLog;
                TempServDocLog.INSERT;
              UNTIL ServDocLog.NEXT = 0;
            #6..11
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Document Lo&g"(Action 35)".


        //Unsupported feature: Property Deletion (Promoted) on ""Service Document Lo&g"(Action 35)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Service Document Lo&g"(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SendCustom(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ActivityLog(Action 9)".


        //Unsupported feature: Property Deletion (Promoted) on "ActivityLog(Action 9)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "ActivityLog(Action 9)".

        addafter(Dimensions)
        {
            separator(Action34)
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

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
