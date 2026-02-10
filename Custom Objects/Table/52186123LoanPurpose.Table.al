table 52186123 "Loan Purpose"
{
    DrillDownPageID = "Loan Purpose";
    LookupPageID = "Loan Purpose";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Staff Salary Multiplier"; Decimal)
        {
        }
        field(4; "Available On Mobile"; Boolean)
        {

        }
        field(39004286; "Main Sector"; Code[20])
        {
            TableRelation = "Sectoral Classification"."Sector Code" where("Sector Level" = const("Main Sector"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Sub Sector Level1" := '';
                "Sub Sector Level1 Description" := '';
                "Sub Sector Level2" := '';
                "Sub Sector Level2 Description" := '';
                if SectoralClassification.Get(rec."Main Sector") then
                    "Main Sector Description" := SectoralClassification."Sector Description";
            end;
        }
        field(39004287; "Main Sector Description"; Text[100])
        {

            Editable = false;
        }
        field(39004288; "Sub Sector Level1"; Code[20])
        {
            TableRelation = "Sectoral Classification"."Sector Code" where("Sector Level" = const("Sub Sector Level 1"), "Parent Sector" = field("Main Sector"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Sub Sector Level2" := '';
                "Sub Sector Level2 Description" := '';
                SectoralClassification.Reset();
                if SectoralClassification.Get(rec."Sub Sector Level1") then
                    "Sub Sector Level1 Description" := SectoralClassification."Sector Description";
            end;
        }
        field(39004289; "Sub Sector Level1 Description"; Text[100])
        {
            Editable = false;
        }
        field(39004290; "Sub Sector Level2"; Code[20])
        {
            TableRelation = "Sectoral Classification"."Sector Code" where("Sector Level" = const("Sub Sector Level 2"), "Parent Sector" = field("Sub Sector Level1"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if SectoralClassification.Get(rec."Sub Sector Level2") then
                    "Sub Sector Level2 Description" := SectoralClassification."Sector Description";
            end;
        }
        field(39004291; "Sub Sector Level2 Description"; Text[100])
        {
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(IdxAvailableOnMobile; "Available On Mobile")
        {
            Clustered = false;
        }
    }

    fieldgroups
    {
    }
    var
        SectoralClassification: Record "Sectoral Classification";
}

