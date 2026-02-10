#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186453 pageextension52186453 extends "FA Ledger Entries Preview"
{
    layout
    {
        modify("FA Posting Date")
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
        modify("FA No.")
        {
            ApplicationArea = Basic;
        }
        modify("Depreciation Book Code")
        {
            ApplicationArea = Basic;
        }
        modify("FA Posting Category")
        {
            ApplicationArea = Basic;
        }
        modify("FA Posting Type")
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
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("Reclassification Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Index Entry")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Depreciation Days")
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
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Posting Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Depreciation Book Code"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Posting Category"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Posting Type"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 24)".

        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Reclassification Entry"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Index Entry"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Depreciation Days"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account Type"(Control 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Code"(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reversed(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reversed by Entry No."(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reversed Entry No."(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 10)".

        modify("Dimension Set ID")
        {
            Visible = false;
        }
    }
    actions
    {
        // modify(ActionContainer5)
        // {
        //     Visible = false;
        // }
        modify(SetDimensionFilter)
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (Attributes) on "Set(PROCEDURE 1)".

}
