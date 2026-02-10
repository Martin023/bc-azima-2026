// table 52185764 "M-SACCO SMS Messages"
// {

//     fields
//     {
//         field(1; "Entry No"; Integer)
//         {
//             AutoIncrement = true;
//             NotBlank = true;
//         }
//         field(2; Source; Option)
//         {
//             OptionCaption = 'New Member,New Account,Loan Account Approval,Deposit Confirmation,Cash Withdrawal Confirm,Loan Application,Loan Appraisal,Loan Guarantors,Loan Rejected,Loan Posted,Loan defaulted,Salary Processing,Teller Cash Deposit, Teller Cash Withdrawal,Teller Cheque Deposit,Fixed Deposit Maturity,InterAccount Transfer,Account Status,Status Order,EFT Effected, ATM Application Failed,ATM Collection,MSACCO,Member Changes,Cashier Below Limit,Cashier Above Limit,Chq Book,Internetbanking,CRM,Member Withdrawal,Delegate';
//             OptionMembers = "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book",Internetbanking,CRM,"Member Withdrawal",Delegate;
//         }
//         field(3; "Telephone No"; Code[20])
//         {
//         }
//         field(4; "Date Entered"; Date)
//         {
//         }
//         field(5; "Time Entered"; Time)
//         {
//         }
//         field(6; "Entered By"; Code[150])
//         {
//         }
//         field(7; "SMS Message"; Text[250])
//         {
//         }
//         field(8; "Sent To Server"; Option)
//         {
//             OptionCaption = 'No,Yes,Failed,Redirected';
//             OptionMembers = No,Yes,Failed,Redirected;
//         }
//         field(9; "Date Sent to Server"; Date)
//         {
//         }
//         field(13; "Account No"; Code[30])
//         {
//         }
//         field(15; "Document No"; Code[30])
//         {
//         }
//         field(16; "System Created Entry"; Boolean)
//         {
//         }
//         field(17; "Bulk SMS Balance"; Decimal)
//         {
//         }
//         field(21; IsChargeable; Boolean)
//         {
//         }
//         field(22; Posted; Boolean)
//         {
//         }
//         field(23; Source2; Code[20])
//         {
//         }
//         field(24; "Entry No2"; Integer)
//         {
//             AutoIncrement = false;
//         }
//     }

//     keys
//     {
//         key(Key1; "Entry No", "Time Entered", "Date Entered", "Entry No2")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnInsert()
//     begin
//         MSACCOSMSMessages.Reset;
//         if MSACCOSMSMessages.FindLast then
//             "Entry No2" := MSACCOSMSMessages."Entry No2" + 1;
//         if MSACCOSMSMessages.FindLast then
//             "Entry No" := MSACCOSMSMessages."Entry No" + 1;
//     end;

//     var
//         NoSetup: Record "General Ledger Setup";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         MSACCOSMSMessages: Record "M-SACCO SMS Messages";
// }

