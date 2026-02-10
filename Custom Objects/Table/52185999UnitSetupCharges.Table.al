table 52185999 "Unit Setup Charges"
{

    fields
    {
        field(1; "Charge Code"; Code[20])
        {
        }
        field(2; "Floor No"; Code[30])
        {
            TableRelation = Floor."Floor Code" WHERE("No." = FIELD("Property Code"));
        }
        field(3; "Minimum Area Sq.ft"; Decimal)
        {
            Editable = true;
        }
        field(5; "Rental Rate"; Decimal)
        {
        }
        field(6; "Property Code"; Code[30])
        {
            TableRelation = "Property Details"."No.";
        }
        field(7; "No. Series"; Code[10])
        {
        }
        field(8; "Unit Code"; Code[50])
        {
            TableRelation = Unit."Unit Code" WHERE("Property No." = FIELD("Property Code"),
                                                    "Floor Code" = FIELD("Floor No"));
        }
    }

    keys
    {
        key(Key1; "Charge Code", "Floor No", "Property Code", "Unit Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Charge Code" = '' then begin
            GSetup.Get();
            GSetup.TestField(GSetup."Charge Code");
            NoSeriesMgt.InitSeries(GSetup."Charge Code", xRec."No. Series", Today, "Charge Code", "No. Series");
        end;
    end;

    var
        GSetup: Record "General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

