table 52187035 "Business Types"
{
    LookupPageId = "Business Types";
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[30])
        {


        }
        field(2; Description; Text[100])
        {


        }
        field(3; Industry; Code[30])
        {


        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
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