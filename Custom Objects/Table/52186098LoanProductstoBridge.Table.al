table 52186098 "Loan Products to Bridge"
{

    fields
    {
        field(1; "Product Code"; Code[20])
        {
            TableRelation = "Product Factory"."Product ID" WHERE("Product Class Type" = CONST(Loan));
        }
        field(2; "Product To Bridge"; Code[20])
        {
            TableRelation = "Product Factory"."Product ID" WHERE("Product Class Type" = CONST(Loan));

            trigger OnValidate()
            begin
                if ProdFac.Get("Product To Bridge") then begin
                    "Product Name" := ProdFac."Product Description";
                end;

            end;
        }
        field(3; "Product Name"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Product Code", "Product To Bridge")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnDelete()
    var
        myInt: Integer;
    begin
        ValidateEntries;
    end;

    trigger OnInsert()
    begin
        ValidateEntries;
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
        ProdFac: Record "Product Factory";
        PFact: Record "Product Factory";
}

