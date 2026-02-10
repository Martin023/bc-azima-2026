// page 52186591 "HR Overtime List - Converted1"
// {
//     CardPageID = "HR Overtime Card - Approved";
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = List;
//     SourceTable = "HR Overtime Header";
//     SourceTableView = WHERE(Converted = CONST(true));

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Application Code"; Rec."Application Code")
//                 {
//                     Style = Attention;
//                     StyleExpr = TRUE;
//                 }
//                 field("Application Date"; Rec."Application Date")
//                 {
//                 }
//                 field("Staff Name"; Rec."Staff Name")
//                 {
//                 }
//                 field("Total Overtime Hours"; Rec."Total Overtime Hours")
//                 {
//                 }
//                 field("Convert To?"; Rec."Convert To?")
//                 {
//                 }
//                 field(Converted; Rec.Converted)
//                 {
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             systempart(Control1; Outlook)
//             {
//             }
//         }
//     }

//     actions
//     {
//     }
// }

