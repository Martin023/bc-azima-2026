// page 52185784 "MBanking Applications Part"
// {
//     DeleteAllowed = false;
//     PageType = ListPart;
//     SourceTable = "M-SACCO Application Details";

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Account Type"; Rec."Account Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Account No."; Rec."Account No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

