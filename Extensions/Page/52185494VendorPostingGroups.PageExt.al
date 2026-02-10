#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185494 pageextension52185494 extends "Vendor Posting Groups" 
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify("Payables Account")
        {
            ApplicationArea = Basic;
        }
        modify("Service Charge Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Disc. Debit Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Disc. Credit Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Invoice Rounding Account")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Invoice Rounding Account"(Control 6)".

        }
        modify("Debit Curr. Appln. Rndg. Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Credit Curr. Appln. Rndg. Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Debit Rounding Account")
        {
            ApplicationArea = Basic;
        }
        modify("Credit Rounding Account")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Tolerance Debit Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Tolerance Credit Acc.")
        {
            ApplicationArea = Basic;
        }
        modify(Control5)
        {
            Visible = false;
        }
        modify(ShowAllAccounts)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".

        modify(Description)
        {
            Visible = false;
        }
        modify("View All Accounts on Lookup")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Payables Account"(Control 4)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Payables Account"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Charge Acc."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Disc. Debit Acc."(Control 16)".


        //Unsupported feature: Property Deletion (Visible) on ""Payment Disc. Debit Acc."(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Disc. Credit Acc."(Control 23)".


        //Unsupported feature: Property Deletion (Visible) on ""Payment Disc. Credit Acc."(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Rounding Account"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Debit Curr. Appln. Rndg. Acc."(Control 8)".


        //Unsupported feature: Property Deletion (Visible) on ""Debit Curr. Appln. Rndg. Acc."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Credit Curr. Appln. Rndg. Acc."(Control 10)".


        //Unsupported feature: Property Deletion (Visible) on ""Credit Curr. Appln. Rndg. Acc."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Debit Rounding Account"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Credit Rounding Account"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Tolerance Debit Acc."(Control 25)".


        //Unsupported feature: Property Deletion (Visible) on ""Payment Tolerance Debit Acc."(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Tolerance Credit Acc."(Control 27)".


        //Unsupported feature: Property Deletion (Visible) on ""Payment Tolerance Credit Acc."(Control 27)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (CardPageID).

}
