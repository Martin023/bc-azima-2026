// page 52186611 "HR Emp. Login Management List1"
// {
//     Caption = 'HR Employee Login Management List';
//     CardPageID = "HR Emp. Login Management Card";
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = List;
//     SourceTable = "HR Employee Login Management";
//     UsageCategory = Lists;
//     ApplicationArea = Basic;

//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field("Staff No."; Rec."Staff No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Staff Name"; Rec."Staff Name")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("User ID"; Rec."User ID")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             systempart(Control9; Outlook)
//             {
//             }
//             systempart(Control10; Notes)
//             {
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group(Functions)
//             {
//                 Caption = 'Functions';
//                 action("HR Shift Assignment")
//                 {
//                     Caption = 'HR Shift Assignment';
//                     Image = ReopenPeriod;
//                     RunObject = Page "HR Shift Assignment List";
//                     RunPageLink = "Staff No." = FIELD("Staff No.");
//                 }
//             }
//         }
//     }
// }

