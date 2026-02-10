table 52186192 "HR Heads of Departments"
{

    fields
    {
        field(1; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                "Global Dimension 1 Name" := '';
                DimensionValue.Reset;
                DimensionValue.SetRange(DimensionValue.Code, "Global Dimension 1 Code");
                if DimensionValue.Find('-') then begin
                    "Global Dimension 1 Name" := DimensionValue.Name;
                end;
            end;
        }
        field(2; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                "Global Dimension 2 Name" := '';
                DimensionValue.Reset;
                DimensionValue.SetRange(DimensionValue.Code, "Global Dimension 2 Code");
                if DimensionValue.Find('-') then begin
                    "Global Dimension 2 Name" := DimensionValue.Name;
                end;
            end;
        }
        field(3; "Global Dimension 1 Name"; Text[100])
        {
            Editable = false;
        }
        field(4; "Global Dimension 2 Name"; Text[100])
        {
            CaptionClass = '1,1,2';
            Editable = false;
        }
        field(5; "Employee No."; Code[20])
        {
            TableRelation = "HR Employees"."No." WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin
                "Employee Name" := '';
                "User ID" := '';
                "E-Mail Address" := '';
                "Responsibility center" := '';

                HREmp.Reset;
                HREmp.Get("Employee No.");
                begin
                    // "Employee Name" := HREmp.FullName;
                    HREmp.TestField(HREmp."User ID");
                    HREmp.TestField(HREmp."Company E-Mail");
                    "User ID" := HREmp."User ID";
                    "E-Mail Address" := HREmp."Company E-Mail";
                    "Responsibility center" := HREmp."Responsibility Center";
                end;
            end;
        }
        field(6; "Employee Name"; Text[100])
        {
            Editable = false;
        }
        field(7; "User ID"; Code[50])
        {
            Editable = false;
        }
        field(8; "E-Mail Address"; Text[60])
        {
        }
        field(9;"Responsibility center";Code[60])
        {
         
        }
    }

    keys
    {
        key(Key1; "Global Dimension 1 Code", "Global Dimension 2 Code", "Employee No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DimensionValue: Record "Dimension Value";
        HREmp: Record "HR Employees";
        UserSetup: Record "User Setup";
}

