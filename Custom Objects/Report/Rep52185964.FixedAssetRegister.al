namespace MNS.MNS;

using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Foundation.Company;
using Microsoft.Purchases.Document;
using Microsoft.FixedAssets.Insurance;
using Microsoft.FixedAssets.Journal;
using Microsoft.FixedAssets.Ledger;
using Microsoft.FixedAssets.Depreciation;
using Microsoft.FixedAssets.Setup;

report 52185964 "Fixed Asset Register"
{
    ApplicationArea = All;
    Caption = 'Fixed Asset Register';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Fixed Asset Register.rdl';
    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            RequestFilterFields = "No.", "FA Class Code", "Acquisition Date", "Location Code", "Responsible Employee", "Responsibility Center", "Global Dimension 1 Code", "Global Dimension 2 Code";
            CalcFields = "Acquisition Date";
            column(AssetNo; "No.") { }
            column(FADescription; Description) { }
            column(MemorandumNotes; "Comment") { }
            column(DepreciationType; FADepreciationMethod) { }
            column(AdditionDate; "Created at") { }
            column(AcquisitionDate; AcquisitionDate) { }
            column(DepreciationStartDate; DepreciationStartDate) { }
            column(DepreciationEndDate; DepreciationEndDate) { }
            column(BarCode; "Asset Tag") { }
            column(OldBarCode; "Old Asset Tag") { }
            column(AssetFloor; "Asset Location") { }
            column(ActivityCode; "Global Dimension 2 Code") { }
            column(BranchCode; "Global Dimension 1 Code") { }
            column(Status; "Asset Status") { }
            column(MainAssetComponent; "Main Asset/Component") { }
            column(DisposalDate; DisposalDate) { }
            column(AssetCategory; "FA Class Code") { }
            column(AssetSubCategory; "FA Subclass Code") { }
            column(AssetLife; AssetLife) { }
            column(RemainingLife; RemainingLife) { }
            column(Marked_for_Disposal; "Marked for Disposal") { }
            column(DisposalValue; DisposalValue) { }
            column(Purchase_Price; AcquisitionCost) { }
            column(WriteDownValue; WriteDownValue) { }
            column(AccumulatedDepreciation; AccumulatedDepreciation) { }
            column(Adjustments; Adjustments) { }
            column(InsuranceValue; InsuranceValue) { }
            column(DisposalProceeds; DisposalProceeds) { }
            column(Purchase_Vendor_Company; "Purchase Vendor/Company") { }

            column(InvoiceNumber; InvoiceNumber) { }
            column(InvoiceDate; InvoiceDate) { }
            column(VendorReference; VendorReference) { }
            column(FALocation; FALocationName) { }
            column(Department; "Responsibility Center") { }
            column(SerialNumber; "Serial No.") { }
            column(NetBookValue; NetBookValue) { }
            column(ResponsibleEmployeePFNo; "Employee Responsible") { }
            column(ResponsibleEmployeeName; "Responsible Employee Name") { }
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
            var
                myInt: Integer;
            begin
                AccumulatedDepreciation := 0;
                DepreciationAmount := 0;
                DepreciationEndDate := 0D;
                DepreciationEndDateYear := 0;
                DepreciationStartDateYear := 0;
                DepreciationStartDate := 0D;
                TodayYear := 0;
                AssetLife := 0;
                RemainingLife := 0;
                FALocationName := ' ';
                WriteDownValue := 0;
                DisposalValue := 0;
                DisposalDate := 0D;
                DepreciationAmount := 0;
                Adjustments := 0;
                BookValue := 0;
                InsuranceValue := 0;
                DisposalProceeds := 0;
                FADepreciationMethod := '';
                InvoiceNumber := '';
                InvoiceDate := 0D;
                VendorReference := '';
                AcquisitionCost := 0;
                AcquisitionDate := 0D;
                NetBookValue := 0;



                FALocation.RESET;
                FALocation.SETRANGE(FALocation."Code", FixedAsset."FA Location Code");
                if FALocation.FINDFIRST then begin
                    FALocationName := FALocation.Name;
                end;

                DepreciationBook.RESET;
                DepreciationBook.Setrange("FA No.", FixedAsset."No.");
                //if DepreciationBook.Get(FixedAsset."No.") then
                if DepreciationBook.Find('-') then begin
                    DepreciationBook.CalcFields("Write-Down", "Depreciation", "Book Value", "Proceeds on Disposal", "Acquisition Cost");
                    DepreciationStartDate := DepreciationBook."Depreciation Starting Date";
                    DepreciationEndDate := DepreciationBook."Depreciation Ending Date";
                    DisposalDate := DepreciationBook."Disposal Date";
                    WriteDownValue := DepreciationBook."Write-Down";
                    DepreciationAmount := DepreciationBook."Depreciation";
                    BookValue := DepreciationBook."Book Value";
                    DisposalProceeds := DepreciationBook."Proceeds on Disposal";
                    FADepreciationMethod := Format(DepreciationBook."Depreciation Method");
                    //AcquisitionCost := DepreciationBook."Acquisition Cost";
                    AcquisitionDate := DepreciationBook."Acquisition Date";
                end;


                FALedgerEntry.RESET;
                FALedgerEntry.SetRange("FA Posting Category", FALEDGERENTRY."FA Posting Category"::Disposal);
                FALedgerEntry.SetRange("FA No.", FixedAsset."No.");
                if FALedgerEntry.Find('-') then begin
                    FALedgerEntry.CalcSums(Amount);
                    DisposalValue := FALedgerEntry.Amount;
                end;
                FALedgerEntry.RESET;
                FALedgerEntry.SetRange("FA Posting Type", FALEDGERENTRY."FA Posting Type"::Depreciation);
                FALedgerEntry.SetRange("FA No.", FixedAsset."No.");
                if (StartDate <> 0D) and (EndDate <> 0D) then
                    FALedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                if FALedgerEntry.Find('-') then begin
                    FALedgerEntry.CalcSums(Amount);
                    AccumulatedDepreciation := FALedgerEntry.Amount;
                end;
                FALedgerEntry.RESET;
                FALedgerEntry.SetRange("FA Posting Type", FALEDGERENTRY."FA Posting Type"::"Acquisition Cost");
                FALedgerEntry.SetRange("FA No.", FixedAsset."No.");
                if (StartDate <> 0D) and (EndDate <> 0D) then
                    FALedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                if FALedgerEntry.Find('-') then begin
                    FALedgerEntry.CalcSums(Amount);
                    AcquisitionCost := FALedgerEntry.Amount;
                end;

                FAReClass.RESET;
                FAReClass.SETRANGE("FA No.", FixedAsset."No.");
                if FAReClass.find('-') then begin
                    if FAReclass."Reclassify Acq. Cost %" > 0 THEN begin
                        if FAReClass."Reclassify Acquisition Cost" then
                            Adjustments := (FAReClass."Reclassify Acq. Cost %" / 100) * AcquisitionCost
                        else
                            if FAReClass."Reclassify Depreciation" then
                                Adjustments := (FAReClass."Reclassify Acq. Cost %" / 100) * BookValue
                            else
                                exit;
                    end;
                end;

                Insurance.Reset;
                Insurance.SetRange("Fixed Asset No.", FixedAsset."No.");
                if Insurance.Find('-') then begin
                    InsuranceValue := Insurance."Total Value Insured";
                end;

                PurchaseQuote.RESET;
                PurchaseQuote.SETRANGE("Pay-to Vendor No.", FixedAsset."Vendor No.");
                PurchaseQuote.SETRANGE("Document Type", PurchaseQuote."Document Type"::Invoice);
                PurchaseQuote.SetRange("Document Date", FixedAsset."Purchase Date");
                if PurchaseQuote.find('-') then begin
                    InvoiceNumber := PurchaseQuote."No.";
                    InvoiceDate := PurchaseQuote."Document Date";
                    VendorReference := PurchaseQuote."Payment Reference";
                end;

                if DepreciationStartDate <> 0D then begin
                    if DepreciationEndDate <> 0D then begin
                        DepreciationEndDateYear := Date2DMY(DepreciationEndDate, 3);
                        DepreciationStartDateYear := Date2DMY(DepreciationStartDate, 3);
                        TodayYear := Date2DMY(Today, 3);
                        AssetLife := (DepreciationEndDateYear - DepreciationStartDateYear);
                        RemainingLife := (DepreciationEndDateYear - TodayYear);
                    end;
                end;
                //NetBookValue := BookValue - AccumulatedDepreciation;
                NetBookValue := AcquisitionCost + AccumulatedDepreciation;

                // DepreciationEndDateYear := Date2DMY(DepreciationEndDate, 3);
                // DepreciationStartDateYear := Date2DMY(DepreciationStartDate, 3);
                // TodayYear := Date2DMY(Today, 3);
                // Assetlife := (DepreciationEndDateYear - DepreciationStartDateYear);
                // RemainingLife := (TodayYear - DepreciationEndDateYear);
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
                    Caption = 'Period';

                    field(StartDate; StartDate)
                    {
                        Caption = 'From Date';
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'To Date';
                    }
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
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        FALocation: Record "FA Location";
        FALocationName: Text;
        DepreciationBook: Record "FA Depreciation Book";
        DepreciationStartDate: Date;
        FALedgerEntry: Record "FA Ledger Entry";
        MethodofDisposal: Text;
        DisposalValue: Decimal;
        DisposalDate: Date;
        DepreciationEndDate: Date;
        AssetLife: Integer;
        RemainingLife: Integer;
        DepreciationEndDateYear: Integer;
        DepreciationStartDateYear: Integer;
        TodayYear: Integer;
        WriteDownValue: Decimal;
        DepreciationAmount: Decimal;
        FAReClass: Record "FA Reclass. Journal Line";
        Adjustments: Decimal;
        BookValue: Decimal;
        Insurance: Record Insurance;
        InsuranceValue: Decimal;
        DisposalProceeds: Decimal;
        FADepreciationMethod: Text;
        PurchaseQuote: Record "Purchase Header";
        InvoiceNumber: Text;
        InvoiceDate: Date;
        VendorReference: Text;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        AcquisitionCost: Decimal;
        AcquisitionDate: Date;
        NetBookValue: Decimal;
        AccumulatedDepreciation: Decimal;
        StartDate: Date;
        EndDate: Date;

}
