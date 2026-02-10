#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186481 pageextension52186481 extends "Maintenance Ledger Entries" 
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
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("Maintenance Code")
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
        modify("G/L Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Posting Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Depreciation Book Code"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 24)".

        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Maintenance Code"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account Type"(Control 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Code"(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reversed(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reversed by Entry No."(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reversed Entry No."(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Entry No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 2)".

        modify("Dimension Set ID")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(ReverseTransaction)
        {
            ApplicationArea = Basic;
        }
        modify("&Navigate")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 26)".

        modify(SetDimensionFilter)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ReverseTransaction(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 18)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
