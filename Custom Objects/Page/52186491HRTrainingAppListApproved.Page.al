// page 52186491 "HR Training App List-Approved"
// {
//     CardPageID = "HR Training App. Card - Approv";
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = List;
//     SourceTable = "HR Training App Header";
//     SourceTableView = WHERE(Status = FILTER(Approved));
//     ApplicationArea = Basic;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Application No"; Rec."Application No")
//                 {
//                     ApplicationArea = Basic;
//                     Style = Favorable;
//                     StyleExpr = TRUE;
//                 }
//                 field("Application Date"; Rec."Application Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Course Title"; Rec."Course Title")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Course Description"; Rec."Course Description")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("No. of Participants"; Rec."No. of Participants")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Start Date"; Rec."Start Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("End Date"; Rec."End Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             systempart(Control5; Outlook)
//             {
//                 ApplicationArea = Basic;
//             }
//             systempart(Control4; Notes)
//             {
//                 ApplicationArea = Basic;
//             }
//             systempart(Control3; Links)
//             {
//                 ApplicationArea = Basic;
//             }
//         }
//     }

//     actions
//     {
//     }
// }

