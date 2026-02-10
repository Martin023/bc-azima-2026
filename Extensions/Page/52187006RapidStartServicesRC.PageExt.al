#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187006 pageextension52187006 extends "RapidStart Services RC" 
{
    Caption = 'Role Center';
    layout
    {

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control3(Control 3)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control8(Control 8)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control10(Control 10)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control14(Control 14)".

    }
    actions
    {
        modify(Worksheet)
        {
            ApplicationArea = Basic;
        }
        modify(Packages)
        {
            ApplicationArea = Basic;
        }
        modify(Tables)
        {
            ApplicationArea = Basic;
        }
        modify(Questionnaires)
        {
            ApplicationArea = Basic;
        }
        modify(Templates)
        {
            ApplicationArea = Basic;
        }
        modify("RapidStart Services Wizard")
        {
            ApplicationArea = Basic;
        }
        modify(ConfigurationWorksheet)
        {

            //Unsupported feature: Property Modification (Name) on "ConfigurationWorksheet(Action 15)".

            ApplicationArea = Basic;
        }
        modify("Complete Setup")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Worksheet(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Packages(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Tables(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Questionnaires(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Templates(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""RapidStart Services Wizard"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ConfigurationWorksheet(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Complete Setup"(Action 24)".

    }
}
