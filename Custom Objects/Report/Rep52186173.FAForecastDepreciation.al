namespace MNS.MNS;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.FixedAssets.Ledger;
using Microsoft.FixedAssets.Depreciation;
using Microsoft.Foundation.Company;

report 52186173 "FA Forecast Depreciation"
{
    ApplicationArea = All;
    Caption = 'FA Forecast Depreciation';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/FA Forecast Depreciation.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            RequestFilterFields = "No.";
            Column(FANo; "No.") { }
            column(Description; Description) { }
            column(DateOfDisposal; DateOfDisposal) { }
            column(Period; DepreciationPeriod) { }
            column(DepStartDate; DepStartDate) { }
            column(EndDate; DepEndDate) { }
            column(DepreciationForecast; DepreciationForecast) { }
            //column(ForecastWrittenDownValue; ForecastWrittenDownValue) { }
            column(DepreciationPeriod; DepreciationPeriod) { }
            column(RemainingAssetLife; RemainingAssetLife) { }
            column(TodayYear; TodayYear) { }
            column(AccumulatedDepreciation; AccumulatedDepreciation) { }
            column(AcquistionCost; AcquistionCost) { }
            column(WritedownValue; WritedownValue) { }
            column(DepreciationRate; DepreciationRate) { }
            column(NetBookValue; NetBookValue) { }
            // Forecast depreciation report (showing the expected depreciation over a given number of user-defined periods)
            // i. Asset reference code
            // ii. Asset description
            // iii. Date of disposal
            // iv. Period
            // v. Depreciation forecast.
            // vi. Forecast written down value
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
                DepreciationPeriod := 0;
                RemainingAssetLife := 0;
                TodayYear := 0;
                DepreciationEndDateYear := 0;
                AcquistionCost := 0;
                AccumulatedDepreciation := 0;
                WritedownValue := 0;
                TodayYear := Date2DMY(Today, 3);

                FALedgerEntry.RESET;
                FALedgerEntry.SETRANGE("FA No.", FixedAsset."No.");
                FALedgerEntry.SetFilter("FA Posting Type", '%1|%2|%3', FALedgerEntry."FA Posting Type"::Depreciation, FALedgerEntry."FA Posting Type"::"Acquisition Cost", FALedgerEntry."FA Posting Type"::"Write-Down");
                if FALedgerEntry.FindSet() then begin
                    repeat
                        if FALedgerEntry."FA Posting Type" = FALedgerEntry."FA Posting Type"::"Acquisition Cost" then begin
                            AcquistionCost := FALedgerEntry.Amount;
                        end;
                        if FALedgerEntry."FA Posting Type" = FALedgerEntry."FA Posting Type"::Depreciation then begin
                            AccumulatedDepreciation := FALedgerEntry.Amount;
                        end;
                        if FALedgerEntry."FA Posting Category" = FALedgerEntry."FA Posting Category"::Disposal then begin
                            DateOfDisposal := FALedgerEntry."Posting Date";
                        end;
                        if FALedgerEntry."FA Posting Type" = FALedgerEntry."FA Posting Type"::"Write-Down" then begin
                            WritedownValue := FALedgerEntry.Amount;
                        end;
                    until FAledgerEntry.Next() = 0;
                end;


                DepreciationForecast := AcquistionCost - AccumulatedDepreciation;
                NetBookValue := AcquistionCost - AccumulatedDepreciation;

                FADepreciationBook.RESET;
                FADepreciationBook.SETRANGE("FA No.", FixedAsset."No.");
                if FADepreciationBook.Find('-') then begin
                    DepStartDate := FADEPRECIATIONBOOK."Depreciation Starting Date";
                    DepEndDate := FADepreciationBook."Depreciation Ending Date";
                    DepreciationRate := FADepreciationBook."Straight-Line %";
                    //DepreciationPeriod := Round((FADepreciationBook."No. of Depreciation Years"), 0.1, '=');
                    DepreciationPeriod := Round((FADepreciationBook."No. of Depreciation Years"), 0.01, '=');


                    //DepreciationPeriod := FADepreciationBook."No. of Depreciation Years";
                    // if FADepreciationBook."Depreciation Ending Date" = 0D then begin
                    //     DepreciationPeriodYears := ROUND(FADepreciationBook."No. of Depreciation Years");
                    //     Evaluate(DepreciationPeriodYearsDateFormula, Format(DepreciationPeriodYears));
                    //     DepreciationPeriodYearsDateFormula += 'Y';
                    //     // Message('DepreciationPeriond: %1', DepreciationPeriodYearsDateFormula);
                    //     FADEPRECIATIONBOOK."Depreciation Ending Date" := CalcDate(DepreciationPeriodYearsDateFormula, FADepreciationBook."Depreciation Starting Date");
                    //     DepreciationEndDateYear := Date2DMY(FADepreciationBook."Depreciation Ending Date", 3);
                    // end
                    // Else
                    //     //DepreciationEndDateYear := Date2DMY(FADepreciationBook."Depreciation Ending Date", 3);
                    //     DepreciationEndDateYear := Date2DMY(FADepreciationBook."Depreciation Ending Date", 3);
                end;

                RemainingAssetLife := DepreciationEndDateYear - TodayYear;
                //RemainingAssetLife := DepreciationEndDateYear - Today;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
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
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        FADepreciationBook: Record "FA Depreciation Book";
        DepreciationPeriod: Decimal;
        RemainingAssetLife: Integer;
        TodayYear: Integer;
        DepreciationEndDateYear: Integer;
        FALedgerEntry: Record "FA Ledger Entry";
        AccumulatedDepreciation: Decimal;
        DepreciationForecast: Decimal;
        AcquistionCost: Decimal;
        DateOfDisposal: Date;
        WritedownValue: Decimal;
        DepreciationPeriodYears: Decimal;
        DepreciationPeriodYearsDateFormula: Text;
        DepreciationRate: Decimal;
        NetBookValue: Decimal;
        DepStartDate: Date;
        DepEndDate: Date;
}
