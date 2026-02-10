#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186136 pageextension52186136 extends "Positive Pay Entries" 
{
    layout
    {
        modify("Bank Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Upload Date")
        {
            ApplicationArea = Basic;
        }
        modify("Upload Time")
        {
            ApplicationArea = Basic;
        }
        modify("Last Upload Date")
        {
            ApplicationArea = Basic;
        }
        modify("Last Upload Time")
        {
            ApplicationArea = Basic;
        }
        modify("Number of Uploads")
        {
            ApplicationArea = Basic;
        }
        modify("Number of Checks")
        {
            ApplicationArea = Basic;
        }
        modify("Number of Voids")
        {
            ApplicationArea = Basic;
        }
        modify("Check Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Void Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Confirmation Number")
        {
            ApplicationArea = Basic;
        }
        modify("Upload Date-Time")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Account No."(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Upload Date"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Upload Time"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Upload Date"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Upload Time"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Number of Uploads"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Number of Checks"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Number of Voids"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Check Amount"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Void Amount"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Confirmation Number"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Upload Date-Time"(Control 14)".

    }
    actions
    {
        modify(PositivePayEntryDetails)
        {
            ApplicationArea = Basic;
        }
        modify(ReexportPositivePay)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PositivePayEntryDetails(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReexportPositivePay(Action 18)".

    }
}
