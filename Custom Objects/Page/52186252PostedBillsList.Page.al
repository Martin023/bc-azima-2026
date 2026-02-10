// page 52186252 "Posted Bills List"
// {
//     CardPageID = "Bill Batch Posted";
//     Editable = false;
//     PageType = List;
//     SourceTable = "Bills Batch";
//     SourceTableView = WHERE(Posted = CONST(true));
//     ApplicationArea = Basic, Suite;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1102755000)
//             {
//                 ShowCaption = false;
//                 field("Batch No."; Rec."Batch No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Batch Name"; Rec."Batch Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("No of Billings"; Rec."No of Billings")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Total Amount"; Rec."Total Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Billing Period"; Rec."Billing Period")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

