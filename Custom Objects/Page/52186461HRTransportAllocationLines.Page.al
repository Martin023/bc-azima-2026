// page 52186461 "HR Transport Allocation Lines"
// {
//     PageType = ListPart;
//     SourceTable = "HR Transport Allocation Lines";
//     SourceTableView = SORTING("Allocation No", "Requisition No");

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1102756000)
//             {
//                 ShowCaption = false;
//                 field("Requisition No"; Rec."Requisition No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Employee No"; Rec."Employee No")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Passenger's Full Name"; Rec."Passenger's Full Name")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(From; Rec.From)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Destination; Rec.Destination)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

