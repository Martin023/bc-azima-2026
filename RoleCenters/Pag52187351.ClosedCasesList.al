// page 52187351 "Closed Cases List"
// {
//     ApplicationArea = All;
//     Caption = 'Closed Cases List';
//     PageType = List;
//     SourceTable = Legal;
//     UsageCategory = Lists;
//     ModifyAllowed = false;
//     DeleteAllowed = false;
//     Editable = false;
//     SourceTableView = WHERE("Case Status" = CONST(Closed));
//     CardPageId = "Closed Cases Card";
    
//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Case Number"; Rec."Case Number")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Case Type"; Rec."Matter Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Date of filing the Suit"; Rec."Date of Filing the suit")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Case Status"; Rec."Case Status")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//         }
//     }
// }
