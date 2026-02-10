// page 52186176 "Posted PaymentV  Delegate"
// {
//     CardPageID = "Payment Voucher Delegates";
//     Editable = false;
//     PageType = List;
//     SourceTable = "Payments Header Delegates";
//     SourceTableView = WHERE(Posted = CONST(true));
//     ApplicationArea = Basic, Suite;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Transaction No."; Rec."Transaction No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Amount; Rec.Amount)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Posted; Rec.Posted)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Transaction Date"; Rec."Transaction Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Transaction Time"; Rec."Transaction Time")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Allocated Amount"; Rec."Allocated Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("User ID"; Rec."User ID")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnOpenPage()
//     begin
//         /*
//         StatusPermissions.RESET;
//         StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
//         StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::Payments);
//         IF StatusPermissions.FIND('-') = FALSE THEN
//         ERROR('You do not have permissions to access this module.');
//         */

//     end;

//     var
//         StatusPermissions: Record "Application Document Setup";
// }

