#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185985 pageextension52185985 extends "Cash Flow Forecast Entries" 
{
    Caption = 'Cash Flow Forecast Entries';
    layout
    {
        modify("Cash Flow Date")
        {
            ApplicationArea = Basic;
        }
        modify("Cash Flow Forecast No.")
        {
            ApplicationArea = Basic;
        }
        modify("Cash Flow Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        // modify(Description)
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Source Type")
        {
            ApplicationArea = Basic;
        }
        // modify("Source No.")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Payment Discount")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Amount (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify("User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Cash Flow Date"(Control 1001)".

        modify(Overdue)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Cash Flow Forecast No."(Control 1005)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cash Flow Account No."(Control 1007)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 1011)".

        modify(Description)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 1013)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Type"(Control 1003)".

        modify("Source No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Source No."(Control 1017)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Discount"(Control 1025)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 1027)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount (LCY)"(Control 1029)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 1033)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 1043)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 1045)".

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
        modify(GLDimensionOverview)
        {
            ApplicationArea = Basic;
        }
        modify(ShowSource)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (RunPageMode) on "ShowSource(Action 1)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1052)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 1052)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 1052)".

        modify(SetDimensionFilter)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "GLDimensionOverview(Action 1053)".


        //Unsupported feature: Property Deletion (Promoted) on "GLDimensionOverview(Action 1053)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "GLDimensionOverview(Action 1053)".


        //Unsupported feature: Code Modification on "ShowSource(Action 1).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ShowSource(FALSE);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ShowSource;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowSource(Action 1)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
