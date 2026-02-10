table 52187390 "Guarantor Failure Reasons"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; "AcountNu"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Account No';
        }
        field(3; "Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Member Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Failure Reason"; Text[1023])
        {
            DataClassification = ToBeClassified;
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
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}