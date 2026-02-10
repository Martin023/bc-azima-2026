table 52185960 "Legal Line"
{

    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; Discussion; Text[150])
        {
        }
        field(3; Recommendation; Text[100])
        {
        }
        field(4; Date; Date)
        {
            trigger OnValidate()
            begin
                if Rec.Date > TODAY then
                    ERROR('Date cannot be in the future.');
            end;
        }
        field(5; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(7; "Captured By"; Code[50])
        {
        }
        field(8; "Captured On"; DateTime)
        {
        }
        field(9; "Case Number"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; No, "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnInsert()
    
    begin
        Rec."Captured On" := CURRENTDATETIME;
        Rec."Captured By" := UserId;
    end;
}

