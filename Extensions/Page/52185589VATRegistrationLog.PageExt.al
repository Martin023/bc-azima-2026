#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185589 pageextension52185589 extends "VAT Registration Log" 
{
    layout
    {
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Registration No.")
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
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Verified Date")
        {
            ApplicationArea = Basic;
        }
        modify("Verified Name")
        {
            ApplicationArea = Basic;
        }
        modify("Verified Address")
        {
            ApplicationArea = Basic;
        }
        modify("User ID")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Country/Region Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Registration No."(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Type"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account No."(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Verified Date"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Verified Name"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Verified Address"(Control 6)".

        modify("Verified Street")
        {
            Visible = false;
        }
        modify("Verified Postcode")
        {
            Visible = false;
        }
        modify("Verified City")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 14)".

        modify("Request Identifier")
        {
            Visible = false;
        }
    }
    actions
    {
        modify("Verify VAT Registration No.")
        {
            Caption = 'Verify Registration No.';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Verify VAT Registration No."(Action 13)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Verify VAT Registration No."(Action 13)".

    }
}
