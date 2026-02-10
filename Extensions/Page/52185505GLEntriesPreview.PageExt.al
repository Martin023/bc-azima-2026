#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185505 pageextension52185505 extends "G/L Entries Preview" 
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
        modify("G/L Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Account Name")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Job No.")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify("IC Partner Code")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Posting Type")
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
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("Additional-Currency Amount")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account Type")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account No.")
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
        modify(Reversed)
        {
            ApplicationArea = Basic;
        }
        modify("Reversed by Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Reversed Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("FA Entry Type")
        {
            ApplicationArea = Basic;
        }
        modify("FA Entry No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Account No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Account Name"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Code"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Posting Type"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Bus. Posting Group"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Prod. Posting Group"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 16)".

        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Additional-Currency Amount"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Amount"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account Type"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account No."(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Code"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reversed(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reversed by Entry No."(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reversed Entry No."(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Entry Type"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Entry No."(Control 38)".

        modify("Dimension Set ID")
        {
            Visible = false;
        }
    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 49)".

        modify(SetDimensionFilter)
        {
            Visible = false;
        }
    }
}
