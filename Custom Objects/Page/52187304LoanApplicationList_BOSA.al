// page 52187304 "Loan Application List_BOSA"
// {
//     CardPageID = "Loan Application Card_BOSA";
//     DeleteAllowed = false;
//     Editable = false;
//     PageType = List;
//     InsertAllowed = true;//All originations are from CRM...but not for this
//     SourceTable = Loans;
//     SourceTableView = WHERE(Posted = CONST(false), "Source Unit" = const(BOSA),
//                             "Dummy Appraisal" = FILTER(false),
//                             "Picked Mobile Loan" = FILTER(false),
//                             "Sent Online" = FILTER(false),
//                             Status = FILTER(<> Approved & <> Pending & <> Rejected & <> Deffered));

//     ApplicationArea = Basic, Suite;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Loan No."; Rec."Loan No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     StyleExpr = StyleExprTxt;
//                 }
//                 field("CRM Application No."; Rec."Loan No.")
//                 {
//                     ApplicationArea = all;
//                     StyleExpr = StyleExprTxt;
//                     Caption = 'CRM Application No.';
//                 }
//                 field("Application Date"; Rec."Application Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     StyleExpr = StyleExprTxt;
//                 }
//                 field("Loan Product Type"; Rec."Loan Product Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     StyleExpr = StyleExprTxt;
//                 }
//                 field("Loan Product Type Name"; Rec."Loan Product Type Name")
//                 {
//                     ApplicationArea = all;
//                     StyleExpr = StyleExprTxt;

//                 }
//                 field("Staff No"; Rec."Staff No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     StyleExpr = StyleExprTxt;
//                 }
//                 field("Member No."; Rec."Member No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     StyleExpr = StyleExprTxt;
//                 }
//                 field("Member Name"; Rec."Member Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     StyleExpr = StyleExprTxt;
//                 }
//                 field("Requested Amount"; Rec."Requested Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     StyleExpr = StyleExprTxt;
//                 }
//                 field("Approved Amount"; Rec."Approved Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     StyleExpr = StyleExprTxt;
//                 }
//                 field("Employer Code"; Rec."Employer Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Commercial Buyoff"; Rec."Commercial Buyoff")
//                 {
//                     ApplicationArea = all;
//                     StyleExpr = StyleExprTxt;
//                 }
//                 field(Interest; Rec.Interest)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     StyleExpr = StyleExprTxt;
//                 }
//                 field("Responsible Officer"; Rec."Responsible Officer")
//                 {
//                     StyleExpr = StyleExprTxt;
//                     ApplicationArea = all;

//                 }

//                 field("Captured By"; Rec."Captured By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     StyleExpr = StyleExprTxt;
//                 }
//                 field("Current User"; Rec."Current User")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     StyleExpr = StyleExprTxt;
//                 }

//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     StyleExpr = StyleExprTxt;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     StyleExpr = StyleExprTxt;
//                 }
//                 field("Approval Date"; Rec."Approval Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     StyleExpr = StyleExprTxt;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     StyleExpr = StyleExprTxt;
//                 }
//                 field("Commercial Approval"; Rec."Commercial Approval")
//                 {
//                     ApplicationArea = all;
//                     StyleExpr = StyleExprTxt;
//                 }
//                 field("Loan Rejection Reason"; Rec."Loan Rejection Reason")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     StyleExpr = StyleExprTxt;
//                 }
//                 field("Sent Back to CRM"; Rec."Sent Back to CRM")
//                 {
//                     ApplicationArea = all;
//                     StyleExpr = StyleExprTxt;
//                 }
//                 field("Sent Back to M-Smart"; Rec."Sent Back to M-Smart")
//                 {
//                     ApplicationArea = all;
//                     StyleExpr = StyleExprTxt;
//                 }
//                 field("Document Excalated"; Rec."Document Excalated")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     StyleExpr = StyleExprTxt;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnOpenPage()
//     var

//     begin
//         RecoveryAccent();

//         Rec.FilterGroup(2);

//         Rec.FilterGroup(0);

//         Rec.SetCurrentKey(Rec."Disbursement Priority", "Loan No.");
//         Rec.SetAscending("Disbursement Priority", true);
//     end;

//     trigger OnAfterGetRecord()
//     var
//         Genset: Record "General Set-Up";
//         DurationText: Text;
//     begin
//         RecoveryAccent();
//         // Genset.Get();
//         // if Rec."Application Date" <> 0D then begin
//         //     Rec.SetFilter("Application Date", '%1..%2', CalcDate('-3M', Today), Today);
//         // end;
//         // if Rec."Member No." <> '' then begin
//         //     if rec."Current User" <> '' then begin
//         //         if Time - Rec.WorkTime > 30 then begin
//         //             Rec."Current User" := '';
//         //             Rec.WorkTime := Time;
//         //             Rec.Modify(true);
//         //         end;
//         //     end;
//         // end;
//         // Evaluate(DurationText, Format(Genset."Loan Rejection Period"));
//         // DurationText := DelChr(Format(DurationText), '=', '-|+|');
//         // Evaluate(Genset."Loan Rejection Period", DurationText);
//         // if DurationText <> '' then begin
//         //     if Rec."Application Date" <> 0D then begin
//         //         if (Rec.Status = Rec.Status::Open) and (Rec."Application Date" <> 0D) then begin
//         //             if CalcDate(Genset."Loan Rejection Period", Rec."Application Date") < Today then begin
//         //                 Rec.Status := Rec.Status::Rejected;
//         //                 Rec.Modify;
//         //             end;
//         //         end;
//         //     end;
//         // end;
//     end;

//     procedure RecoveryAccent()
//     var
//         myInt: page "Bank Acc. Reconciliation";
//     begin
//         StyleExprTxt := '';
//         if Pfac.Get(Rec."Loan Product Type") then begin
//             if Pfac."Disbursement Priority" = 1 then
//                 StyleExprTxt := 'Unfavorable'
//             else
//                 if Pfac."Disbursement Priority" = 2 then
//                     StyleExprTxt := 'Ambiguous' else

//                     if Pfac."Disbursement Priority" = 3 then
//                         StyleExprTxt := 'StandardAccent' else
//                         StyleExprTxt := '';
//         end;

//     end;

//     var
//         LoansR: Record Loans;
//         StyleExprTxt: Text[20];
//         Pfac: Record "Product Factory";

// }

