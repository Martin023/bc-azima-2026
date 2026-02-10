// page 52186604 "HR BSC List Targets-Approved"
// {
//     CardPageID = "HR BSC Appraisal Header-Approv";
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = List;
//     SourceTable = "HR Individual Targets Header";
//     SourceTableView = WHERE(Status = FILTER(Approved));
//     UsageCategory = Lists;
//     ApplicationArea = Basic;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Appraisal No"; Rec."Appraisal No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Appraisal Date"; Rec."Appraisal Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Employee No"; Rec."Employee No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Appraisal Year"; Rec."Appraisal Year")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Finance Rating"; Rec."Finance Rating")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Customer Rating"; Rec."Customer Rating")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Training Rating"; Rec."Training Rating")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Service Rating"; Rec."Service Rating")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Overall Rating"; Rec."Overall Rating")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnOpenPage()
//     begin
//         Rec.SetFilter("User ID", UserId);
//     end;
// }

