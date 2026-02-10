// page 52186480 "HR Asset Transfer List1"
// {
//     CardPageID = "HR Asset Transfer Card";
//     DeleteAllowed = false;
//     PageType = List;
//     SourceTable = "HR Asset Transfer Header";
//     SourceTableView = WHERE(Transfered = CONST(false));
//     ApplicationArea = Basic;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Document Date"; Rec."Document Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Current Holder"; Rec."Current Holder")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Asset to Transfer"; Rec."Asset to Transfer")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("New Holder"; Rec."New Holder")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Transfered; Rec.Transfered)
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

