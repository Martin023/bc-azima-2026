// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185704 "BBF Refunds"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/BBF Refunds.rdl';

//     dataset
//     {
//         dataitem("Payments Header"; "Payments Header")
//         {
//             DataItemTableView = where("Payment Type" = filter("Benevolent Claim"));

//             column(CompanyName; CompanyInformation.Name)
//             {
//             }
//             column(Picture; CompanyInformation.Picture)
//             {
//             }
//             column(SNO; sno)
//             {
//             }
//             column(AccountType_PaymentsHeader; "Payments Header"."Account Type")
//             {
//             }
//             column(MemberNo_PaymentsHeader; "Payments Header"."Member No.")
//             {
//             }
//             column(Name_PaymentsHeader; "Payments Header".Name)
//             {
//             }
//             column(TotalPaymentAmountBBF_PaymentsHeader; "Payments Header"."Total Payment Amount BBF")
//             {
//             }
//             column(TotalVATWithholdingAmount_PaymentsHeader; "Payments Header"."Total VAT Withholding Amount")
//             {
//             }
//             column(RequisationDocNo_PaymentsHeader; "Payments Header"."Requisation Doc No.")
//             {
//             }
//             dataitem("BBF claim Lines"; "BBF claim Lines")
//             {
//                 DataItemLink = "Line No." = field("No.");
//                 column(ReportForNavId_2; 2)
//                 {
//                 }
//                 column(MemberNo_BBFClaimLines; "BBF Claim Lines"."Member No")
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

//                 column(BBFEntitlementClaimed_BBFClaimLines; "BBF Claim Lines"."BBF Entitlement Claimed")
//                 {
//                 }
//                 column(LineNo_BBFClaimLines; "BBF Claim Lines"."Line No.")
//                 {
//                 }
//                 column(AccountNo_BBFClaimLines; "BBF Claim Lines"."Account No")
//                 {
//                 }
//                 column(NextofKin_BBFClaimLines; "BBF Claim Lines"."Next of Kin")
//                 {
//                 }
//                 column(Posted_BBFClaimLines; "BBF Claim Lines".Posted)
//                 {
//                 }
//                 column(LoanNo_BBFClaimLines; "BBF Claim Lines"."Loan No.")
//                 {
//                 }
//                 column(TransactionType_BBFClaimLines; "BBF Claim Lines"."Transaction Type")
//                 {
//                 }
//                 column(RequisationNo_BBFClaimLines; "BBF Claim Lines"."Requisation No.")
//                 {
//                 }
//                 column(BBFEntitlementPaid_BBFClaimLines; "BBF Claim Lines"."BBF Entitlement Paid")
//                 {
//                 }
//                 column(Difference_BBFClaimLines; "BBF Claim Lines".Difference)
//                 {
//                 }
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 sno += 1;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 CompanyInformation.Get();
//                 CompanyInformation.CalcFields(CompanyInformation.Picture);
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
//         sno: Integer;
//         CompanyInformation: Record "Company Information";
// }

