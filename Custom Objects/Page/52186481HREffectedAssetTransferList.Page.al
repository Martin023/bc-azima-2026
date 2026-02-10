// page 52186481 "HR EffectedAsset Transfer Li1"
// {
//     CardPageID = "HR Effected Asset Transfer";
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = List;
//     SourceTable = "HR Asset Transfer Header";
//     SourceTableView = WHERE(Transfered = CONST(true));
//     UsageCategory = Lists;
//     ApplicationArea = Basic;

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

