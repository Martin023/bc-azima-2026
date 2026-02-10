#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185812 pageextension52185812 extends "Dimension Values"
{
    Editable = true;
    
    layout
    {
        modify("Code")
        {
            ApplicationArea = all;
            Visible=true;
        }
        modify(Name)
        {
            ApplicationArea = all;
            Visible=true;
        }
        modify("Dimension Value Type")
        {
            ApplicationArea = all;
        }
        modify(Totaling)
        {
            ApplicationArea = all;
        }
        modify(Blocked)
        {
            ApplicationArea = all;
        }
        modify("Map-to IC Dimension Value Code")
        {
            ApplicationArea = all;
        }
        modify("Consolidation Code")
        {
            ApplicationArea = all;
        }

        

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension Value Type"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Totaling(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Blocked(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Map-to IC Dimension Value Code"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Consolidation Code"(Control 14)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter("Consolidation Code")
        {
            // field("Percentage  %";"Percentage %")
            // {
            //     ApplicationArea = Basic;
            // }
            // field("Phone No .";"Phone No.")
            // {
            //     ApplicationArea = Basic;
            // }
        }
    }
    actions
    {
        modify("Indent Dimension Values")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Indent Dimension Values"(Action 3)".

    }
}
