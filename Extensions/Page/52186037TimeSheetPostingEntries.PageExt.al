#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186037 pageextension52186037 extends "Time Sheet Posting Entries" 
{
    layout
    {
        modify("Time Sheet No.")
        {
            ApplicationArea = Basic;
        }
        modify("Time Sheet Line No.")
        {
            ApplicationArea = Basic;
        }
        modify("Time Sheet Date")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Time Sheet No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Time Sheet Line No."(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Time Sheet Date"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 3)".

    }
    actions
    {
        modify("&Navigate")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 11)".

    }
}
