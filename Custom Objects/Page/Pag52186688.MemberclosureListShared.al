// namespace MNS.MNS;
// using System.Security.User;

// page 52186688 "Member closure List (Shared)"
// {
//     Caption = 'Member closure List (Shared)';
//     PageType = List;
//     CardPageID = "Membership Closure";
//     DeleteAllowed = false;
//     //Editable = false;
//     SourceTable = "Membership closure";
//     SourceTableView = where(Posted = CONST(false));
//     ApplicationArea = Basic, Suite;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Member No."; Rec."Member No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Digit; Rec.Digit)
//                 {
//                     Editable = false;
//                 }
//                 field("Staff No."; Rec."Staff No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Member Name"; Rec."Member Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Closing Date"; Rec."Closing Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Posted; Rec.Posted)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Total Loan"; Rec."Total Loan")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Total Interest"; Rec."Total Interest")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Member Savings"; Rec."Member Savings")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Closure Type"; Rec."Closure Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Application Date"; Rec."Application Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Deposit Refundable"; Rec."Deposit Refundable")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Remarks; Rec.Remarks)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Close Account"; Rec."Close Account")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Loans Option"; Rec."Loans Option")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Responsible Officer"; Rec."Responsible Officer")
//                 {

//                 }
//                 field("Supervisor ID"; Rec."Supervisor ID")
//                 {
//                 }

//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnOpenPage()
//     begin
//         rec.SetFilter("Current Department", '=%1|%2', 'DCEO', 'FIN-HOF');
//     end;

//     var
//         UserSetUp: record "User Setup";
// }
