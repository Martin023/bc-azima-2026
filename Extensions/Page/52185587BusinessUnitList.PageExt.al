#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185587 pageextension52185587 extends "Business Unit List" 
{
    Caption = 'Business Unit List';
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify("Company Name")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Exchange Rate Table")
        {
            ApplicationArea = Basic;
        }
        modify("Data Source")
        {
            ApplicationArea = Basic;
        }
        modify(Consolidate)
        {
            ApplicationArea = Basic;
        }
        modify("Consolidation %")
        {
            ApplicationArea = Basic;
        }
        modify("Exch. Rate Gains Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Exch. Rate Losses Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Residual Account")
        {
            ApplicationArea = Basic;
        }
        modify("Starting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Ending Date")
        {
            ApplicationArea = Basic;
        }
        modify("File Format")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Company Name"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Exchange Rate Table"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Data Source"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Consolidate(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Consolidation %"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exch. Rate Gains Acc."(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exch. Rate Losses Acc."(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Residual Account"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Date"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""File Format"(Control 14)".

        modify("Last Run")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Average Rate (Manual)")
        {
            ApplicationArea = Basic;
        }
        modify("Closing Rate")
        {
            ApplicationArea = Basic;
        }
        modify("Last Closing Rate")
        {
            ApplicationArea = Basic;
        }
        modify(Eliminations)
        {
            ApplicationArea = Basic;
        }
        modify("Trial B&alance")
        {
            ApplicationArea = Basic;
        }
        modify("Trial &Balance (4)")
        {
            ApplicationArea = Basic;
        }
        modify("Test Database")
        {
            ApplicationArea = Basic;
        }
        modify("T&est File")
        {
            ApplicationArea = Basic;
        }
        modify("Run Consolidation")
        {
            Caption = 'Import Database';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Run Consolidation"(Action 44)".

        }
        modify("I&mport File")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Average Rate (Manual)"(Action 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Closing Rate"(Action 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Closing Rate"(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Eliminations(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Trial B&alance"(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Trial &Balance (4)"(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Test Database"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""T&est File"(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Run Consolidation"(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""I&mport File"(Action 45)".

        modify("Export File")
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (Attributes) on "GetSelectionFilter(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
