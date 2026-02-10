#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186135 pageextension52186135 extends "SEPA Direct Debit Mandates" 
{
    layout
    {
        modify(ID)
        {
            ApplicationArea = Basic;
        }
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Customer Bank Account Code")
        {
            ApplicationArea = Basic;
        }
        modify("Valid From")
        {
            ApplicationArea = Basic;
        }
        modify("Valid To")
        {
            ApplicationArea = Basic;
        }
        modify("Date of Signature")
        {
            ApplicationArea = Basic;
        }
        modify("Type of Payment")
        {
            ApplicationArea = Basic;
        }
        modify("Expected Number of Debits")
        {
            ApplicationArea = Basic;
        }
        modify("Debit Counter")
        {
            ApplicationArea = Basic;
        }
        modify(Blocked)
        {
            ApplicationArea = Basic;
        }
        modify(Closed)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ID(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer Bank Account Code"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Valid From"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Valid To"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date of Signature"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Type of Payment"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expected Number of Debits"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Debit Counter"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Blocked(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Closed(Control 16)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control14(Control 14)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control15(Control 15)".

    }
}
