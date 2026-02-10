// page 52186477 "HR EmployeeTransfer ListEffe1"
// {
//     CardPageID = "HR Employee Transfer Card Effe";
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = List;
//     SourceTable = "HR Employee Transfer Header";
//     SourceTableView = WHERE("Transfer details Updated" = CONST(true));
//     UsageCategory = Lists;
//     ApplicationArea = Basic;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Request No"; Rec."Request No")
//                 {
//                     ApplicationArea = Basic;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Employee No"; Rec."Employee No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Employee Name"; Rec."Employee Name")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Date Requested"; Rec."Date Requested")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic;
//                     Style = StrongAccent;
//                     StyleExpr = TRUE;
//                 }
//                 field("Transfer details Updated"; Rec."Transfer details Updated")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

