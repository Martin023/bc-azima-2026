#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186624 pageextension52186624 extends "Loaner Card" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Description 2")
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Serial No.")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify(Lent)
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
        modify(Blocked)
        {
            ApplicationArea = Basic;
        }
        modify("Last Date Modified")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Description 2"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Lent(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Blocked(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Date Modified"(Control 28)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("Loaner E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("&Receive")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Loaner E&ntries"(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Receive"(Action 12)".

        addfirst("L&oaner")
        {
            separator(Action17)
            {
                Caption = '';
            }
        }
        addafter("Co&mments")
        {
            separator(Action16)
            {
                Caption = '';
            }
        }
    }
}
