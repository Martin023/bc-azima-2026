// page 52186466 "HR Transport Requisition List"
// {
//     CardPageID = "HR Staff Transport Requisition";
//     PageType = List;
//     SourceTable = "HR Transport Requisition Head";
//     ApplicationArea = Basic;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Transport Request No"; Rec."Transport Request No")
//                 {
//                     ApplicationArea = Basic;
//                     Importance = Promoted;
//                     Style = Favorable;
//                     StyleExpr = TRUE;
//                 }
//                 field("Employee No"; Rec."Employee No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Departure Date"; Rec."Departure Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Return Date"; Rec."Return Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(From; Rec.From)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Destination; Rec.Destination)
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
//     }

//     actions
//     {
//     }
// }

