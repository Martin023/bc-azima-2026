table 52186810 "OverDue Loans"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; "Loan No"; code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Loan Product Type"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "OverDre Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Sasra Categorization"; enum "Loan Sasra categories")
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Overdue days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Member No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Member Name"; Decimal)
        {
            DataClassification = ToBeClassified;
        }



    }

    keys
    {
        key(Key1; "No.")
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