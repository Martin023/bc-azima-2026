// page 52186277 "HR Fleet List"
// {
//     Caption = '';
//     CardPageID = "Fleet Card";
//     PageType = List;
//     SourceTable = "Fixed Asset";
//     UsageCategory = Lists;
//     ApplicationArea = Basic;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control14)
//             {
//                 ShowCaption = false;
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Vendor No."; Rec."Vendor No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Maintenance Vendor No."; Rec."Maintenance Vendor No.")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = true;
//                 }
//                 field("Responsible Employee"; Rec."Responsible Employee")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = true;
//                 }
//                 field("FA Class Code"; Rec."FA Class Code")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("FA Subclass Code"; Rec."FA Subclass Code")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("FA Location Code"; Rec."FA Location Code")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Budgeted Asset"; Rec."Budgeted Asset")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Search Description"; Rec."Search Description")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             systempart(Control2; Links)
//             {
//                 Visible = false;
//             }
//             systempart(Control1; Notes)
//             {
//                 Visible = true;
//             }
//         }
//     }

//     actions
//     {
//     }
// }

