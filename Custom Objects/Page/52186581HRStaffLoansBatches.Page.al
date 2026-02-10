// page 52186581 "HR Staff Loans Batches"
// {
//     DeleteAllowed = true;
//     PageType = Card;
//     PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
//     SourceTable = "HR Batches";
//     SourceTableView = WHERE(Posted = CONST(false));

//     layout
//     {
//         area(content)
//         {
//             group(Control1000000002)
//             {
//                 ShowCaption = false;
//                 field("Batch No."; Rec."Batch No.")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Batch Type"; Rec."Batch Type")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                 }
//                 field("Description/Remarks"; Rec."Description/Remarks")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Batch Date"; Rec."Batch Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Total Loan Amount"; Rec."Total Loan Amount")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("No of Loans"; Rec."No of Loans")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Mode Of Disbursement"; Rec."Mode Of Disbursement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Document No."; Rec."Document No.")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         /*IF STRLEN("Document No.") > 6 THEN
//                           ERROR('Document No. cannot contain More than 6 Characters.');
//                           */

//                     end;
//                 }
//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("BOSA Bank Account"; Rec."BOSA Bank Account")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Loan Disbursement Account';
//                 }
//                 field("Responcibility Center"; Rec."Responcibility Center")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             part(LoansSubForm; "HR Staff Loans Subpage")
//             {
//                 ApplicationArea = Basic;
//                 SubPageLink = "Batch No." = FIELD("Batch No.");
//             }
//             part(Control1000000003; "HR Overtime Lines")
//             {
//                 ApplicationArea = Basic;
//             }
//             part(Control1000000004; "Approved Leave Applications")
//             {
//                 ApplicationArea = Basic;
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         Text001: Label 'Status must be open';
// }

