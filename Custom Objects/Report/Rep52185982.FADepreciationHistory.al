namespace MNS.MNS;

using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Foundation.Company;
using Microsoft.FixedAssets.Depreciation;
using Microsoft.FixedAssets.Ledger;

report 52185996 "FA Depreciation History"

{
    ApplicationArea = All;
    Caption = 'FA Depreciation History';
    UsageCategory = ReportsAndAnalysis;

    DefaultLayout = rdlc;
    RDLCLayout = './bc-azima-2026/Layout/FA Depreciation History.rdl';

    dataset
    {
        dataitem("FA Ledger Entry"; "FA Ledger Entry")
        {
            RequestFilterFields = "Posting Date", "FA No.", "FA Class Code";
            DataItemTableView = Where("FA Posting Type" = Const(Depreciation));
            column(Entry_No_; "Entry No.") { }
            column(FANo; "FA No.") { }
            column(AssetDescription; AssetDescription) { }
            column(Posting_Date; "Posting Date") { }
            column(FA_Posting_Type; "FA Posting Type") { }
            column(Amount; DepAmt) { }
            column(AssetCategory; AssetCategory) { }
            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }
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
            dataitem("Fixed Asset"; "Fixed Asset")
            {

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                AssetCategory := ' ';
                AssetDescription := ' ';
                DepAmt := 0;


                DepAmt := "FA Ledger Entry".Amount;
                if DepAmt < 0 then
                    DepAmt := DepAmt * -1;

                FA.Reset();
                FA.SETRANGE("No.", "FA Ledger Entry"."FA No.");
                if FA.Find('-') then begin
                    AssetCategory := FA."FA Class Code";
                    AssetDescription := FA.Description;
                end;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
                "FA Ledger Entry".SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
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
                field(StartDate; StartDate)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
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
        if StartDate = 0D then Error('Start Date must be specified.');
        if EndDate = 0D then Error('End Date must be specified.');
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
        FA: Record "Fixed Asset";
        AssetCategory: Code[100];
        StartDate: Date;
        EndDate: Date;
        AssetDescription: Text[100];
        DepAmt: Decimal;
}
//         dataitem(FixedAsset; "Fixed Asset")
//         {
//             RequestFilterFields = "No.", "FA Class Code", "FA Location Code";
//             column(No; "No.")
//             {
//             }
//             column(Description; Description)
//             {
//             }
//             column(FAClassCode; "FA Class Code")
//             {
//             }
//             column(AccumulatedDepreciation; AccumulatedDepreciation)
//             {
//             }
//             column(DepreciationPeriod; DepreciationPeriod)
//             {
//             }
//             column(StartDate; StartDate) { }
//             column(EndDate; EndDate) { }
//             //column(DepreciationDate; DepreciationDate) { }
//             column(DateAcquired; DateAcquired) { }
//             column(BookValue; BookValue) { }
//             column(NBV; NBV) { }
//             column(AcquisitionCost; AcquisitionCost) { }
//             column(DepreciationPerPeriod; DepreciationPerPeriod)
//             {
//             }
//             column(CompanyInformation_Name; CompanyInformation.Name)
//             {
//             }
//             column(CompanyInformation_Picture; CompanyInformation.Picture)
//             {
//             }
//             column(CompanyAddress; CompanyAddress)
//             {
//             }
//             column(CompanyTelephone; CompanyTelephone)
//             {
//             }
//             column(CommunicationOnline; CommunicationOnline)
//             {
//             }
//             dataitem(FADepreciationBook; "FA Depreciation Book")
//             {
//                 //DataItemLink = FixedAsset;
//                 DataItemLink = "FA No." = Field("No.");
//             }
//             dataitem("FA Ledger Entry"; "FA Ledger Entry")
//             {
//                 DataItemLink = "FA No." = Field("No.");
//                 column(DepreciationDate; "Posting Date") { }
//                 column(Amount; Amount) { }

//                 trigger OnAfterGetRecord()
//                 var
//                     myInt: Integer;

//                 begin
//                     AccumulatedDepreciation := 0;
//                     DepreciationDate := 0D;
//                     DateAcquired := 0D;
//                     BookValue := 0;
//                     NBV := 0;
//                     AcquisitionCost := 0;

//                     FALedgerEntries.Reset;
//                     FALedgerEntries.SetRange("FA No.", FixedAsset."No.");
//                     FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::Depreciation);
//                     if FALedgerEntries.Find('-') then begin
//                         repeat
//                             DepreciationPerPeriod := FALedgerEntries.Amount;
//                             FALedgerEntries.CalcSums(Amount);
//                             AccumulatedDepreciation := FALedgerEntries.Amount;
//                             DepreciationDate := FALedgerEntries."Posting Date";
//                         until FALedgerEntries.Next = 0;
//                     end;

//                     FADepBook.RESET;
//                     FADepBook.SETRANGE("FA No.", FixedAsset."No.");
//                     if FADepBook.FIND('-') then begin
//                         FADepBook.CALCFIELDS("Book Value");
//                         AcquisitionCost := FADepBook."Acquisition Cost";
//                         DateAcquired := FADepBook."Acquisition Date";
//                         BookValue := FADepBook."Book Value";
//                     end;

//                     NBV := AcquisitionCost - AccumulatedDepreciation;
//                 end;

//                 trigger OnPreDataItem()
//                 var
//                     myInt: Integer;
//                 begin
//                     FALedgerEntries.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
//                 end;
//             }
//         }
//     }



//     // trigger OnAfterGetRecord()
//     // var
//     //     myInt: Integer;

//     // begin
//     //     AccumulatedDepreciation := 0;


//     //     FALedgerEntries.Reset;
//     //     FALedgerEntries.SetRange("FA No.", FixedAsset."No.");
//     //     FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::Depreciation);
//     //     if FALedgerEntries.Find('-') then begin
//     //         repeat
//     //             FALedgerEntries.CalcSums(Amount);
//     //             AccumulatedDepreciation := FALedgerEntries.Amount;
//     //         until FALedgerEntries.Next = 0;
//     //     end;

//     // end;
//     //     }
//     // }
//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {
//                 field(StartDate; StartDate)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Start Date';
//                 }
//                 field(EndDate; EndDate)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'End Date';
//                 }
//             }
//         }
//         actions
//         {
//             area(processing)
//             {
//             }
//         }
//     }

//     trigger OnPreReport()
//     begin
//         if CompanyInformation.Get then
//             CompanyInformation.CalcFields(CompanyInformation.Picture);
//         CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
//         CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
//         CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
//     end;

//     var
//         CompanyInformation: Record "Company Information";
//         CompanyAddress: Text;
//         CompanyTelephone: Text;
//         CommunicationOnline: Text;
//         FALedgerEntries: Record "FA Ledger Entry";
//         AccumulatedDepreciation: Decimal;
//         DepreciationPerPeriod: Decimal;
//         DepreciationPeriod: Integer;
//         StartDate: Date;
//         EndDate: Date;
//         DepreciationDate: Date;
//         FADepBook: Record "FA Depreciation Book";
//         DateAcquired: Date;
//         BookValue: Decimal;
//         NBV: Decimal;
//         AcquisitionCost: Decimal;
// }
