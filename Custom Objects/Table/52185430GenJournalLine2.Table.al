// table 52185430 "Gen. Journal Line 2"
// {
//     Caption = 'Gen. Journal Line';
//     Permissions = TableData "Data Exch. Field" = rimd;

//     fields
//     {
//         field(1; "Journal Template Name"; Code[10])
//         {
//             Caption = 'Journal Template Name';
//         }
//         field(2; "Line No."; Integer)
//         {
//             Caption = 'Line No.';
//         }
//         field(3; "Account Type"; Option)
//         {
//             Caption = 'Account Type';
//             OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Savings,Credit';
//             OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit;
//         }
//         field(4; "Account No."; Code[20])
//         {
//             Caption = 'Account No.';
//         }
//         field(5; "Posting Date"; Date)
//         {
//             Caption = 'Posting Date';
//             ClosingDates = true;
//         }
//         field(7; "Document No."; Code[20])
//         {
//             Caption = 'Document No.';
//         }
//         field(8; Description; Text[50])
//         {
//             Caption = 'Description';
//         }
//         field(11; "Bal. Account No."; Code[20])
//         {
//             Caption = 'Bal. Account No.';
//         }
//         field(13; Amount; Decimal)
//         {
//             AutoFormatType = 1;
//             Caption = 'Amount';
//         }
//         field(24; "Shortcut Dimension 1 Code"; Code[20])
//         {
//             CaptionClass = '1,2,1';
//             Caption = 'Shortcut Dimension 1 Code';
//         }
//         field(25; "Shortcut Dimension 2 Code"; Code[20])
//         {
//             CaptionClass = '1,2,2';
//             Caption = 'Shortcut Dimension 2 Code';
//         }
//         field(51; "Journal Batch Name"; Code[10])
//         {
//             Caption = 'Journal Batch Name';
//         }
//         field(63; "Bal. Account Type"; Enum "Gen. Journal Account Type")
//         {
//             Caption = 'Bal. Account Type';
//             // OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Savings,Credit';
//             // OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit;
//         }
//         field(50000; "Transaction Type"; Option)
//         {
//             OptionCaption = ' ,Loan,Repayment,Interest Due,Interest Paid,Bills,Appraisal';
//             OptionMembers = " ",Loan,Repayment,"Interest Due","Interest Paid",Bills,Appraisal;
//         }
//         field(50001; "Loan No"; Code[20])
//         {
//         }
//         field(50002; Posted; Boolean)
//         {
//         }
//         field(50003; batch; Code[10])
//         {
//         }
//     }

//     keys
//     {
//         key(Key1; "Line No.")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }
// }

