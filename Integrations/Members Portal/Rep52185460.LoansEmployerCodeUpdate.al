// report 52185460 "Loans Employer Code Update"
// {
//     ApplicationArea = All;
//     Caption = 'Loans Employer Code Update';
//     UsageCategory = ReportsAndAnalysis;
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem(Loans; Loans)
//         {
//             column(LoanNo; "Loan No.")
//             {
//             }

//             trigger OnAfterGetRecord()
//             var
//                 Loanee: Record Members;
//                 MobileLoan: Record "Mobile loan App. Buffer";
//             begin
//                 if (Loans."ID No." = '') OR (Loans."Employer Code" = '') then begin
//                     Loanee.Reset;
//                     Loanee.SetRange("No.", Loans."Member No.");
//                     Loanee.SetLoadFields(
//                         "Primary Identification", "Employer Code"
//                     );

//                     if Loanee.FindFirst() then begin
//                         Loans."ID No." := Loanee."Primary Identification";
//                         Loans."Employer Code" := Loanee."Employer Code";
//                         Loans.Modify;

//                         MobileLoan.Reset;
//                         MobileLoan.SetRange("Member No.", Loans."Member No.");
//                         MobileLoan.SetRange("Loan No.", Loans."Loan No.");
//                         if MobileLoan.FindFirst() then begin
//                             MobileLoan."Employer Code" := Loanee."Employer Code";
//                             MobileLoan.Modify;
//                         end;

//                         Commit;
//                     end;
//                 end;
//             end;
//         }
//     }

//     trigger OnPostReport()
//     var
//         myInt: Integer;
//     begin
//         Message('Loans employer codes have been updated successfully');
//     end;
// }
