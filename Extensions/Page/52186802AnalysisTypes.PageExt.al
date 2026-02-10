#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186802 pageextension52186802 extends "Analysis Types" 
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
        modify("Value Type")
        {
            ApplicationArea = Basic;
        }
        modify("Item Ledger Entry Type Filter")
        {
            ApplicationArea = Basic;
        }
        modify("Value Entry Type Filter")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Value Type"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Ledger Entry Type Filter"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Value Entry Type Filter"(Control 10)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("&Reset Default Analysis Types")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Reset Default Analysis Types"(Action 15)".

    }
    local procedure ItemLedgerEntryTypeFilterOnFor(Text: Text[1024])
    begin
        // AnalysisRepMgmt.ValidateFilter(Text,Database::"Analysis Type",Rec.FieldNo(Rec."Item Ledger Entry Type Filter"),false);
        Rec."Item Ledger Entry Type Filter" := Text;
    end;

    local procedure ValueEntryTypeFilterOnFormat(Text: Text[1024])
    begin
        // AnalysisRepMgmt.ValidateFilter(Text,Database::"Analysis Type",Rec.FieldNo(Rec."Value Entry Type Filter"),false);
        Rec."Value Entry Type Filter" := Text;
    end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
