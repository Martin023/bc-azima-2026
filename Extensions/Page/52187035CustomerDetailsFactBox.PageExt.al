#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187035 pageextension52187035 extends "Customer Details FactBox" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Phone No.")
        {
            ApplicationArea = Basic;
        }
        modify("E-Mail")
        {
            ApplicationArea = Basic;
        }
        modify("Fax No.")
        {
            ApplicationArea = Basic;
        }
        modify("Credit Limit (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify(AvailableCreditLCY)
        {
            ApplicationArea = Basic;
        }
        modify("Payment Terms Code")
        {
            ApplicationArea = Basic;
        }
        modify(Contact)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 11)".


        //Unsupported feature: Property Deletion (Visible) on ""No."(Control 11)".

        modify(Name)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No."(Control 16)".


        //Unsupported feature: Property Deletion (ExtendedDatatype) on ""E-Mail"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E-Mail"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fax No."(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Credit Limit (LCY)"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AvailableCreditLCY(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Terms Code"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Contact(Control 7)".

    }
    actions
    {
        modify("Ship-to Address")
        {
            ApplicationArea = Basic;
        }
        modify(Comments)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Address"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comments(Action 21)".

    }
}
