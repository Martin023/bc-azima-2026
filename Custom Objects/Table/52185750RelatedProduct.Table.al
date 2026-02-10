table 52185750 "Related Product"
{

    fields
    {
        field(1; "Product Code"; Code[10])
        {
            TableRelation = "Product Factory"."Product ID" WHERE("Product Class Type" = CONST(Loan));
        }
        field(2; "Related Product Code"; Code[10])
        {
            TableRelation = "Product Factory"."Product ID";

            trigger OnValidate()
            begin
                if Product.Get("Related Product Code") then
                    "Related Product Desc" := Product."Product Description";
            end;
        }
        field(3; "Related Product Desc"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Product Code", "Related Product Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        ValidateEntries;

    end;

    trigger OnInsert()
    begin
        ValidateEntries
    end;

    trigger OnModify()
    begin
        ValidateEntries;
    end;

    procedure ValidateEntries()
    begin
        if PFact.get(Rec."Product Code") then begin
            if Pfact.Status <> Pfact.status::Open then
                error('You can not modify changes when the product status is ' + format(Pfact.Status) + '.');
        end;
    end;

    var
        Product: Record "Product Factory";
        Pfact: Record "Product Factory";
}

