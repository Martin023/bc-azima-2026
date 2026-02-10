// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185649 "BBF Claim Voucher"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/BBF Claim Voucher.rdl';

//     dataset
//     {
//         dataitem("Payments Header"; "Payments Header")
//         {
//             RequestFilterFields = "No.";
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(No_PaymentsHeader; "Payments Header"."No.")
//             {
//             }
//             column(Date_PaymentsHeader; "Payments Header".Date)
//             {
//             }
//             column(ChequeNo_PaymentsHeader; "Payments Header"."Cheque No.")
//             {
//             }
//             column(AccountType_PaymentsHeader; "Payments Header"."Account Type")
//             {
//             }
//             column(AccountNo_PaymentsHeader; "Payments Header"."Account No.")
//             {
//             }
//             column(Name_PaymentsHeader; "Payments Header".Name)
//             {
//             }
//             column(OnBehalfOf_PaymentsHeader; "Payments Header"."On Behalf Of")
//             {
//             }
//             column(PaymentNarration_PaymentsHeader; "Payments Header"."Payment Narration")
//             {
//             }
//             column(PaymentReleaseDate_PaymentsHeader; "Payments Header"."Payment Release Date")
//             {
//             }
//             // column(NumberText; NumberText[1])
//             // {
//             // }
//             // column(CompanyInfoName; CompanyInfo.Name)
//             // {
//             // }
//             // column(CompanyInfoAddress; CompanyInfo.Address)
//             // {
//             // }
//             // column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
//             // {
//             // }
//             dataitem(52185853;52185853)
//             {
//                 DataItemLink = "Line No." = field("No.");
//                 column(ReportForNavId_2; 2)
//                 {
//                 }
//                 column(AccountNo_BBFClaimLines; "BBF Claim Lines"."Member No")
//                 {
//                 }
//                 column(Name_BBFClaimLines; "BBF Claim Lines".Name)
//                 {
//                 }
//                 column(Relationship_BBFClaimLines; "BBF Claim Lines".Relationship)
//                 {
//                 }
//                 column(Beneficiary_BBFClaimLines; "BBF Claim Lines".Beneficiary)
//                 {
//                 }
//                 column(DateofBirth_BBFClaimLines; "BBF Claim Lines"."Date of Birth")
//                 {
//                 }
//                 column(Address_BBFClaimLines; "BBF Claim Lines".Address)
//                 {
//                 }
//                 column(Telephone_BBFClaimLines; "BBF Claim Lines".Telephone)
//                 {
//                 }
//                 column(Fax_BBFClaimLines; "BBF Claim Lines".Fax)
//                 {
//                 }
//                 column(Email_BBFClaimLines; "BBF Claim Lines".Email)
//                 {
//                 }
//                 column(IDNo_BBFClaimLines; "BBF Claim Lines"."ID No.")
//                 {
//                 }
//                 column(Allocation_BBFClaimLines; "BBF Claim Lines"."%Allocation")
//                 {
//                 }
//                 column(Type_BBFClaimLines; "BBF Claim Lines".Type)
//                 {
//                 }
//                 column(Deceased_BBFClaimLines; "BBF Claim Lines".Deceased)
//                 {
//                 }
//                 column(BBFEntitlementCode_BBFClaimLines; "BBF Claim Lines"."BBF Entitlement Code")
//                 {
//                 }
//                 column(BBFEntitlement_BBFClaimLines; "BBF Claim Lines"."BBF Entitlement Claimed")
//                 {
//                 }
//                 column(LineNo_BBFClaimLines; "BBF Claim Lines"."Line No.")
//                 {
//                 }
//                 column(SavingsAccount_BBFClaimLines; "BBF Claim Lines"."Account No")
//                 {
//                 }
//                 column(NextofKin_BBFClaimLines; "BBF Claim Lines"."Next of Kin")
//                 {
//                 }
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 "Payments Header".CalcFields("Total Payment Amount BBF");
//                 CheckReport.InitTextVariable();
//                 CheckReport.FormatNoText(NumberText, "Total Payment Amount BBF", '');
//             end;

//             trigger OnPreDataItem()
//             begin
//                 CompanyInfo.Get();
//                 CompanyInfo.CalcFields(Picture);
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         CompanyInfo: Record "Company Information";
//         CheckReport: Report Check;
//                          NumberText: array[2] of Text[80];
// }
