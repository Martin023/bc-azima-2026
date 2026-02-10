#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186313 pageextension52186313 extends "Active Opportunity List" 
{

    //Unsupported feature: Property Modification (PageType) on ""Active Opportunity List"(Page 5132)".

    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Closed)
        {
            ApplicationArea = Basic;
        }
        modify("Creation Date")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Contact No.")
        {
            ApplicationArea = Basic;
        }
        modify("Contact Company No.")
        {
            ApplicationArea = Basic;
        }
        modify("Salesperson Code")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Sales Cycle Code")
        {
            ApplicationArea = Basic;
        }
        modify("Current Sales Cycle Stage")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign No.")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Estimated Closing Date")
        {
            ApplicationArea = Basic;
        }
        modify("Estimated Value (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Calcd. Current Value (LCY)")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Closed(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Creation Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact No."(Control 12)".

        // modify("Contact Name")
        // {
        //     Visible = false;
        // }

        // //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Company No."(Control 34)".

        // modify("Contact Company Name")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Cycle Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Current Sales Cycle Stage"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign No."(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Document Type"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Document No."(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Estimated Closing Date"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Estimated Value (LCY)"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calcd. Current Value (LCY)"(Control 40)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter(Control1)
        {
            group(Control32)
            {
                // field("Contact Name";Rec."Contact Name")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Contact Name';
                //     DrillDown = false;
                // }
                
            }
        }
    }
    actions
    {
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }
        modify("Interaction Log E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("Postponed &Interactions")
        {
            ApplicationArea = Basic;
        }
        modify("T&asks")
        {
            Caption = 'T&o-dos';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""T&asks"(Action 37)".

        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Log E&ntries"(Action 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Postponed &Interactions"(Action 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""T&asks"(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 42)".

    }
}
