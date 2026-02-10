#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185990 pageextension52185990 extends "Cash Flow Manual Expenses"
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify("Cash Flow Account No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Starting Date")
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        // modify("Recurring Frequency")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Ending Date")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 1 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Global Dimension 1 Code"(Control 1015)".


            //Unsupported feature: Property Modification (Name) on ""Global Dimension 1 Code"(Control 1015)".

        }
        modify("Global Dimension 2 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Global Dimension 2 Code"(Control 1017)".


            //Unsupported feature: Property Modification (Name) on ""Global Dimension 2 Code"(Control 1017)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 1001)".


        //Unsupported feature: Property Deletion (Visible) on "Code(Control 1001)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cash Flow Account No."(Control 1003)".


        //Unsupported feature: Property Deletion (Visible) on ""Cash Flow Account No."(Control 1003)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 1005)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Starting Date"(Control 1007)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date"(Control 1007)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Starting Date"(Control 1007)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 1013)".

        modify(Recurrence)
        {
            Visible = false;
        }
        modify("Recurring Frequency")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Recurring Frequency"(Control 1011)".


        //Unsupported feature: Property Deletion (Visible) on ""Recurring Frequency"(Control 1011)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ending Date"(Control 1009)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Date"(Control 1009)".


        //Unsupported feature: Property Deletion (Enabled) on ""Ending Date"(Control 1009)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 1015)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 1017)".

        moveafter("Starting Date"; "Ending Date")
        moveafter("Ending Date"; "Recurring Frequency")
    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1023)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (SourceTableView).


    //Unsupported feature: Property Deletion (UsageCategory).

}
