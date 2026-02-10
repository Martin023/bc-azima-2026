table 52185865 "Farmer Purchase Broker Setup"
{

    fields
    {
        field(1; "Witholding Tax Rate (%)"; Decimal)
        {
            Editable = false;
        }
        field(2; "Witholding Tax Account"; Code[20])
        {
            Editable = false;
            NotBlank = true;
            // 
        }
        field(3; "Brokerage Charge Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Item Charge"."No.";
        }
        field(4; "Primary Key"; Code[10])
        {
        }
        field(5; "Broker Rate in KES Per Bag"; Decimal)
        {
        }
        field(6; "Min. Brokerage Amnt Taxable"; Decimal)
        {
        }
        field(7; "Withholding Tax Code"; Code[20])
        {
            TableRelation = "Tariff Code s".Code;

            trigger OnValidate()
            begin
                TCode.Reset;
                TCode.Get("Withholding Tax Code");
                "Witholding Tax Rate (%)" := TCode.Percentage;
                "Witholding Tax Account" := TCode."Account No.";
            end;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        TCode: Record "Tariff Code s";
}

