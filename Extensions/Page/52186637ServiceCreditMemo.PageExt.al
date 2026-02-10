#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186637 pageextension52186637 extends "Service Credit Memo" 
{

    //Unsupported feature: Property Insertion (PopulateAllFields) on ""Service Credit Memo"(Page 5935)".

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

            //Unsupported feature: Property Modification (Level) on "Name(Control 6)".

            ApplicationArea = Basic;
        }
        modify(Address)
        {

            //Unsupported feature: Property Modification (Level) on "Address(Control 65)".

            ApplicationArea = Basic;
        }
        modify("Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Address 2"(Control 67)".

            ApplicationArea = Basic;
        }
        modify("Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Post Code"(Control 70)".

            ApplicationArea = Basic;
        }
        modify(City)
        {

            //Unsupported feature: Property Modification (Level) on "City(Control 69)".

            ApplicationArea = Basic;
        }
        modify("Contact Name")
        {

            //Unsupported feature: Property Modification (Level) on ""Contact Name"(Control 8)".

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
        modify("Salesperson Code")
        {
            ApplicationArea = Basic;
        }
        modify("Responsibility Center")
        {
            ApplicationArea = Basic;
        }
        modify("Assigned User ID")
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

            //Unsupported feature: Property Modification (Level) on ""Bill-to Name"(Control 20)".

            ApplicationArea = Basic;
        }
        modify("Bill-to Address")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Address"(Control 22)".

            ApplicationArea = Basic;
        }
        modify("Bill-to Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Address 2"(Control 24)".

            ApplicationArea = Basic;
        }
        modify("Bill-to Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Post Code"(Control 75)".

            ApplicationArea = Basic;
        }
        modify("Bill-to City")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to City"(Control 26)".

            ApplicationArea = Basic;
        }
        modify("Bill-to Contact")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Contact"(Control 28)".

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
        modify("EU 3-Party Trade")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Discount %")
        {
            ApplicationArea = Basic;
        }
        modify("Pmt. Discount Date")
        {
            ApplicationArea = Basic;
        }
        modify("Prices Including VAT")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Name")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Name"(Control 32)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Address")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Address"(Control 34)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Address 2"(Control 36)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Post Code"(Control 83)".

            ApplicationArea = Basic;
        }
        modify("Ship-to City")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to City"(Control 38)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Contact")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Contact"(Control 40)".

            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Transaction Type")
        {
            ApplicationArea = Basic;
        }
        modify("Transaction Specification")
        {
            ApplicationArea = Basic;
        }
        modify("Transport Method")
        {
            ApplicationArea = Basic;
        }
        modify("Exit Point")
        {
            ApplicationArea = Basic;
        }
        modify("Area")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Doc. Type")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Doc. No.")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to ID")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact No."(Control 57)".

        modify("Sell-to")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Address(Control 65)".


        //Unsupported feature: Property Deletion (QuickEntry) on "Address(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address 2"(Control 67)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Address 2"(Control 67)".

        modify(Control13)
        {
            Visible = false;
        }
        modify(County)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Code"(Control 70)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Post Code"(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on "City(Control 69)".


        //Unsupported feature: Property Deletion (QuickEntry) on "City(Control 69)".

        modify("Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Name"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Responsibility Center"(Control 107)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assigned User ID"(Control 111)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "ServLines(Control 48)".


        //Unsupported feature: Property Deletion (PartType) on "ServLines(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Customer No."(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Contact No."(Control 124)".

        modify("Bill-to")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Name"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Name"(Control 20)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Address"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Address"(Control 22)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Bill-to Address"(Control 22)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Address 2"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Address 2"(Control 24)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Bill-to Address 2"(Control 24)".

        modify(Control21)
        {
            Visible = false;
        }
        modify("Bill-to County")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Post Code"(Control 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Post Code"(Control 75)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Bill-to Post Code"(Control 75)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to City"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to City"(Control 26)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Bill-to City"(Control 26)".

        modify("Bill-to Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Contact"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Contact"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Terms Code"(Control 131)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""EU 3-Party Trade"(Control 42)".

        modify("Payment Method Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 91)".


        //Unsupported feature: Property Deletion (Importance) on ""Currency Code"(Control 91)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 133)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Discount %"(Control 135)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Discount Date"(Control 137)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prices Including VAT"(Control 100)".

        modify("Ship-to")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Name"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Name"(Control 32)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Address"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Address"(Control 34)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Ship-to Address"(Control 34)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Address 2"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Address 2"(Control 36)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Ship-to Address 2"(Control 36)".

        modify(Control29)
        {
            Visible = false;
        }
        modify("Ship-to County")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Post Code"(Control 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Post Code"(Control 83)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Ship-to Post Code"(Control 83)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to City"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to City"(Control 38)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Ship-to City"(Control 38)".

        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Contact"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Contact"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Type"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Specification"(Control 89)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transport Method"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exit Point"(Control 85)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Area(Control 87)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Doc. Type"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Doc. No."(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to ID"(Control 94)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1902018507(Control 1902018507)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900316107(Control 1900316107)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        moveafter("Payment Terms Code";"Due Date")
        moveafter("Foreign Trade";"Currency Code")
    }
    actions
    {
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }
        modify(Card)
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
        modify("Calculate Invoice Discount")
        {
            ApplicationArea = Basic;
        }
        modify(ApplyEntries)
        {
            ApplicationArea = Basic;
        }
        modify("Get St&d. Service Codes")
        {
            ApplicationArea = Basic;
        }
        modify("Get Prepaid Contract E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify(TestReport)
        {
            ApplicationArea = Basic;
        }
        modify(Post)
        {
            ApplicationArea = Basic;
        }
        modify(Preview)
        {
            ApplicationArea = Basic;
        }
        modify(PostAndSend)
        {
            ApplicationArea = Basic;
        }
        modify("Post and &Print")
        {
            ApplicationArea = Basic;
        }
        modify("Post &Batch")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 105)".


        //Unsupported feature: Property Deletion (Enabled) on "Dimensions(Action 105)".


        //Unsupported feature: Code Insertion (VariableCollection) on ""Service Document Lo&g"(Action 30).OnAction".

        //trigger (Variable: ServDocLog)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Service Document Lo&g"(Action 30).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TempServDocLog.RESET;
            TempServDocLog.DELETEALL;
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
            ServDocLog.SETRANGE("Document No.","No.");
            IF ServDocLog.FINDSET THEN
              REPEAT
                TempServDocLog := ServDocLog;
                TempServDocLog.INSERT;
              UNTIL ServDocLog.NEXT = 0;
            #4..9
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Document Lo&g"(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calculate Invoice Discount"(Action 114)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ApplyEntries(Action 121)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get St&d. Service Codes"(Action 112)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get Prepaid Contract E&ntries"(Action 120)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TestReport(Action 60)".



        //Unsupported feature: Code Modification on "Post(Action 61).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            PreAssignedNo := "No.";
            ServPostYesNo.PostDocument(Rec);

            DocumentIsPosted := NOT ServiceHeader.GET("Document Type","No.");

            IF InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) THEN
              ShowPostedConfirmationMessage(PreAssignedNo);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ServPostYesNo.PostDocument(Rec);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Post(Action 61)".



        //Unsupported feature: Code Modification on "Preview(Action 5).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ServPostYesNo.PreviewDocument(Rec);
            DocumentIsPosted := NOT ServiceHeader.GET("Document Type","No.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ServPostYesNo.PreviewDocument(Rec);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Preview(Action 5)".



        //Unsupported feature: Code Modification on "PostAndSend(Action 3).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CODEUNIT.RUN(CODEUNIT::"Service-Post and Send",Rec);
            DocumentIsPosted := NOT ServiceHeader.GET("Document Type","No.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CODEUNIT.RUN(CODEUNIT::"Service-Post and Send",Rec);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "PostAndSend(Action 3)".



        //Unsupported feature: Code Modification on ""Post and &Print"(Action 62).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ServPostPrint.PostDocument(Rec);
            DocumentIsPosted := NOT ServiceHeader.GET("Document Type","No.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ServPostPrint.PostDocument(Rec);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Post and &Print"(Action 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post &Batch"(Action 63)".

        addafter(Dimensions)
        {
            separator(Action27)
            {
            }
        }
        addafter("Calculate Invoice Discount")
        {
            separator(Action113)
            {
            }
        }
        addafter(ApplyEntries)
        {
            separator(Action126)
            {
            }
        }
        addafter("Get St&d. Service Codes")
        {
            separator(Action128)
            {
            }
        }
    }

    var
        ServDocLog: Record "Service Document Log";


    //Unsupported feature: Code Modification on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Responsibility Center" := UserMgt.GetServiceFilter;

        IF "No." = '' THEN
          SetCustomerFromFilter;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        "Responsibility Center" := UserMgt.GetServiceFilter;
        */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetSecurityFilterOnRespCenter;
        IF ("No." <> '') AND ("Customer No." = '') THEN
          DocumentIsPosted := (NOT GET("Document Type","No."));

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
