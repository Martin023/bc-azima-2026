namespace MNS.MNS;

using Microsoft.FixedAssets.FixedAsset;
using Microsoft.FixedAssets.Setup;
using Microsoft.FixedAssets.Ledger;
using Microsoft.Foundation.Company;
using Microsoft.FixedAssets.Depreciation;

report 52185951 "Assets Marked For Disposal"
{
    ApplicationArea = All;
    Caption = 'Assets Marked For Disposal';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Assets Marked For Disposal.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            DataItemTableView = where("Marked for Disposal" = const(true));
            RequestFilterFields = "No.", "FA Class Code", "FA Location Code";
            column(AssetNo; "No.") { }
            column(GainLossValue; GainLossValue) { }
            column(BookValue; BookValue) { }
            column(Asset_Status; "Asset Status") { }
            column(AcquisitionCost; AcquisitionCost) { }
            column(AcquisitionDate; AcquisitionDate) { }
            column(FALocationName; FALocationName)
            {
            }
            column(Description; Description)
            {
            }
            // column(PurchaseDate; "Purchase Date")
            // {
            // }
            column(Marked_for_Disposal; "Marked for Disposal")
            {
            }
            column(YearofPurchase; YearofPurchase)
            {
            }
            COLUMN(MethodofDisposal; MethodofDisposal)
            {
            }
            column(DisposalValue; DisposalValue)
            {
            }
            column(FA_Location_Code; "FA Location Code")
            {
            }
            column(AssetCondition; "Asset Status")
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
                MethodofDisposal := '';
                DisposalValue := 0;
                YearofPurchase := 0;
                BookValue := 0;
                GainLossValue := 0;
                AcquisitionCost := 0;
                AcquisitionDate := 0D;

                //FALedgerEntry.Get(FixedAsset."Asset No.");
                FADepBook.RESET;
                FADepBook.SETRANGE("FA No.", FixedAsset."No.");
                if FADepBook.find('-') then begin
                    FADepBook.CalcFields("Gain/Loss", "Book Value", "Acquisition Cost");
                    GainLossValue := FADepBook."Gain/Loss";
                    BookValue := FADepBook."Book Value";
                    AcquisitionCost := FADepBook."Acquisition Cost";
                    AcquisitionDate := FADepBook."Acquisition Date";
                end;

                YearofPurchase := Date2DMY(AcquisitionDate, 3);

                FALedgerEntry.Reset();
                FALedgerEntry.SetRange("FA Posting Category", FALEDGERENTRY."FA Posting Category"::Disposal);
                FALedgerEntry.SetRange("FA No.", FixedAsset."No.");
                if FALedgerEntry.Find('-') then begin
                    //FALedgerEntry.CalcFields(Amount);
                    if FALedgerEntry.Amount = 0 then begin
                        MethodofDisposal := 'Writeoff';
                    end
                    else
                        if FALedgerEntry.Amount > 0 then begin
                            MethodofDisposal := 'Sale';
                            DisposalValue := FALedgerEntry.Amount;
                        end;
                end;

                FALocation.RESET;
                FALocation.SETRANGE(FALocation."Code", FixedAsset."FA Location Code");
                if FALocation.FINDFIRST then
                    FALocationName := FALocation."Name";
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
        FALedgerEntry: Record "FA Ledger Entry";
        MethodofDisposal: Text;
        DisposalValue: Decimal;
        FALocation: Record "FA Location";
        FALocationName: Text;
        YearofPurchase: Integer;
        FADepBook: Record "FA Depreciation Book";
        BookValue: Decimal;
        GainLossValue: Decimal;
        AcquisitionCost: Decimal;
        AcquisitionDate: Date;
}
