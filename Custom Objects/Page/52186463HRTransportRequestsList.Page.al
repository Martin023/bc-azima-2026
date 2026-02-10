// page 52186463 "HR Transport Requests List"
// {
//     CardPageID = "HR Staff Transport Requisition";
//     Editable = false;
//     PageType = List;
//     SourceTable = "HR Transport Requisition Head";
//     ApplicationArea = Basic;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1102755000)
//             {
//                 ShowCaption = false;
//                 field("Transport Request No"; Rec."Transport Request No")
//                 {
//                     ApplicationArea = Basic;
//                     Style = Strong;
//                     StyleExpr = TRUE;
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
//                 field("Days Applied"; Rec."Days Applied")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Supervisor; Rec.Supervisor)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             systempart(Control1102755004; Outlook)
//             {
//                 ApplicationArea = Basic;
//             }
//             systempart(Control1102755006; Notes)
//             {
//                 ApplicationArea = Basic;
//             }
//         }
//     }

//     actions
//     {
//         area(reporting)
//         {
//             action("Transport Requests")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Transport Requests';
//                 Image = "Report";
//                 Promoted = true;
//                 PromotedCategory = "Report";
//                 RunObject = Report "HR Transport Requisitions";
//             }
//         }
//     }
// }

