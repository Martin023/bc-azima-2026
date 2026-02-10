table 52186300 "Banking Cue"
{

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
        field(19; "Mobile Transactions"; Integer)
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
        field(21; "Portal Standing Orders"; Integer)
        {
            Caption = 'Open Standing Orders(Portal)';
            CalcFormula = Count("Standing Order Header" WHERE(Status = filter(open), "Source Application" = filter("Member Portal")));
            FieldClass = FlowField;
        }
        field(22; "Open Dependacy Application"; Integer)
        {
            Caption = 'Open Dependacy Application(Portal)';
            CalcFormula = count("Dependancies Applications" where("Source Application" = filter("Member Portal"), Status = const(Open)));
            FieldClass = FlowField;
        }
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

