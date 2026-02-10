table 52185837 "Bond Company"
{
    DrillDownPageID = "Bond Beneficiary Companies";
    LookupPageID = "Bond Beneficiary Companies";

    fields
    {
        field(1; "Company Code"; Code[30])
        {
        }
        field(2; Name; Text[50])
        {
        }
        field(3; Address; Text[50])
        {
        }
        field(4; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //PostCode.LookUpPostCode(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Post Code");
            end;
        }
        field(5; City; Text[30])
        {

            trigger OnLookup()
            begin
                //PostCode.LookUpCity(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Post Code");
            end;
        }
        field(6; "Cash Cover Required"; Boolean)
        {
        }
        field(7; "Max. Perf. Bond without Securi"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Company Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PostCode: Record "Post Code";
}

