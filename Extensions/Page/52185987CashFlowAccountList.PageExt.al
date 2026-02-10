#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185987 pageextension52185987 extends "Cash Flow Account List" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Account Type")
        {
            ApplicationArea = Basic;
        }
        modify(Comment)
        {
            ApplicationArea = Basic;
        }
        modify(Blocked)
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("Source Type")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Integration")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Account Filter")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 1001)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 1003)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Type"(Control 1005)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comment(Control 1007)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Blocked(Control 1009)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 1011)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Type"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Integration"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Account Filter"(Control 3)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Entries)
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Entries(Action 1018)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 1019)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetSelection(PROCEDURE 1000)".


    //Unsupported feature: Property Deletion (Attributes) on "GetSelectionFilter(PROCEDURE 4)".

}
