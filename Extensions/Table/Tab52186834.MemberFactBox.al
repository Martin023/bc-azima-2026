table 52186834 "Member FactBox"
{
    Caption = 'Member FactBox';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Member No."; Code[50])
        {
            Caption = 'Member No.';
        }
        field(2; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;

        }
        field(3; "BOSA Loans"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(Loans."Approved Amount" where("Source Unit" = const(BOSA), "Member No." = field("Member No."), Posted = const(true),
            "Total Balance" = filter('>0')));
        }
        field(4; "FOSA Loans"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(Loans."Approved Amount" where("Source Unit" = const(FOSA), "Member No." = field("Member No."), Posted = const(true),
            "Total Balance" = filter('>0')));
        }
        field(5; "HR Loans"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(Loans."Approved Amount" where("Source Unit" = const("HR LOANS"), "Member No." = field("Member No."), Posted = const(true),
            "Total Balance" = filter('>0')));
        }
        field(6; "BUSINESS Loans"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(Loans."Approved Amount" where("Source Unit" = const("BUSINESS LOANS"), "Member No." = field("Member No."), Posted = const(true),
            "Total Balance" = filter('>0')));
        }
        field(7; "BOSA Deposit"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - sum("Savings Ledger Entry".Amount where("Member No." = field("Member No."), "Product Category" = const("BOSA Deposits"), "Posting Date" = FIELD("Date Filter")));
        }
        field(11; "FOSA Savings"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - sum("Savings Ledger Entry".Amount where("Member No." = field("Member No."), "Product Type" = filter('191'), "Posting Date" = FIELD("Date Filter")));
        }
        field(8; "Share Capital"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - sum("Savings Ledger Entry".Amount where("Member No." = field("Member No."), "Product Category" = const("Share Capital"), "Posting Date" = FIELD("Date Filter")));
        }
        field(9; Risk; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - sum("Savings Ledger Entry".Amount where("Member No." = field("Member No."), "Product Type" = const('5'), "Posting Date" = FIELD("Date Filter")));
        }
        field(10; BBF; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - sum("Savings Ledger Entry".Amount where("Member No." = field("Member No."), "Product Type" = const('4'), "Posting Date" = FIELD("Date Filter")));
        }
        field(12; "Transferred Share Capital"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - sum("Savings Ledger Entry".Amount where("Member No." = field("Member No."), "Product Type" = const('3'), "Posting Date" = FIELD("Date Filter")));
        }
        field(13; "Entrance Fee"; Decimal)
        {
            Caption = 'Registration Fee.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - sum("Savings Ledger Entry".Amount where("Member No." = field("Member No."), "Product Type" = const('0'), "Posting Date" = FIELD("Date Filter")));
        }
        field(14; "Unallocated Funds"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - sum("Savings Ledger Entry".Amount where("Member No." = field("Member No."), "Product Category" = const("Unallocated Fund"), "Posting Date" = FIELD("Date Filter")));
        }
        field(15; "Business Deposits"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - sum("Savings Ledger Entry".Amount where("Member No." = field("Member No."), "Product Type" = const('080'), "Posting Date" = FIELD("Date Filter")));
        }
        field(16; "Bosa Monthly Contribution"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Savings Accounts"."Monthly Contribution" where("Member No." = field("Member No."), "Product Category" = const("BOSA Deposits")));
        }
        field(17; "Total Loans"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Credit Ledger Entry".Amount where("Member No." = field("Member No."), "Transaction Type" = FILTER("Interest Due" | "Interest Paid" | Loan | Repayment), "Posting Date" = FIELD("Date Filter")));
        }
        field(29; "Risk Contribution"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Savings Accounts"."Monthly Contribution" where("Member No." = field("Member No."), "Product Type" = const('5')));
        }
        field(30; "BBF Contribution"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Savings Accounts"."Monthly Contribution" where("Member No." = field("Member No."), "Product Type" = const('4')));
        }
        field(31; "Kesasa Savings"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - sum("Savings Ledger Entry".Amount where("Member No." = field("Member No."), "Product Category" = filter("Kesasa"), "Posting Date" = FIELD("Date Filter")));
        }
        field(32; "Member Name"; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Member No.")));
        }

    }
    keys
    {
        key(PK; "Member No.")
        {
            Clustered = true;
        }
    }
}
