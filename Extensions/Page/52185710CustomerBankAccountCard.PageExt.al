#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185710 pageextension52185710 extends "Customer Bank Account Card" 
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(Address)
        {
            ApplicationArea = Basic;
        }
        modify("Address 2")
        {
            ApplicationArea = Basic;
        }
        modify("Post Code")
        {
            ApplicationArea = Basic;
        }
        modify(City)
        {
            ApplicationArea = Basic;
        }
        modify("Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Phone No.")
        {
            ApplicationArea = Basic;
        }
        modify(Contact)
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bank Branch No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bank Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Transit No.")
        {
            ApplicationArea = Basic;
        }
        modify("Fax No.")
        {
            ApplicationArea = Basic;
        }
        modify("E-Mail")
        {
            ApplicationArea = Basic;
        }
        modify("Home Page")
        {
            ApplicationArea = Basic;
        }
        modify("SWIFT Code")
        {
            ApplicationArea = Basic;
        }
        modify(Iban)
        {
            ApplicationArea = Basic;
        }
        modify("Bank Clearing Standard")
        {
            ApplicationArea = Basic;
        }
        modify("Bank Clearing Code")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Address(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address 2"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Code"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "City(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Country/Region Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Contact(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Branch No."(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Account No."(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transit No."(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fax No."(Control 22)".


        //Unsupported feature: Property Deletion (ExtendedDatatype) on ""E-Mail"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E-Mail"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Home Page"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""SWIFT Code"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IBAN(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Clearing Standard"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Clearing Code"(Control 9)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addfirst(Communication)
        {
            field("Phone No.2";Rec."Phone No.")
            {
                ApplicationArea = Basic;
            }
        }
        addfirst(Transfer)
        {
            field("Bank Branch No.2";Rec."Bank Branch No.")
            {
                ApplicationArea = Basic;
            }
            field("Bank Account No.2";Rec."Bank Account No.")
            {
                ApplicationArea = Basic;
            }
            field("Transit No.2";Rec."Transit No.")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        modify("Direct Debit Mandates")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Debit Mandates"(Action 5)".

    }
}
