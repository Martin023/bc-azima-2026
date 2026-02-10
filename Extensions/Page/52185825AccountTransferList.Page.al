// page 52185825 "Account Transfer List"
// {
//     CardPageID = "Account Transfer";
//     DeleteAllowed = false;
//     Editable = false;
//     PageType = List;
//     SourceTable = "Account Transfer Header";
//     SourceTableView = SORTING (No)
//                       ORDER(Descending)
//                       WHERE ("Account Transfer Type" = CONST (" "),
//                             Posted = CONST (false));

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field(No; rec.No)
//                 {
//                 }
//                 field("Transaction Date"; rec."Transaction Date")
//                 {
//                 }
//                 field("Transaction Time"; rec."Transaction Time")
//                 {
//                 }
//                 field(Posted; rec.Posted)
//                 {
//                 }
//                 field(Status; rec.Status)
//                 {
//                 }
//                 field("Created By"; rec."Created By")
//                 {
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         AccountTransferHeader: Record "Account Transfer Header";
// }

