table 52185923 "Staff Allowance Lines"
{

    fields
    {
        field(1; "Header Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Allowance Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            ////TableRelation = Table39005524;

            trigger OnValidate()
            begin
                "Allowance Description" := '';
                "Tax %" := 0;
                "Tax GL" := '';
                "Minimum Taxable Amount" := 0;
                "Minimum Tax" := 0;
                "Maximum Taxable Amount" := 0;
                "Maximum Tax" := 0;

                if "Allowance Code" <> '' then begin
                    StaffAllowanceSetUp.Get("Allowance Code");
                    "Allowance Description" := StaffAllowanceSetUp.Description;
                    "Tax %" := StaffAllowanceSetUp."Tax %";
                    "Tax GL" := StaffAllowanceSetUp."Tax GL";
                    "Allowance GL" := StaffAllowanceSetUp."Allowance GL";
                    "Exempt Amount" := StaffAllowanceSetUp."Exempt Amount";
                end;
            end;
        }
        field(3; "Allowance Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Tax %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Tax GL"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(10; "Allowance GL"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(11; "Pay to Savings Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Allowance Amount"; Decimal)
        {
        }
        field(13; "Exempt Amount"; Decimal)
        {
        }
        field(14; "Minimum Taxable Amount"; Decimal)
        {
        }
        field(15; "Minimum Tax"; Decimal)
        {
        }
        field(16; "Maximum Taxable Amount"; Decimal)
        {
        }
        field(17; "Maximum Tax"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Header Code", "Allowance Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        StaffAllowanceSetUp: Record "Staff Allowance Setup";
}

