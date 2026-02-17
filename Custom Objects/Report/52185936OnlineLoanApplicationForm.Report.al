// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185936 "Online Loan Application Form"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Online Loan Application Form.rdl';
//     PreviewMode = PrintLayout;

//     dataset
//     {
//         dataitem("Online Loans Application"; "Online Loans Applications")
//         {
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(CompName; company.Name)
//             {
//             }
//             column(CompPic; company.Picture)
//             {
//             }
//             column(ApplicationNo_OnlineLoansApplications; "Application No")
//             {
//             }
//             column(ApplicationDate_OnlineLoansApplications; "Application Date")
//             {
//             }
//             column(MembershipNo_OnlineLoansApplications; "Membership No")
//             {
//             }
//             column(MemberNames_OnlineLoansApplications; "Member Names")
//             {
//             }
//             column(EmploymentNo_OnlineLoansApplications; "Employment No")
//             {
//             }
//             column(Telephone_OnlineLoansApplications; Telephone)
//             {
//             }
//             column(Email_OnlineLoansApplications; Email)
//             {
//             }
//             column(LoanTypeDescription_OnlineLoansApplications; "Loan Type Description")
//             {
//             }
//             column(LoanType_OnlineLoansApplications; "Loan Type")
//             {
//             }
//             column(LoanAmount_OnlineLoansApplications; "Loan Amount")
//             {
//             }
//             column(RepaymentPeriod_OnlineLoansApplications; "Repayment Period")
//             {
//             }
//             column(Approved_OnlineLoansApplications; Approved)
//             {
//             }
//             column(BasicPay_OnlineLoansApplications; "Basic Pay")
//             {
//             }
//             column(TotalAllowances_OnlineLoansApplications; "Total Allowances")
//             {
//             }
//             column(TotalDeduction_OnlineLoansApplications; TotalDeduction)
//             {
//             }
//             column(InterestRate_OnlineLoansApplications; "Interest Rate")
//             {
//             }
//             column(GuarantorsApproved_OnlineLoansApplications; "Guarantors Approved")
//             {
//             }
//             column(topup_OnlineLoansApplications; topup)
//             {
//             }
//             column(topupref_OnlineLoansApplications; topupref)
//             {
//             }
//             column(submitted_OnlineLoansApplications; submitted)
//             {
//             }
//             column(IdNo_OnlineLoansApplications; "Id No")
//             {
//             }
//             column(LoanNo_OnlineLoansApplications; "Loan No")
//             {
//             }
//             column(Rejected_OnlineLoansApplications; Rejected)
//             {
//             }
//             dataitem("Online Loan Guarantors"; "Online Loan Guarantors")
//             {
//                 DataItemLink = "Loan Application No" = field("Application No");
//                 column(ReportForNavId_23; 23)
//                 {
//                 }
//                 column(EntryNo_OnlineLoanGuarantors; "Online Loan Guarantors"."Entry No")
//                 {
//                 }
//                 column(LoanApplicationNo_OnlineLoanGuarantors; "Online Loan Guarantors"."Loan Application No")
//                 {
//                 }
//                 column(GuarantorNo_OnlineLoanGuarantors; "Online Loan Guarantors"."Guarantor No.")
//                 {
//                 }
//                 column(GuarantorNames_OnlineLoanGuarantors; "Online Loan Guarantors"."Guarantor Names")
//                 {
//                 }
//                 column(GuarantorEmail_OnlineLoanGuarantors; "Online Loan Guarantors"."Guarantor Email")
//                 {
//                 }
//                 column(GuarantorIDNo_OnlineLoanGuarantors; "Online Loan Guarantors"."Guarantor ID No")
//                 {
//                 }
//                 column(GuarantorAmount_OnlineLoanGuarantors; "Online Loan Guarantors"."Guarantor Amount")
//                 {
//                 }
//                 column(GuarantorPhone_OnlineLoanGuarantors; "Online Loan Guarantors"."Guarantor Phone")
//                 {
//                 }
//                 column(Approved_OnlineLoanGuarantors; "Online Loan Guarantors".Approved)
//                 {
//                 }
//                 column(ApprovalStatus_OnlineLoanGuarantors; "Online Loan Guarantors"."Approval Status")
//                 {
//                 }
//                 column(GuarantorStatus; GuarantorStatus)
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     GuarantorStatus := 'Pending';

//                     if "Online Loan Guarantors"."Approval Status" then begin
//                         if "Online Loan Guarantors".Approved then GuarantorStatus := 'Approved' else GuarantorStatus := 'Rejected';
//                     end;
//                 end;
//             }

//             trigger OnPreDataItem()
//             begin
//                 company.Get;
//                 company.CalcFields(Picture);
//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;

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
//         company: Record "Company Information";
//         GuarantorStatus: Text;
// }
