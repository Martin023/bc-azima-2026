#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186664 pageextension52186664 extends "Posted Service Invoices"
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
        modify("Due Date")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Due Date"(Control 1102601003)".

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
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Exchange Status")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".

        modify("Order No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 1102601003)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 37)".

        // modify(Amount)
        // {
        //     Visible = false;
        // }
        // modify("Amount Including VAT")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Code"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Country/Region Code"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Name"(Control 35)".


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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 1102601001)".


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

        moveafter(Name; "Currency Code")
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


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1102601000)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SendCustom(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ActivityLog(Action 7)".

    }


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetSecurityFilterOnRespCenter;

    ServiceInvoiceHeader.COPYFILTERS(Rec);
    ServiceInvoiceHeader.SETFILTER("Document Exchange Status",'<>%1',"Document Exchange Status"::"Not Sent");
    DocExchStatusVisible := NOT ServiceInvoiceHeader.ISEMPTY;
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
