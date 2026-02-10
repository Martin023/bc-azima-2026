// page 52186586 "HR Staff Loans Subpage"
// {
//     DeleteAllowed = false;
//     Editable = true;
//     InsertAllowed = true;
//     ModifyAllowed = true;
//     PageType = ListPart;
//     SourceTable = "HR Staff Loan Request";

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Loan No."; Rec."Loan No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Request Date"; Rec."Request Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Loan Type"; Rec."Loan Type")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Emp No."; Rec."Emp No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Emp Name"; Rec."Emp Name")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Amount Approved"; Rec."Amount Approved")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Amount Disbursed"; Rec."Amount Disbursed")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Undisbursed Amount"; Rec."Undisbursed Amount")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Amount to Disperse"; Rec."Amount to Disperse")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("No of Instalments"; Rec."No of Instalments")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Balance; Rec.Balance)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Repayment Method"; Rec."Repayment Method")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Account No."; Rec."Account No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Selected; Rec.Selected)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         AmountToDisbEditable: Boolean;

//     //[Scope('OnPrem')]
//     procedure UpdateControl()
//     begin
//         if Rec."Amount Approved" = Rec."Amount Disbursed" then
//             AmountToDisbEditable := true
//         else
//             AmountToDisbEditable := false
//     end;
// }

