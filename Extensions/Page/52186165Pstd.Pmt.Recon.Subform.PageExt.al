#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186165 pageextension52186165 extends "Pstd. Pmt. Recon. Subform" 
{
    layout
    {
        modify("Transaction Date")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Statement Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Applied Amount")
        {
            ApplicationArea = Basic;
        }
        modify(Difference)
        {
            ApplicationArea = Basic;
        }
        modify("Account Type")
        {
            ApplicationArea = Basic;
        }
        modify("Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Applied Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Related-Party Name")
        {
            ApplicationArea = Basic;
        }
        modify("Additional Transaction Info")
        {
            ApplicationArea = Basic;
        }
        modify("Applied Document No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Date"(Control 2)".

        modify("Transaction ID")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Statement Amount"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applied Amount"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Difference(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Type"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account No."(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applied Entries"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Related-Party Name"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Additional Transaction Info"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applied Document No."(Control 7)".

    }
}
