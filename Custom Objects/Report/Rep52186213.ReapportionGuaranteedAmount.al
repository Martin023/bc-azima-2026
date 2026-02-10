// namespace KenpipeCBS.KenpipeCBS;

// report 52186213 "Reapportion Guaranteed Amount"
// {
//     ApplicationArea = All;
//     Caption = 'Reapportion Guaranteed Amount';
//     UsageCategory = Tasks;
//     ProcessingOnly = true;
//     dataset
//     {
//         dataitem(loans; loans)
//         {
//             Calcfields = "Outstanding Balance";
//             DataItemTableView = where("Outstanding Balance" = filter(> 0));

//             column(LoanNo; "Loan No.")
//             {
//             }
//             column(MemberNo; "Member No.")
//             {
//             }
//             trigger OnAfterGetRecord()
//             begin
//                 Loans.CalcFields("Outstanding Balance");
//                 LoanGuarantors.reset();
//                 LoanGuarantors.SetRange("Loan No", Loans."Loan No.");
//                 LoanGuarantors.SetRange(Substituted, false);
//                 if LoanGuarantors.Find('-') then begin
//                     NOfGuarantors := LoanGuarantors.COUNT;
//                     GuarantorApp := Loans."Outstanding Balance" / NOfGuarantors;
//                     repeat
//                         LoanGuarantors."Amount Guaranteed" := GuarantorApp;
//                         LoanGuarantors.Modify();
//                     until LoanGuarantors.Next = 0;
//                 end
//                 else
//                     currreport.Skip;
//             end;

//             trigger OnPreDataItem()
//             begin

//                 Loans.reset();
//                 Loans.setfilter("Disbursement Date", '%1<', CutoffDate);
//             end;
//         }
//     }
//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(GroupName)
//                 {
//                 }
//             }
//         }
//         actions
//         {
//             area(Processing)
//             {
//             }
//         }
//     }

//     trigger OnPreReport()
//     begin
//         CutoffDate := 20250430D;
//     end;

//     var
//         LoanGuarantors: record "Loan Guarantors and Security";
//         NOfGuarantors: Integer;
//         GuarantorApp: decimal;
//         CutoffDate: Date;

// }
