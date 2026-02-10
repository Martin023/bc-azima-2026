#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186467 pageextension52186467 extends "FA Allocations" 
{
    layout
    {
        modify("Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Account Name")
        {
            ApplicationArea = Basic;
        }
        modify("Allocation %")
        {
            ApplicationArea = Basic;
        }
        modify(AllocationPct)
        {
            ApplicationArea = Basic;
        }
        modify(TotalAllocationPct)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Account No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allocation %"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AllocationPct(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalAllocationPct(Control 21)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 13)".

    }
}
