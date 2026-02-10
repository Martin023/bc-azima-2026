#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185633 pageextension52185633 extends "VAT Statement" 
{
    Caption = 'VAT Statement';
    layout
    {
        modify(CurrentStmtName)
        {
            ApplicationArea = Basic;
        }
        modify("Row No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("Account Totaling")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Posting Type")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Amount Type")
        {
            ApplicationArea = Basic;
        }
        modify("Row Totaling")
        {
            ApplicationArea = Basic;
        }
        modify("Calculate with")
        {
            ApplicationArea = Basic;
        }
        modify(Control22)
        {
            ApplicationArea = Basic;
        }
        modify("Print with")
        {
            ApplicationArea = Basic;
        }
        modify("New Page")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentStmtName(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Row No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".

        modify("Box No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Totaling"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Posting Type"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Bus. Posting Group"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Prod. Posting Group"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Type"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Row Totaling"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calculate with"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control22(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Print with"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New Page"(Control 26)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("P&review")
        {
            ApplicationArea = Basic;
        }
        // modify("VAT Statement")
        // {
        //     ApplicationArea = Basic;
        // }
        modify(Print)
        {
            ApplicationArea = Basic;
        }
        modify("Calc. and Post VAT Settlement")
        {

            //Unsupported feature: Property Modification (Name) on ""Calc. and Post VAT Settlement"(Action 33)".

            Caption = 'Calc. and Post VAT Settlement';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""P&review"(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Statement"(Action 1902106506)".


        //Unsupported feature: Property Deletion (Visible) on ""VAT Statement"(Action 1902106506)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Print(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calc. and Post VAT Settlement"(Action 33)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
