table 52187300 "Loan Cue"
{

    fields
    {
        field(1; "Approved Loans"; Integer)
        {
            CalcFormula = Count(Loans WHERE(Status = FILTER(Approved), Posted = const(false)));
            FieldClass = FlowField;
        }
        field(2; "Applied Loans"; Integer)
        {
            //CalcFormula = Count(Loans WHERE(Status = FILTER(Open)));
            CalcFormula = Count(Loans WHERE(Status = FILTER(Open), Posted = filter(false)));
            FieldClass = FlowField;
        }
        field(3; "Appraised Loans"; Integer)
        {
            //CalcFormula = Count(Loans WHERE(Status = FILTER(Pending)));
            CalcFormula = Count(Loans WHERE(Status = FILTER(Pending), Posted = filter(false)));
            FieldClass = FlowField;
        }
        field(4; "Rejected Loans"; Integer)
        {
            Caption = 'Rejected/Archived Loans';
            CalcFormula = Count(Loans WHERE(Status = FILTER(Rejected | Archived)));
            FieldClass = FlowField;
        }
        field(5; "Deffered Loans"; Integer)
        {
            //CalcFormula = Count(Loans WHERE(Status = FILTER(Deffered)));
            CalcFormula = Count(Loans WHERE(Status = FILTER(Deffered), Posted = filter(false)));
            FieldClass = FlowField;
        }
        field(7; "Disbursed Loans"; Integer)
        {
            CalcFormula = Count(Loans WHERE(Posted = FILTER(true)));
            FieldClass = FlowField;
        }
        field(8; "Overdue Loans"; Integer)
        {
            Caption = 'Defaulted Loans';
            CalcFormula = Count(Loans WHERE(Defaulted = FILTER(true)));
            FieldClass = FlowField;
        }
        field(9; "Outstanding Loan Balances"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = SUM("Credit Ledger Entry".Amount WHERE("Transaction Type" = filter(loan | Repayment)));
            Caption = 'Total Loan Balances';
            AutoFormatExpression = '1,KSh ';
            AutoFormatType = 10;
            Editable = false;
        }
        field(10; "Outstanding Interest Balances"; Decimal)
        {
            FieldClass = FlowField;
            AutoFormatExpression = '1,KSh ';
            AutoFormatType = 10;
            CalcFormula = sum("Credit Ledger Entry".Amount WHERE("Transaction Type" = FILTER("Interest Due" | "Interest Paid")));
            //CalcFormula = sum("Credit Ledger Entry".Amount WHERE("Transaction Type" = FILTER("Interest Due")));
            Caption = 'Total Outstanding Interests';
            Editable = false;

        }
        field(11; "Total Loans Disb. This Month"; Decimal)
        {
            AutoFormatExpression = '1,KSh ';
            AutoFormatType = 10;
            Caption = 'Total Loans Disbursed this month';
            FieldClass = Normal;
        }
        field(12; "Total Interest Paid"; Decimal)
        {
            AutoFormatExpression = '1,KSh ';
            AutoFormatType = 10;
            Caption = 'Total Interest paid this month';
            FieldClass = FlowField;
            CalcFormula = sum("Credit Ledger Entry".Amount WHERE("Transaction Type" = FILTER("Interest Paid")));

        }
        field(13; "Total Loans paid this month"; Decimal)
        {
            AutoFormatExpression = '1,KSh ';
            AutoFormatType = 10;
            Caption = 'Total Loan paid this month';

        }
        field(14; "Active Members"; Integer)
        {
            CalcFormula = Count(Members WHERE(Status = FILTER(Active)));
            FieldClass = FlowField;
        }
        field(15; "Dormant Members"; Integer)
        {
            CalcFormula = Count(Members WHERE(Status = FILTER(Dormant)));
            FieldClass = FlowField;
        }
        field(16; "Withdrawals Notices"; Integer)
        {
            CalcFormula = Count("Member withdrawal Notice" WHERE(Status = FILTER(Open)));
            FieldClass = FlowField;
        }
        field(17; "Total Interest paid this month"; Decimal)
        {
            AutoFormatExpression = '1,KSh ';
            AutoFormatType = 10;
            Caption = 'Total Interest paid this month';

        }
        field(18; "Total Outstanding Interest"; Decimal)
        {
            FieldClass = FlowField;
            AutoFormatExpression = '1,KSh ';
            AutoFormatType = 10;
            CalcFormula = sum("Credit Ledger Entry".Amount WHERE("Transaction Type" = FILTER("Interest Due")));
            Editable = false;
        }
        field(6; "code"; Code[10])
        {
        }
        field(20; "Open M-Smart Documents"; Integer)
        {
            Caption = 'Open M-Smart Documents';
            CalcFormula = COUNT("M-Smart Documents" WHERE("Landing Department" = const(BOSA), Status = const(Open)));
            FieldClass = FlowField;
        }
        field(21; "Loans from Portal"; Integer)
        {
            Caption = 'Open Portal Loans';
            CalcFormula = COUNT("Loans" WHERE("Source Aplication" = filter("Member Portal"), Status = const(Open)));
            FieldClass = FlowField;
        }
        field(22; "Loans from APP"; Integer)
        {
            Caption = 'Open APP Loans';
            CalcFormula = COUNT("Loans" WHERE("Source Aplication" = filter("Mbanking - APP"), Status = const(Open)));
            FieldClass = FlowField;
        }
        field(23; "Open Loan Variation"; Integer)
        {
            Caption = 'Open Loan Variation';
            CalcFormula = COUNT("Product Variations" WHERE("Source Application" = filter("Member Portal"), Status = const(Open), "Variation Type" = const(loan)));
            FieldClass = FlowField;
        }
        field(24; "Open Deposit Variation"; Integer)
        {
            Caption = 'Open Deposit Variation';
            CalcFormula = COUNT("Product Variations" WHERE("Source Application" = filter("Member Portal"), Status = const(Open), "Variation Type" = const(Savings)));
            FieldClass = FlowField;
        }
        field(25; "Channels Pending Approval"; Integer)
        {
            CalcFormula = COUNT("Loans" WHERE("Source Aplication" = filter("Member Portal" | "Mbanking - APP"), Status = const(Pending), Posted = filter(false)));
            FieldClass = FlowField;
        }
        field(26; "Channels Approved Loans"; Integer)
        {
            CalcFormula = COUNT("Loans" WHERE("Source Aplication" = filter("Member Portal" | "Mbanking - APP"), Status = const(Approved), Posted = filter(false)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

