table 52186269 "Credit Officers Cue Table"
{
    Caption = 'Credit Officers Cue Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(15; PrimaryKey; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(1; "Savings Accounts"; Integer)
        {
            CalcFormula = Count("Savings Accounts" WHERE(Status = FILTER(Active)));
            FieldClass = FlowField;
        }
        // field(18; "Total Members Savings' Account Balance"; Decimal)
        // {
        //     CalcFormula = SUM ("Savings Accounts".Balance WHERE (Status = FILTER (Active)));
        //     Caption = 'Total Members Savings Account Balance';
        //     FieldClass = FlowField;

        // }
        field(2; "T/Cashier Transactions"; Integer)
        {
            CalcFormula = Count("Treasury Cashier Transactions" WHERE(Status = FILTER(Approved)));
            FieldClass = FlowField;
        }

        field(3; "Unsuccessful Standing Order"; Integer)
        {
            CalcFormula = Count("Standing Order Header" WHERE(Unsuccessfull = filter(true)));
            FieldClass = FlowField;
        }
        field(4; "EFT Transfer List"; Integer)
        {
            CalcFormula = Count("RTGS Transfer Header" WHERE(Status = FILTER(Approved)));
            FieldClass = FlowField;
        }
        // field(17; "Total EFT Transfers"; Decimal)
        // {
        //     CalcFormula = SUM ("EFT Transfer Header"."Record Total" WHERE (Status = FILTER (Transferred)));
        //     Caption = 'Total EFT Transfers';
        //     FieldClass = FlowField;
        // }
        field(5; "Posted Account Transfers"; Integer)
        {
            CalcFormula = Count("Account Transfer Header" WHERE(Status = FILTER(Approved)));
            FieldClass = FlowField;
        }
        field(6; "Approved Cheque Books"; Integer)
        {
            CalcFormula = Count("Cheque Book Application" WHERE(Status = FILTER(Approved)));
            FieldClass = FlowField;
        }
        field(7; "Approved Banker's Cheques"; Integer)
        {
            CalcFormula = Count("Bankers Cheque Application" WHERE(Status = FILTER(Approved)));
            FieldClass = FlowField;
        }
        field(8; "Authorized Bank Overdrafts"; Integer)
        {
            CalcFormula = Count("Over Draft Authorisation" WHERE(Status = FILTER(Approved)));
            FieldClass = FlowField;
        }
        field(9; "Processed Salaries"; Integer)
        {
            CalcFormula = Count("Salary Header" WHERE(Status = FILTER(Approved)));
            FieldClass = FlowField;
        }
        // field(19; "Total Processed Salaries"; Decimal)
        // {
        //     CalcFormula = SUM ("Salary Header".Amount WHERE (Status = FILTER (Approved)));
        //     Caption = 'Total Processed Salaries';
        //     FieldClass = FlowField;
        // }
        field(10; "Cleared Cheques"; Integer)
        {
            CalcFormula = Count("Cashier Transactions" WHERE(Status = FILTER(Approved)));
            FieldClass = FlowField;
        }
        field(11; "Banking Closure"; Integer)
        {
            CalcFormula = Count("Banking Account Closure" WHERE(Status = FILTER(Approved)));
            FieldClass = FlowField;

        }
        field(12; "Approved ATM"; Integer)
        {
            CalcFormula = Count("ATM Applications" WHERE(Status = FILTER(Approved)));
            FieldClass = FlowField;
        }
        field(13; "ATM Transactions"; Integer)
        {
            CalcFormula = Count("Sky ATM Transactions Buffer");
            FieldClass = FlowField;
        }
        field(14; "Active Bonds"; Integer)
        {
            CalcFormula = Count("Bond" WHERE("Bond Status" = FILTER(Approved)));
            FieldClass = FlowField;
        }
        field(16; "Cashier Transactions"; Integer)
        {
            CalcFormula = Count("Cashier Transactions" WHERE(Posted = filter(true)));
            FieldClass = FlowField;
        }
        field(17; "Successful Standing Orders"; Integer)
        {
            CalcFormula = Count("Standing Order Header" WHERE(Unsuccessfull = filter(false)));
            FieldClass = FlowField;
        }
        field(18; "Partial Deduction STO"; Integer)
        {
            CalcFormula = Count("Standing Order Header" WHERE("Allow Partial Deduction" = filter(true)));
            FieldClass = FlowField;
        }
        field(19; "M-Hela Transactions"; Integer)
        {
            CalcFormula = Count("Sky M-Banking Trans. Buffer");
            FieldClass = FlowField;
        }
        field(20; "Open M-Smart Documents"; Integer)
        {
            Caption = 'Open M-Smart Documents';
            CalcFormula = COUNT("M-Smart Documents" WHERE("Landing Department" = const(FOSA), Status = const(Open)));
            FieldClass = FlowField;
        }
        field(21; "Approved Loans"; Integer)
        {
            CalcFormula = Count(Loans WHERE(Status = FILTER(Approved), Posted = const(false)));
            FieldClass = FlowField;
        }
        field(22; "Applied Loans"; Integer)
        {
            //CalcFormula = Count(Loans WHERE(Status = FILTER(Open)));
            CalcFormula = Count(Loans WHERE(Status = FILTER(Open), Posted = filter(false)));
            FieldClass = FlowField;
        }
        field(23; "Appraised Loans"; Integer)
        {
            //CalcFormula = Count(Loans WHERE(Status = FILTER(Pending)));
            CalcFormula = Count(Loans WHERE(Status = FILTER(Pending), Posted = filter(false)));
            FieldClass = FlowField;
        }
        field(24; "Rejected Loans"; Integer)
        {
            Caption = 'Rejected/Archived Loans';
            CalcFormula = Count(Loans WHERE(Status = FILTER(Rejected | Archived)));
            FieldClass = FlowField;
        }
        field(25; "Deffered Loans"; Integer)
        {
            //CalcFormula = Count(Loans WHERE(Status = FILTER(Deffered)));
            CalcFormula = Count(Loans WHERE(Status = FILTER(Deffered), Posted = filter(false)));
            FieldClass = FlowField;
        }
        field(27; "Disbursed Loans"; Integer)
        {
            CalcFormula = Count(Loans WHERE(Posted = FILTER(true)));
            FieldClass = FlowField;
        }
        field(28; "Overdue Loans"; Integer)
        {
            CalcFormula = Count(Loans WHERE(Defaulted = FILTER(true)));
            FieldClass = FlowField;
        }
        field(29; "Outstanding Loan Balances"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = SUM("Credit Ledger Entry".Amount WHERE("Transaction Type" = filter(loan | Repayment)));
            Caption = 'Total Loan Balances';
            AutoFormatExpression = '1,KSh ';
            AutoFormatType = 10;
            Editable = false;
        }
        field(30; "Outstanding Interest Balances"; Decimal)
        {
            FieldClass = FlowField;
            AutoFormatExpression = '1,KSh ';
            AutoFormatType = 10;
            CalcFormula = sum("Credit Ledger Entry".Amount WHERE("Transaction Type" = FILTER("Interest Due" | "Interest Paid")));
            //CalcFormula = sum("Credit Ledger Entry".Amount WHERE("Transaction Type" = FILTER("Interest Due")));
            Caption = 'Total Outstanding Interests';
            Editable = false;

        }
        field(31; "Total Loans Disb. This Month"; Decimal)
        {
            AutoFormatExpression = '1,KSh ';
            AutoFormatType = 10;
            Caption = 'Total Loans Disbursed this month';
            FieldClass = Normal;
        }
        field(32; "Total Interest Paid"; Decimal)
        {
            AutoFormatExpression = '1,KSh ';
            AutoFormatType = 10;
            Caption = 'Total Interest paid this month';
            FieldClass = FlowField;
            CalcFormula = sum("Credit Ledger Entry".Amount WHERE("Transaction Type" = FILTER("Interest Paid")));

        }
        field(33; "Total Loans paid this month"; Decimal)
        {
            AutoFormatExpression = '1,KSh ';
            AutoFormatType = 10;
            Caption = 'Total Loan paid this month';

        }
        field(34; "Active Members"; Integer)
        {
            CalcFormula = Count(Members WHERE(Status = FILTER(Active)));
            FieldClass = FlowField;
        }
        field(35; "Dormant Members"; Integer)
        {
            CalcFormula = Count(Members WHERE(Status = FILTER(Dormant)));
            FieldClass = FlowField;
        }
        field(36; "Withdrawals Notices"; Integer)
        {
            CalcFormula = Count("Member withdrawal Notice" WHERE(Status = FILTER(Open)));
            FieldClass = FlowField;
        }
        field(37; "Total Interest paid this month"; Decimal)
        {
            AutoFormatExpression = '1,KSh ';
            AutoFormatType = 10;
            Caption = 'Total Interest paid this month';

        }
        field(38; "Total Outstanding Interest"; Decimal)
        {
            FieldClass = FlowField;
            AutoFormatExpression = '1,KSh ';
            AutoFormatType = 10;
            CalcFormula = sum("Credit Ledger Entry".Amount WHERE("Transaction Type" = FILTER("Interest Due")));
            Editable = false;
        }
        field(39; "code"; Code[10])
        {
        }
        // field(40; "Open M-Smart Documents"; Integer)
        // {
        //     Caption = 'Open M-Smart Documents';
        //     CalcFormula = COUNT("M-Smart Documents" WHERE("Landing Department" = const(BOSA), Status = const(Open)));
        //     FieldClass = FlowField;
        // }
    }

    keys
    {
        key(PrimaryKey; "PrimaryKey")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


