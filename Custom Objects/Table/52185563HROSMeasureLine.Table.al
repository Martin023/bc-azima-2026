table 52185563 "HR OSMeasure Line"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; "Measure No"; Code[10])
        {
        }
        field(3; "Damage"; Option)

        {
            OptionMembers = Scratch,Dent,Crack,Damage,Other;
        }
        field(4; "Damage Description"; Text[100])
        {
        }
        field(6; "Damage Costs"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Damage Costs" > 0 then
                    "Total Costs" := "Other Costs" + "Damage Costs";
            end;
        }
        field(7; "Other Costs"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Other Costs" > 0 then
                "Total Costs" := "Other Costs" + "Damage Costs"
            end;
        }
        field(8; "Total Costs"; Decimal)
        {
        }
        field(9; "Captured By"; Code[50])
        {
        }
        field(10; "Captured On"; DateTime)
        {
        }
        // field(11; Assessor; Code[50])
        // {
        //     TableRelation = Vendor."No.";
        //     trigger OnValidate()

        //     begin
        //         Vendor.Reset();
        //         Vendor.Get(Assessor);
        //         if Vendor.fIND ('-') then

        //             "Assessor Name" := Vendor.Name;
        //     end;

        // }
        field(12; "Assessor Name"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Code", "Measure No")
        {
            Clustered = true;
        }
        key(Key2; "Measure No")
        {
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


    var
        Vendor: Record Vendor;
}

