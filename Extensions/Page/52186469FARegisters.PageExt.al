#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186469 pageextension52186469 extends "FA Registers" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Journal Type")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Register No.")
        {
            ApplicationArea = Basic;
        }
        modify("Creation Date")
        {
            ApplicationArea = Basic;
        }
        modify("User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Source Code")
        {
            ApplicationArea = Basic;
        }
        modify("Journal Batch Name")
        {
            ApplicationArea = Basic;
        }
        modify("From Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("To Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("From Maintenance Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("To Maintenance Entry No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Journal Type"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Register No."(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Creation Date"(Control 8)".

        modify("Creation Time")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Journal Batch Name"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""From Entry No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""To Entry No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""From Maintenance Entry No."(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""To Maintenance Entry No."(Control 27)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("F&A Ledger")
        {
            ApplicationArea = Basic;
        }
        modify("Maintenance Ledger")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""F&A Ledger"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Maintenance Ledger"(Action 29)".

        // modify(ActionContainer5)
        // {
        //     Visible = false;
        // }
        modify("Delete Empty")
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
