table 52186138 "DCS Loan Summary"
{
    DrillDownPageID = "DCS Loan Summary List";
    LookupPageID = "DCS Loan Summary List";

    fields
    {
        field(1; "Member No."; Code[20])
        {
        }
        field(2; "Loan No"; Code[20])
        {
        }
        field(3; "Loan Product Type"; Code[20])
        {
            Editable = true;
        }
        field(4; "Issue Date"; Date)
        {
        }
        field(5; "Loan Amount"; Decimal)
        {
            Editable = true;
        }
        field(6; "Outstanding Balance"; Decimal)
        {
        }
        field(7; "Total Paid"; Decimal)
        {
            Editable = true;
        }
        field(8; "Expected Repayment"; Decimal)
        {
        }
        field(9; Source; Code[20])
        {
        }
        field(10; "Account No"; Code[20])
        {
        }
        field(11; "Last Update Date"; DateTime)
        {
        }
    }

    keys
    {
        key(Key1; "Member No.", "Loan No", "Loan Product Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Last Update Date" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        "Last Update Date" := CurrentDateTime;
    end;
}

