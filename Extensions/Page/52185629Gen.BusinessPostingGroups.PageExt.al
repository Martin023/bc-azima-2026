#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185629 pageextension52185629 extends "Gen. Business Posting Groups" 
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Def. VAT Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Auto Insert Default")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Code Modification on ""Def. VAT Bus. Posting Group"(Control 9).OnValidate".

        //trigger  VAT Bus()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Def. VAT Bus. Posting Group" <> xRec."Def. VAT Bus. Posting Group" THEN
              IF NOT ConfirmManagement.ConfirmProcess(
                   STRSUBSTNO(Text000,Code,xRec."Def. VAT Bus. Posting Group"),TRUE)
              THEN
                ERROR('');
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF "Def. VAT Bus. Posting Group" <> xRec."Def. VAT Bus. Posting Group" THEN
              IF NOT CONFIRM(Text000,FALSE,Code,xRec."Def. VAT Bus. Posting Group") THEN
                ERROR('');
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Def. VAT Bus. Posting Group"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Auto Insert Default"(Control 12)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("&Setup")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Setup"(Action 8)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
