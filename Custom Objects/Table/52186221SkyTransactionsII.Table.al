table 52186221 "Sky Transactions II"
{

    fields
    {
        field(1; "Transaction ID"; Code[20])
        {
        }
        field(3; "Transaction Date"; Date)
        {
        }
        field(4; "Transaction Time"; Time)
        {
        }
        field(8; "Member Account"; Code[20])
        {
        }
        field(11; "Vendor Commission"; Decimal)
        {
        }
        field(13; "Sacco Fee"; Decimal)
        {
        }
        field(15; Description; Text[50])
        {
        }
        field(17; Amount; Decimal)
        {
        }
        field(18; Posted; Boolean)
        {
        }
        field(19; "Date Posted"; Date)
        {
        }
        field(20; "Time Posted"; Time)
        {
        }
        field(21; "Posted By"; Code[50])
        {
        }
        field(22; Reversed; Boolean)
        {
        }
        field(23; "Date Reversed"; Date)
        {
        }
        field(24; "Time Reversed"; Time)
        {
        }
        field(25; "Reversed By"; Code[50])
        {
        }
        field(26; "Reversal ID"; Code[20])
        {
        }
        field(27; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Mpesa Withdrawal,Mpesa Deposit,Utility Payment,Loan Repayment,Balance Enquiry,Mini-Statement,Loan Disbursement,Account Transfer,Pay Loan From Account,Paybill,Mobile App Login,Pesalink Transfer,Airtime,Bank Deposit,Bank Agent Deposit,Bank Transfer,Agent Withdrawal,Check Beneficiary,Pin Reset';
            OptionMembers = " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Pesalink Transfer",Airtime,"Bank Deposit","Bank Agent Deposit","Bank Transfer","Agent Withdrawal","Check Beneficiary","Pin Reset";
        }
        field(28; "Transaction Name"; Text[50])
        {
        }
        field(32; "Session ID"; Code[20])
        {
        }
        field(33; "Loan No."; Code[20])
        {
        }
        field(34; Keyword; Code[20])
        {
        }
        field(35; "Mobile No."; Code[20])
        {
        }
        field(36; "Statement Max Rows"; Integer)
        {
        }
        field(37; "Statement Start Date"; Date)
        {
        }
        field(38; "Statement End Date"; Date)
        {
        }
        field(39; "Account to Check"; Code[20])
        {
        }
        field(40; "Entry No."; Code[20])
        {
        }
        field(41; "Client Name"; Text[200])
        {
        }
        field(42; "Paybill Member ID"; Code[20])
        {
        }
        field(43; "Needs Change"; Boolean)
        {
        }
        field(44; "Changed By"; Code[50])
        {
        }
        field(45; "Date Changed"; Date)
        {
        }
        field(46; "Interest Paid"; Decimal)
        {
        }
        field(47; "Principal Paid"; Decimal)
        {
        }
        field(50050; MobileApp; Boolean)
        {
        }
        field(50051; "Manually Inserted"; Boolean)
        {
        }
        field(50052; "Inserted By"; Code[50])
        {
        }
        field(50053; "Date Inserted"; Date)
        {
        }
        field(50054; "Old Transaction Date"; Date)
        {
        }
        field(50055; "Ledger Entries"; Integer)
        {
            CalcFormula = Count("Bank Account Ledger Entry" WHERE("Document No." = FIELD("Transaction ID"),
                                                                   Reversed = CONST(false)));
            FieldClass = FlowField;
        }
        field(50056; SMSMessage; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "Destination Account"; Text[200])
        {
        }
        field(50058; Organization; Text[200])
        {
        }
        field(50059; "Destination Name"; Text[200])
        {
        }
        field(50060; "Paybill Account"; Text[200])
        {
        }
        field(50061; "Old Account No"; Code[20])
        {
        }
        field(50062; Changed; Boolean)
        {
        }
        field(50063; "Change Transaction No"; Code[20])
        {
        }
        field(50064; "Time Changed"; Time)
        {
        }
        field(50065; "Approved By"; Code[50])
        {
        }
        field(50066; "Client Phone Number"; Text[13])
        {
        }
        field(50067; "Customer Name"; Text[50])
        {
        }
        field(50068; "Sky Transactions"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Transaction ID")
        {
        }
        key(Key3; "Transaction Date")
        {
        }
    }

    fieldgroups
    {
    }
}

