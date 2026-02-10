#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185528 pageextension52185528 extends "Posted Purchase Credit Memos" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Buy-from Vendor No.")
        {
            ApplicationArea = Basic;
        }
        modify("Order Address Code")
        {
            ApplicationArea = Basic;
        }
        modify("Buy-from Vendor Name")
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
        modify("Buy-from Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Buy-from Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Buy-from Contact")
        {
            ApplicationArea = Basic;
        }
        modify("Pay-to Vendor No.")
        {
            ApplicationArea = Basic;
        }
        modify("Pay-to Name")
        {
            ApplicationArea = Basic;
        }
        modify("Pay-to Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Pay-to Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Pay-to Contact")
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
        modify("Purchaser Code")
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

            //Unsupported feature: Property Insertion (Visible) on ""Location Code"(Control 89)".

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

        //Unsupported feature: Property Insertion (Visible) on "Control1905767507(Control 1905767507)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Vendor No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Address Code"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Vendor Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 35)".

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
            PAGE.RUNMODAL(PAGE::"Posted Purchase Credit Memo",Rec)
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 13)".



        //Unsupported feature: Code Modification on ""Amount Including VAT"(Control 17).OnDrillDown".

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
            PAGE.RUNMODAL(PAGE::"Posted Purchase Credit Memo",Rec)
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Including VAT"(Control 17)".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Post Code"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Country/Region Code"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Contact"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Vendor No."(Control 127)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Name"(Control 125)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Post Code"(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Country/Region Code"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Contact"(Control 115)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 111)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Name"(Control 109)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Post Code"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Country/Region Code"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Contact"(Control 99)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 97)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchaser Code"(Control 71)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 87)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 85)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 89)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. Printed"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 1102601001)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Doc. Type"(Control 1102601003)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "IncomingDocAttachFactBox(Control 3)".


        //Unsupported feature: Property Deletion (Visible) on "IncomingDocAttachFactBox(Control 3)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Statistics)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 29)".

        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("&Print")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Print"(Action 21)".

        }
        modify("&Navigate")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Navigate"(Action 22)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 29)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Statistics(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 30)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 30)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1102601000)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 1102601000)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Dimensions(Action 1102601000)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 1102601000)".

        modify(Vendor)
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on ""&Print"(Action 21).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            PurchCrMemoHdr := Rec;
            CurrPage.SETSELECTIONFILTER(PurchCrMemoHdr);
            OnBeforePrintRecords(PurchCrMemoHdr);
            PurchCrMemoHdr.PrintRecords(TRUE);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(PurchCrMemoHdr);
            PurchCrMemoHdr.PrintRecords(TRUE);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 21)".


        //Unsupported feature: Property Deletion (Visible) on ""&Print"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 22)".


        //Unsupported feature: Property Deletion (Visible) on ""&Navigate"(Action 22)".

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
    }


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


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
