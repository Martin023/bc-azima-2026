namespace MNS.MNS;

using Microsoft.FixedAssets.FixedAsset;
using Microsoft.FixedAssets.Depreciation;
using Microsoft.FixedAssets.Ledger;
using Microsoft.FixedAssets.Setup;
using Microsoft.Foundation.Company;

report 52186072 "Right To Use Assets"
{
    ApplicationArea = All;
    Caption = 'Right To Use Assets';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Right To Use Assets.rdl';
    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            RequestFilterFields = "No.", "Acquisition Type", "FA Class Code";
            // DataItemTableView = WHERE("FA Class Code" = FILTER('OPLEASE'));
            Calcfields = "Responsible Employee Name";
            column(No; "No.")
            {
            }
            column(Asset_Tag; "Asset Tag") { }

            column(Description; Description)
            {
            }
            column(CurrentAssetLocation; AssetLocation) { }
            column(Serial_No_; "Serial No.") { }
            column(AssetStatus; "Asset Status") { }
            column(AcquisitionDate; AcquisitionDate) { }
            column(DisposalDate; DisposalDate) { }
            column(FA_Posting_Group; "FA Posting Group") { }
            column(AcquisitionCost; AcquisitionCost) { }
            column(AccDepreciationAmt; AccDepreciationAmt) { }
            column(DepThisYear; DepThisYear) { }
            column(NetBookValue; NetBookValue) { }
            column(FADepBookCode; FADepBookCode) { }
            column(FA_Depreciation_Book_Code; FADepreciationBook) { }
            column(GainLoss; GainLoss) { }
            column(Custom1; Custom1) { }
            column(BranchCode; "Global Dimension 1 Code") { }
            column(ActivityCode; "Global Dimension 2 Code") { }
            column(Responsible_Employee; "Employee Responsible") { }
            column(Responsible_Employee_Name; "Responsible Employee Name") { }

            column(FAClassCode; "FA Class Code")
            {
            }
            column(FASubclassCode; "FA Subclass Code")
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            trigger OnAfterGetRecord()
            begin
                FADepreciationBook := '';
                AssetLocation := '';
                FADepBookCode := '';
                AccDepreciationAmt := 0;
                AcquisitionCost := 0;
                AcquisitionDate := 0D;
                DisposalDate := 0D;
                NetBookValue := 0;
                GainLoss := 0;
                Custom1 := 0;
                AssetLocation := '';


                FALedgerEntry.RESET;
                FALedgerEntry.SetRange("FA Posting Type", FALedgerEntry."FA Posting Type"::Depreciation);
                FALedgerEntry.SETRANGE("FA No.", FixedAsset."No.");
                FALedgerEntry.SetFilter("FA Posting Date", '%1..%2', CalcDate('-CY', Today), Today);
                if FALedgerEntry.Find('-') THEN BEGIN
                    FALedgerEntry.CALCSUMS(Amount);
                    DepThisYear := FALedgerEntry.Amount;
                END;

                FALocations.RESET;
                FALocations.SetRange("Code", FixedAsset."FA Location Code");
                if FALocations.Find('-') then begin
                    AssetLocation := FALocations.Name;
                end;

                FADEpBook.RESET;
                FADEpBook.SETRANGE("FA No.", FixedAsset."No.");
                if FADEpBook.FIND('-') then begin
                    FADepBookCode := FADEpBook."Depreciation Book Code";
                    FADepreciationBook := FADEpBook.Description;
                end;

                FALedgerEntry.Reset();
                FALedgerEntry.SetRange("FA No.", FixedAsset."No.");
                FALedgerEntry.SetLoadFields("FA Posting Type", "Amount", "Posting Date");
                FALedgerEntry.SetRange("FA Posting Type", FALedgerEntry."FA Posting Type"::"Acquisition Cost");
                if FALedgerEntry.Find('-') then begin
                    AcquisitionCost := FALedgerEntry.Amount;
                    AcquisitionDate := FALedgerEntry."Posting Date";
                end;

                FALedgerEntry.Reset();
                FALedgerEntry.SetRange("FA No.", FixedAsset."No.");
                FALedgerEntry.SetLoadFields("FA Posting Type", "Amount", "Posting Date");
                FALedgerEntry.SetRange("FA Posting Type", FALedgerEntry."FA Posting Type"::Depreciation);
                if FALedgerEntry.Find('-') then begin
                    FALedgerEntry.CalcSums(Amount);
                    AccDepreciationAmt := FALedgerEntry.Amount;
                end;

                FALedgerEntry.Reset();
                FALedgerEntry.SetRange("FA No.", FixedAsset."No.");
                FALedgerEntry.SetLoadFields("FA Posting Type", "Amount", "Posting Date");
                FALedgerEntry.SetRange("FA Posting Type", FALedgerEntry."FA Posting Type"::"Custom 1");
                if FALedgerEntry.Find('-') then begin
                    FALedgerEntry.CalcSums(Amount);
                    Custom1 := FALedgerEntry.Amount;
                end;

                FALedgerEntry.Reset();
                FALedgerEntry.SetRange("FA No.", FixedAsset."No.");
                FALedgerEntry.SetLoadFields("FA Posting Type", "Amount", "Posting Date");
                FALedgerEntry.SetRange("FA Posting Type", FALedgerEntry."FA Posting Type"::"Gain/Loss");
                if FALedgerEntry.Find('-') then begin
                    FALedgerEntry.CalcSums(Amount);
                    GainLoss := FALedgerEntry.Amount;
                end;

                FALedgerEntry.RESET;
                FALedgerEntry.SETRANGE("FA No.", FixedAsset."No.");
                FALedgerEntry.SetRange("FA Posting Category", FALedgerEntry."FA Posting Category"::Disposal);
                if FALedgerEntry.FIND('-') then begin
                    DisposalDate := FALedgerEntry."Posting Date";
                end;

                NetBookValue := AcquisitionCost + AccDepreciationAmt;

            end;
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    Local procedure GetCurrentYearDepreciation(var FixedAsset: Record "Fixed Asset"): Decimal
    var
        FALedgerEntries: Record "FA Ledger Entry";
    begin

        // FALedgerEntries.RESET;
        // FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::Depreciation);
        // FALedgerEntries.SETRANGE("FA No.", FixedAsset."No.");
        // FALedgerEntries.SetFilter("FA Posting Date", '%1..%2', CalcDate('-CY', Today), Today);
        // if FALedgerEntries.Find('-') THEN BEGIN
        //     FALedgerEntries.CALCSUMS(Amount);
        //     DepThisYear := FALedgerEntries.Amount;
        // END;
    end;

    trigger OnPreReport()
    Var
        FALEdgerEntries: Record "FA Ledger Entry";
    begin

        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";



    end;

    Var
        FADepBook: Record "FA Depreciation Book";
        AccDepreciationAmt: Decimal;
        FALedgerEntry: Record "FA Ledger Entry";
        PostingDate: Date;
        DepreciationDescription: Text;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        AcquisitionCost: Decimal;
        AcquisitionDate: Date;
        FALocations: Record "FA Location";
        AssetLocation: Text;
        Custom1: Decimal;
        DisposalDate: Date;
        NetBookValue: Decimal;
        GainLoss: Decimal;
        FADepBookCode: Code[50];
        FADepreciationBook: Text;
        DepThisYear: Decimal;
}
