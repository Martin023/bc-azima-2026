#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185869 pageextension52185869 extends "IC G/L Account Card" 
{
    Caption = 'IC G/L Account Card';
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
        modify("Income/Balance")
        {
            ApplicationArea = Basic;
        }
        modify(Blocked)
        {
            ApplicationArea = Basic;
        }
        modify("Map-to G/L Acc. No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Type"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Income/Balance"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Blocked(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Map-to G/L Acc. No."(Control 12)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("&List")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&List"(Action 16)".


        //Unsupported feature: Property Deletion (Promoted) on ""&List"(Action 16)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""&List"(Action 16)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""&List"(Action 16)".

    }
}
