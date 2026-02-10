#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185516 pageextension52185516 extends "Posted Sales Cr. Memo Subform" 
{
    layout
    {
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        // modify("Cross-Reference No.")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (Visible) on ""Cross-Reference No."(Control 26)".

        // }
        modify("IC Partner Code")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Return Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on "Quantity(Control 8)".

        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Cost (LCY)")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Unit Cost (LCY)"(Control 66)".

        }
        modify("Unit Price")
        {
            ApplicationArea = Basic;
        }
        modify("Line Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount %")
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Invoice Disc.")
        {
            ApplicationArea = Basic;
        }
        modify("Job No.")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-from Item Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-to Item Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Deferral Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 1 Code"(Control 72)".

        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 2 Code"(Control 70)".

        }
        modify("Invoice Discount Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Total Amount Excl. VAT")
        {
            ApplicationArea = Basic;
        }
        modify("Total VAT Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Total Amount Incl. VAT")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".

        modify(FilteredTypeField)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Reference No."(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Code"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Reason Code"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Price"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Amount"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount %"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Amount"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Invoice Disc."(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 40)".

        modify("Job Task No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-from Item Entry"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Deferral Code"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 70)".

        modify("ShortcutDimCode[3]")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[4]")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[5]")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[6]")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[7]")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[8]")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Discount Amount"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Excl. VAT"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total VAT Amount"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Incl. VAT"(Control 5)".

    }
    actions
    {
        modify(DeferralSchedule)
        {

            //Unsupported feature: Property Modification (Level) on "DeferralSchedule(Action 15)".

            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(Comments)
        {

            //Unsupported feature: Property Modification (Name) on "Comments(Action 1901743104)".

            ApplicationArea = Basic;
        }
        modify(ItemTrackingEntries)
        {

            //Unsupported feature: Property Modification (Name) on "ItemTrackingEntries(Action 1905987604)".

            ApplicationArea = Basic;
        }
        modify(ItemReturnReceiptLines)
        {

            //Unsupported feature: Property Modification (Name) on "ItemReturnReceiptLines(Action 1900207104)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "DeferralSchedule(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1901741704)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comments(Action 1901743104)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemTrackingEntries(Action 1905987604)".


        //Unsupported feature: Code Modification on "ItemReturnReceiptLines(Action 1900207104).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            PageShowItemReturnRcptLines;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ShowItemReturnRcptLines;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ItemReturnReceiptLines(Action 1900207104)".


        //Unsupported feature: Property Deletion (Image) on "ItemReturnReceiptLines(Action 1900207104)".

        modify(DocumentLineTracking)
        {
            Visible = false;
        }
        modify(DocAttach)
        {
            Visible = false;
        }
        //moveafter(ActionContainer1900000004;"&Line")
    }

    //Unsupported feature: Property Modification (Name) on "PageShowItemReturnRcptLines(PROCEDURE 1)".

}
