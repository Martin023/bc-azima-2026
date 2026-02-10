table 52186030 "Billed BHole Batch"
{

    fields
    {
        field(1; "B/Hole No."; Code[30])
        {
            TableRelation = "B/Hole Water Bill"."No." WHERE("billed tenants" = FILTER(true));

            trigger OnValidate()
            begin

                bhole.Reset;
                bhole.SetRange(bhole."No.", "B/Hole No.");
                if bhole.Find('-') then begin
                    "Property No." := bhole."Property No.";
                    "Posting Date" := bhole."Billing date";
                    // "Branch Code":=BillUnit."Global Dimension 1 Code";
                    // "Department Code":="Department Code";

                end;
            end;
        }
        field(2; "Property No."; Code[100])
        {
        }
        field(3; "Posting Date"; Date)
        {
        }
        field(4; "Branch Code"; Code[20])
        {
        }
        field(5; "Department Code"; Code[20])
        {
        }
        field(6; "Water Account"; Code[30])
        {
            TableRelation = Charges."Account No.";

            trigger OnValidate()
            begin
                Charges.Reset;
                Charges.SetRange(Charges."Account No.", "Water Account");
                if Charges.Find('-') then begin
                    "Water Code" := Charges.Code;

                end;
            end;
        }
        field(7; Posted; Boolean)
        {
        }
        field(8; "Billing Description"; Text[200])
        {
        }
        field(9; "Water Code"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "B/Hole No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        BillUnit: Record "Bill Units meter Ratings";
        bhole: Record "B/Hole Water Bill";
        Charges: Record Charges;
}

