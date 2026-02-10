namespace MNS.MNS;

using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Foundation.Company;
using Microsoft.FixedAssets.Ledger;
using Microsoft.FixedAssets.Depreciation;

report 52185960 "Fixed Assets By Category"
{
    ApplicationArea = All;
    Caption = 'Fixed Assets By Category';
    RDLCLayout = './bc-kenpipe-2024/Layout/Fixed Assets By Category.rdl';

    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            RequestFilterFields = "FA Class Code", "FA Location Code", "FA Posting Group", "FA Subclass Code";
            column(AssetNo; "No.")
            {
            }
            column(FADescription; Description)
            {
            }
            column(AcquistionCost; AcquisitionCost) { }
            column(AcquisitionDate; AcquisitionDate) { }
            column(FAClassCode; "FA Class Code")
            {
            }
            column(FALocationCode; "FA Location Code")
            {
            }
            column(FAPostingGroup; "FA Posting Group")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(FASubclassCode; "FA Subclass Code")
            {
            }
            column(Description; Description)
            {
            }
            column(Createdat; "Created at")
            {
            }
            column(WrittenDownValue; WrittenDownValue)
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
            var
                myInt: Integer;
            begin
                WrittenDownValue := 0;
                AcquisitionCost := 0;
                AcquisitionDate := 0D;

                FADepBook.RESET;
                FADepBook.SETRANGE("FA No.", FixedAsset."No.");
                if FADepBook.find('-') then begin
                    FADepBook.CALCFIELDS("Write-Down", "Acquisition Cost");
                    WrittenDownValue := FADepBook."Write-Down";
                    AcquisitionCost := FADepBook."Acquisition Cost";
                    AcquisitionDate := FADepBook."Acquisition Date";
                end;

                if FixedAsset."Created at" = 0D then begin
                    FixedAsset."Created at" := FixedAsset."Purchase Date";
                end

                // FALedgerEntry.RESET;
                // FALedgerEntry.SETRANGE("FA No.", FixedAsset."Asset No.");
                // FALedgerEntRy.Setrange("FA Posting Type", FALedgerEntry."FA Posting Type"::"Acquisition Cost");
                // if FALedgerEntry.FIND('-') then
                // //FALedgerEntry.CALCFIELDS("Amount (LCY)");
                //     AcquisitionCost := FALedgerEntry."Amount (LCY)";
                //     AcquisitionDate := FALedgerEntry."Posting Date";
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
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    Var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        FADepBook: Record "FA Depreciation Book";
        WrittenDownValue: Decimal;
        AcquisitionCost: Decimal;
        FALedgerEntry: Record "FA Ledger Entry";
        AcquisitionDate: Date;
}
