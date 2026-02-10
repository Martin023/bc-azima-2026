#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186457 pageextension52186457 extends "Depreciation Book Card"
{
    layout
    {
        addafter("Fiscal Year 365 Days")
        {
            field("Periodic Depr. Date Calc."; rec."Periodic Depr. Date Calc.")
            {
                ApplicationArea = Basic, Suite;
            }
        }
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Default Final Rounding Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Default Ending Book Value")
        {
            ApplicationArea = Basic;
        }
        modify("Disposal Calculation Method")
        {
            ApplicationArea = Basic;
        }
        modify("Subtract Disc. in Purch. Inv.")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Correction of Disposal")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Changes in Depr. Fields")
        {
            ApplicationArea = Basic;
        }
        modify("VAT on Net Disposal Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Identical Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Indexation")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Depr. below Zero")
        {
            ApplicationArea = Basic;
        }
        modify("Allow more than 360/365 Days")
        {
            ApplicationArea = Basic;
        }
        modify("Use FA Ledger Check")
        {
            ApplicationArea = Basic;
        }
        modify("Use Rounding in Periodic Depr.")
        {
            ApplicationArea = Basic;
        }
        modify("Use Same FA+G/L Posting Dates")
        {
            ApplicationArea = Basic;
        }
        modify("Fiscal Year 365 Days")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Integration - Acq. Cost")
        {
            Caption = 'Acquisition Cost';
            ApplicationArea = Basic;
        }
        modify("G/L Integration - Depreciation")
        {
            Caption = 'Depreciation';
            ApplicationArea = Basic;
        }
        modify("G/L Integration - Write-Down")
        {
            Caption = 'Write-Down';
            ApplicationArea = Basic;
        }
        modify("G/L Integration - Appreciation")
        {
            Caption = 'Appreciation';
            ApplicationArea = Basic;
        }
        modify("G/L Integration - Custom 1")
        {
            Caption = 'Custom 1';
            ApplicationArea = Basic;
        }
        modify("G/L Integration - Custom 2")
        {
            Caption = 'Custom 2';
            ApplicationArea = Basic;
        }
        modify("G/L Integration - Disposal")
        {
            Caption = 'Disposal';
            ApplicationArea = Basic;
        }
        modify("G/L Integration - Maintenance")
        {
            Caption = 'Maintenance';
            ApplicationArea = Basic;
        }
        modify("Part of Duplication List")
        {
            ApplicationArea = Basic;
        }
        modify("Use FA Exch. Rate in Duplic.")
        {
            ApplicationArea = Basic;
        }
        modify("Default Exchange Rate")
        {
            ApplicationArea = Basic;
        }
        modify("Add-Curr Exch Rate - Acq. Cost")
        {
            Caption = 'Acquisition Cost';
            ApplicationArea = Basic;
        }
        modify("Add.-Curr. Exch. Rate - Depr.")
        {
            ApplicationArea = Basic;
        }
        modify("Add-Curr Exch Rate -Write-Down")
        {
            ApplicationArea = Basic;
        }
        modify("Add-Curr. Exch. Rate - Apprec.")
        {
            Caption = 'Appreciation';
            ApplicationArea = Basic;
        }
        modify("Add-Curr. Exch Rate - Custom 1")
        {
            ApplicationArea = Basic;
        }
        modify("Add-Curr. Exch Rate - Custom 2")
        {
            ApplicationArea = Basic;
        }
        modify("Add.-Curr. Exch. Rate - Disp.")
        {
            ApplicationArea = Basic;
        }
        modify("Add.-Curr. Exch. Rate - Maint.")
        {
            ApplicationArea = Basic;
        }



    }
    actions
    {
        modify("FA Posting Type Setup")
        {
            ApplicationArea = Basic;
        }
        modify("FA &Journal Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Create FA Depreciation Books")
        {
            ApplicationArea = Basic;
        }
        modify("C&opy Depreciation Book")
        {
            ApplicationArea = Basic;
        }
        modify("C&ancel FA Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Co&py FA Entries to G/L Budget")
        {
            ApplicationArea = Basic;
        }



    }
}
