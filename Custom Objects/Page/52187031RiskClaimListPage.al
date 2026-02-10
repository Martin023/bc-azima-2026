// page 52187031 "Risk Claim List"
// {
//     CardPageID = "SinkFund Notice Risk Claim";
//     Caption='Risk Claim';
//     DeleteAllowed = false;
//     Editable = false;
//     PageType = List;
//     SourceTable = "SinkFund Report Information";
//     SourceTableView = WHERE("Insurance Payment Status" = FILTER(<> "Beneficiary Claim Paid"),"Claim Type"=filter("Risk Claim"));
//     ApplicationArea = Basic, Suite;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field(No; Rec.No)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Date; Rec.Date)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Reported By Name"; Rec."Reported By Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Reported By ID No"; Rec."Reported By ID No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Reported By Relationship"; Rec."Reported By Relationship")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Member No"; Rec."Member No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Staff No."; Rec."Staff No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Date of Death"; Rec."Date of Death")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Claim Option"; Rec."Claim Option")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Deceased Person"; Rec."Deceased Person")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Member Name"; Rec."Member Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Captured By"; Rec."Captured By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
//     trigger OnNewRecord(BelowxRec: Boolean) begin
//         rec."Claim Type" := Rec."Claim Type"::"Risk Claim";
//     end;
// }

