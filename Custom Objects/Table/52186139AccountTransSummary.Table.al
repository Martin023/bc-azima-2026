table 52186139 "Account Trans Summary"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; "Posting Date"; Date)
        {
        }
        field(3; "Account No"; Code[20])
        {
        }
        field(4; "Transaction Type"; Option)
        {
            OptionCaption = 'Salary,Dividend';
            OptionMembers = Salary,Dividend;
        }
        field(5; "Document No"; Code[20])
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; "Last Modified Date"; DateTime)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        "Last Modified Date" := CurrentDateTime;
    end;
}

