#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185610 pageextension52185610 extends "Recurring Job Jnl." 
{
    Caption = 'Recurring Job Jnl.';
    layout
    {
        modify(CurrentJnlBatchName)
        {
            ApplicationArea = Basic;
        }
        modify("Recurring Method")
        {
            ApplicationArea = Basic;
        }
        modify("Recurring Frequency")
        {
            ApplicationArea = Basic;
        }
        modify("Line Type")
        {
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
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("External Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Job No.")
        {
            ApplicationArea = Basic;
        }
        modify("Job Task No.")
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
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
        modify("ShortcutDimCode[3]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[4]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[5]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[6]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[7]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[8]")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Work Type Code")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Direct Unit Cost (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Cost (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Total Cost (LCY)")
        {
            ApplicationArea = Basic;
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
        modify("Total Price")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Price (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Total Price (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-from Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Expiration Date")
        {
            ApplicationArea = Basic;
        }
        modify(JobDescription)
        {
            ApplicationArea = Basic;
        }
        modify(AccName)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentJnlBatchName(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Recurring Method"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Recurring Frequency"(Control 90)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Type"(Control 88)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""External Document No."(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Task No."(Control 86)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Bus. Posting Group"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Prod. Posting Group"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Type Code"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Unit Cost (LCY)"(Control 16)".

        modify("Unit Cost")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 96)".

        modify("Total Cost")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Cost (LCY)"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Price"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Amount"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount %"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Amount"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Price"(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Price (LCY)"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Price (LCY)"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Entry"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-from Entry"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expiration Date"(Control 80)".


        //Unsupported feature: Property Deletion (ShowCaption) on "JobDescription(Control 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AccName(Control 76)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Item &Tracking Lines")
        {
            ApplicationArea = Basic;
        }
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        modify("Ledger E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("Calc. Remaining Usage")
        {
            ApplicationArea = Basic;
        }
        modify(Reconcile)
        {
            ApplicationArea = Basic;
        }
        modify("Test Report")
        {
            ApplicationArea = Basic;
        }
        modify("P&ost")
        {
            ApplicationArea = Basic;
        }
        modify("Post and &Print")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 93)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Lines"(Action 94)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calc. Remaining Usage"(Action 95)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reconcile(Action 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Test Report"(Action 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""P&ost"(Action 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post and &Print"(Action 57)".

    }

    //Unsupported feature: Property Modification (Length) on "JobDescription(Variable 1003)".

    //var
        //>>>> ORIGINAL VALUE:
        //JobDescription : 100;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //JobDescription : 50;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "AccName(Variable 1004)".

    //var
        //>>>> ORIGINAL VALUE:
        //AccName : 100;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //AccName : 50;
        //Variable type has not been exported.

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
