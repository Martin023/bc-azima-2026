table 52185423 "Asset Transfer Line"
{
    DrillDownPageId = "Assets Transfer Line";
    fields
    {
        field(1; "Asset Transfer Header No."; Code[20])
        {
            TableRelation = "Asset Transfer"."No.";
        }
        field(10; "Asset to Transfer"; Code[20])
        {
            TableRelation = "Fixed Asset"."No." where(Status = filter(<> Disposed), Acquired = const(true));

            trigger OnValidate()
            begin
                FixedAsset.reset;
                if FixedAsset.get(rec."Asset to Transfer") then begin
                    "Asset Description" := FixedAsset.Description;
                    "Current Location" := FixedAsset."FA Location Code";
                    "Current Responsible Employee" := FixedAsset."Employee Responsible";
                    "Current Dimension 1 Code" := FixedAsset."Global Dimension 1 Code";
                    "Current Dimension 2 Code" := FixedAsset."Global Dimension 2 Code";
                end else begin
                    "Asset Description" := '';
                    "Current Location" := '';
                    "Current Responsible Employee" := '';
                    // "Current Dimension 1 Code" := '';
                    // "Current Dimension 2 Code" := '';

                end;
            end;
        }
        field(15; "Asset Description"; Text[50])
        {
        }
        field(20; "Current Location"; Code[20])
        {
        }
        field(25; "Current Responsible Employee"; Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HREmployees.Reset;
                HREmployees.SetRange("No.", "Current Responsible Employee");
                if HREmployees.Find('-') then
                    "Current Employee Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name"
                else
                    "Current Employee Name" := ' ';
            end;
        }
        field(30; "Current Employee Name"; text[100])
        {
        }
        field(31; "Current Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));
            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 1);
                DimVal.SetRange(DimVal.Code, "Current Dimension 1 Code");
                if DimVal.Find('-') then
                    "From Dimension 1 Description" := DimVal.Name
                else
                    "From Dimension 1 Description" := ' ';
            end;
        }
        field(35; "Current Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));
            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Current Dimension 2 Code");
                if DimVal.Find('-') then
                    "From Dimension 2 Description" := DimVal.Name
                else
                    "From Dimension 2 Description" := ' ';
            end;
        }
        field(50; "To Location"; Code[50])
        {
            TableRelation = "FA Location".Code;
        }
        field(55; "To Responsible Employee"; code[50])
        {
            TableRelation = "HR Employees"."No." where(status = const(Active));

            trigger OnValidate()
            begin
                HREmployees.Reset;
                HREmployees.SetRange(HREmployees."No.", "To Responsible Employee");
                if HREmployees.Find('-') then
                    "To Responsible Employee Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name"
                else
                    "To Responsible Employee Name" := ' ';
            end;
        }
        field(56; "To Responsible Employee Name"; text[100])
        {
        }
        field(60; "To Dimension Value 1 code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));
            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 1);
                DimVal.SetRange(DimVal.Code, "To Dimension Value 1 code");
                if DimVal.Find('-') then
                    "From Dimension 1 Description" := DimVal.Name
                else
                    "From Dimension 1 Description" := ' ';
            end;
        }
        field(65; "To Dimension Value 2 Code"; Code[50])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));
            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "To Dimension Value 2 code");
                if DimVal.Find('-') then
                    "From Dimension 2 Description" := DimVal.Name
                else
                    "From Dimension 2 Description" := ' ';
            end;
        }
        field(70; "From Dimension 1 Description"; text[100])
        {
        }
        field(75; "From Dimension 2 Description"; text[100])
        {
        }
        field(76; "To Dimension Value 2 Code Desc"; text[100])
        {
        }
        field(77; "To Dimension Value 1 Code Desc"; text[100])
        {
        }
        field(80; Transferred; Boolean)
        {
        }
    }
    keys
    {
        key(PK; "Asset Transfer Header No.", "Asset to Transfer")
        {
            Clustered = true;
        }
    }
    var
        FixedAsset: Record "Fixed Asset";
        HREmployees: Record "HR Employees";
        DimVal: Record "Dimension Value";

    trigger OnInsert()
    begin
        rec.Validate("Asset to Transfer");
    end;

}
