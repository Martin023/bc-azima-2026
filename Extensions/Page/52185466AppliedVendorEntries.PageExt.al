#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185466 pageextension52185466 extends "Applied Vendor Entries" 
{
    layout
    {
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("External Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 1 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Global Dimension 1 Code"(Control 83)".

        }
        modify("Global Dimension 2 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Global Dimension 2 Code"(Control 81)".

        }
        modify("Purchaser Code")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Original Amount")
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("Closed by Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Closed by Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Closed by Currency Amount")
        {
            ApplicationArea = Basic;
        }
        modify("User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Source Code")
        {
            ApplicationArea = Basic;
        }
        modify("Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""External Document No."(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchaser Code"(Control 79)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 77)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Original Amount"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 10)".


        //Unsupported feature: Property Deletion (Visible) on "Amount(Control 10)".

        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Closed by Amount"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Closed by Currency Code"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Closed by Currency Amount"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Code"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 14)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Detailed &Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify("&Navigate")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Navigate"(Action 19)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 33)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 33)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Detailed &Ledger Entries"(Action 36)".


        //Unsupported feature: Property Deletion (Promoted) on ""Detailed &Ledger Entries"(Action 36)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Detailed &Ledger Entries"(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 19)".

        modify("Show Posted Document")
        {
            Visible = false;
        }
        modify(ShowDocumentAttachment)
        {
            Visible = false;
        }
    }

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        RESET;
        SetControlVisibility;

        IF "Entry No." <> 0 THEN BEGIN
          CreateVendLedgEntry := Rec;
        #6..29
        END;

        MARKEDONLY(TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        RESET;
        #3..32
        */
    //end;

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
