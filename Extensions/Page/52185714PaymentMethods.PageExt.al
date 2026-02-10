#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185714 pageextension52185714 extends "Payment Methods"
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account Type")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Direct Debit")
        {
            ApplicationArea = Basic;
        }
        modify("Direct Debit Pmt. Terms Code")
        {
            ApplicationArea = Basic;
        }
        modify("Pmt. Export Line Definition")
        {
            ApplicationArea = Basic;
        }
        // modify("Bank Data Conversion Pmt. Type")
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account Type"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Debit"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Debit Pmt. Terms Code"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Export Line Definition"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Data Conversion Pmt. Type"(Control 9)".

        // modify("Use for Invoicing")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter("Bal. Account No.")
        {
            field("Payment Processor"; Rec."Payment Processor")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        // modify(ActionContainer11)
        // {
        //     Visible = false;
        // }
        modify("T&ranslation")
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
