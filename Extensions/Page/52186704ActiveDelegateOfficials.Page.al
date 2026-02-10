// page 52186704 "Active Delegate Officials"
// {
//     CardPageID = "Delegate Officials Card";
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = List;
//     SourceTable = "Delegate Officials";
//     SourceTableView = WHERE (Retired = CONST (false),
//                             Status = CONST (Approved));

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Electoral Zone"; rec."Electoral Zone")
//                 {
//                 }
//                 field("Member Number"; rec."Member Number")
//                 {
//                 }
//                 field("Delegate Official Name"; rec."Delegate Official Name")
//                 {
//                 }
//                 field(Position; rec.Position)
//                 {
//                 }
//                 field(Retired; rec.Retired)
//                 {
//                 }
//                 field("Retire Date"; rec."Retire Date")
//                 {
//                 }
//                 field("Electoral Zone Name"; rec."Electoral Zone Name")
//                 {
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

