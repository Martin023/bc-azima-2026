table 52185656 "Salary Notch"
{
    DrillDownPageID = "Salary Notches";
    LookupPageID = "Salary Notches";

    fields
    {
        field(1; "Salary Grade"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Salary Grades"."Salary Grade";
        }
        field(2; "Salary Notch"; Code[20])
        {
            NotBlank = true;
        }
        field(3; Description; Text[100])
        {
        }
        field(4; "Salary Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                "Annual Salary Amount" := "Salary Amount" * 12;
            end;
        }
        field(5; "Hourly Rate"; Decimal)
        {
        }
        field(6; "Annual Salary Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Annual Salary Amount" > 0 then
                    "Salary Amount" := "Annual Salary Amount" / 12;
            end;
        }
    }

    keys
    {
        key(Key1; "Salary Grade", "Salary Notch")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

