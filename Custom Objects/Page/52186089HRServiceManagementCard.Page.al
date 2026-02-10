// page 52186089 "HR Service Management Card"
// {
//     PageType = Card;
//     SourceTable = "HR Service Management Header";

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Vehicle Registration No."; Rec."Vehicle Registration No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Name Vehicle"; Rec."Name Vehicle")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Vehicle Type"; Rec."Vehicle Type")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Driver Details"; Rec."Driver Details")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Vendor/Garage"; Rec."Vendor/Garage")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Make/Model"; Rec."Make/Model")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Performance; Rec.Performance)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Kilometers; Rec.Kilometers)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Date /Time"; Rec."Date /Time")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Date of service"; Rec."Date of service")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Blocked; Rec.Blocked)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Inactive; Rec.Inactive)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             part("Service Management"; "HR Service Management Line")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Service Management';
//                 SubPageLink = Code = FIELD("No.");
//             }
//         }
//     }

//     actions
//     {
//     }
// }

