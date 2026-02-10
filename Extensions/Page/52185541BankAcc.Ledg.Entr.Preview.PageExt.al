#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185541 pageextension52185541 extends "Bank Acc. Ledg. Entr. Preview" 
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
        modify("Bank Account No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
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
        modify("Our Contact Code")
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
        modify("Amount (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Amount")
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
        modify(Open)
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Account No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Our Contact Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount (LCY)"(Control 30)".

        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Debit Amount (LCY)")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount (LCY)")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Amount"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account Type"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account No."(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Open(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Code"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reversed(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reversed by Entry No."(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reversed Entry No."(Control 44)".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 25)".

        modify(SetDimensionFilter)
        {
            Visible = false;
        }
    }
}
