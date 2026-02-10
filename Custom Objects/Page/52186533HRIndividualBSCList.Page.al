// page 52186533 "HR Individual BSC List"
// {
//     CardPageID = "HR Leave Carryover Request";
//     PageType = List;
//     SourceTable = "HR Appraisal Header";
//     SourceTableView = WHERE("Target Type" = FILTER("Individual Targets"),
//                             Sent = FILTER(Appraisee));
//     UsageCategory = Lists;
//     ApplicationArea = Basic;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("User ID"; Rec."User ID")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Appraisal Type"; Rec."Appraisal Type")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Appraisal Period"; Rec."Appraisal Period")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Appraisal No"; Rec."Appraisal No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Employee No"; Rec."Employee No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Employee Name"; Rec."Employee Name")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Job Title"; Rec."Job Title")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Picture; Rec.Picture)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             systempart(Control11; Outlook)
//             {
//                 ApplicationArea = Basic;
//             }
//             systempart(Control12; Notes)
//             {
//                 ApplicationArea = Basic;
//             }
//             systempart(Control13; MyNotes)
//             {
//                 ApplicationArea = Basic;
//             }
//             systempart(Control14; Links)
//             {
//                 ApplicationArea = Basic;
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("Approve All Individual Targets")
//             {
//                 ApplicationArea = Basic;
//             }
//             action("Approve Marked Targets")
//             {
//                 ApplicationArea = Basic;
//             }
//             action("Return All Individual Targets")
//             {
//                 ApplicationArea = Basic;
//             }
//             action("Return Marked Targets")
//             {
//                 ApplicationArea = Basic;
//             }
//         }
//     }
// }

