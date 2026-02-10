// namespace MNS.MNS;

// using Microsoft.FixedAssets.Insurance;
// using Microsoft.FixedAssets.Ledger;
// using Microsoft.Foundation.Company;

// report 52185995 "Insurance Valuation Report"
// {
//     ApplicationArea = All;
//     Caption = 'Insurance Valuation Report';
//     UsageCategory = ReportsAndAnalysis;
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Insurance Valuation Report.rdl';

//     dataset
//     {
//         dataitem(Insurance; Insurance)
//         {
//             DataItemTableView = where("Insurance Status" = const(Expired));
//             column(FAClassCode; "FA Class Code")
//             {
//             }
//             column(No; "No.")
//             {
//             }
//             column(FixedAssetNo; "Fixed Asset No.")
//             {
//             }
//             column(InsurancePolicyNo; "Policy No.")
//             {
//             }
//             column(AssetDescription; "Description")
//             {
//             }
//             column(DateofValuation; DateofValuation)
//             {
//             }
//             column(InsuranceValue; "Annual Premium")
//             {
//             }
//             column(InsuranceClaimsAmount; InsuranceClaimsAmount)
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
//             trigger OnAfterGetRecord()
//             var
//                 myInt: Integer;
//             begin
//                 FALedgerEntries.RESET;
//                 FALedgerEntries.SetRange("FA No.", Insurance."Fixed Asset No.");
//                 FALedgerEntries.SetFilter("FA Posting Type", '%1|%2', FALedgerEntries."FA Posting Type"::"Write-Down", FALedgerEntries."FA Posting Type"::"Appreciation");
//                 if FALedgerEntries.FindLast() then begin
//                     DateofValuation := FALedgerEntries."Posting Date";
//                 end;


//                 InsuranceClaims.RESET;
//                 InsuranceClaims.SetRange("Asset No.", Insurance."Fixed Asset No.");
//                 if InsuranceClaims.find('-') then begin
//                     InsuranceClaims.CalcSums("Amount in Claims");
//                     InsuranceClaimsAmount := InsuranceClaims."Amount in Claims";

//                 end;

//             end;


//             //AsseLedgeerEntries Posting type = Writedown and appreciation

//             //             i.	Asset category
//             // ii.	Insurance policy number
//             // iii.	Date of valuation
//             // iv.	Insurance value
//             // v.	Insurance claims

//         }
//     }
//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {
//                 group(GroupName)
//                 {
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
//         DateofValuation: Date;
//         FALedgerEntries: Record "FA Ledger Entry";
//         InsuranceClaims: Record "Insurance Claims";
//         InsuranceClaimsAmount: Decimal;

//         CompanyInformation: Record "Company Information";
//         CompanyAddress: Text;
//         CompanyTelephone: Text;
//         CommunicationOnline: Text;

// }

