#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186658 pageextension52186658 extends "Posted Service Credit Memos" 
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
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Contact Name")
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
        }
        modify("Document Exchange Status")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Code"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Country/Region Code"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Name"(Control 35)".


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


        //Unsupported feature: Property Deletion (Visible) on ""Document Exchange Status"(Control 3)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SendCustom(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ActivityLog(Action 5)".

    }


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetSecurityFilterOnRespCenter;

        ServiceCrMemoHeader.COPYFILTERS(Rec);
        ServiceCrMemoHeader.SETFILTER("Document Exchange Status",'<>%1',"Document Exchange Status"::"Not Sent");
        DocExchStatusVisible := NOT ServiceCrMemoHeader.ISEMPTY;
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

}
