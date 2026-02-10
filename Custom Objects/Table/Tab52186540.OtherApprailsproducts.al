table 52186540 "Other Apprails products"
{
    Caption = 'Other Apprail products';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Product code"; Code[20])
        {
            Caption = 'Product code';
            TableRelation = "Product Factory"."Product ID";
            trigger OnValidate()
            var
                myInt: Integer;
                otherProducts: Record "Product Factory";
            begin
                otherProducts.Reset();
                otherProducts.SetRange(otherProducts."Product ID", Rec."Product code");
                if otherProducts.Find('-') then begin
                    Rec."Product Name" := otherProducts."Product Description";
                end;

            end;
        }
        field(2; "Product Name"; Text[100])
        {
            Caption = 'Product Name';
            Editable = false;
        }
        field(3; "Product ID"; Code[20])
        {
            Caption = 'Product ID';
        }
    }
    keys
    {
        key(PK; "Product code", "Product ID")
        {
            Clustered = true;
        }
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
        if PFact.get(Rec."Product ID") then begin
            if Pfact.Status <> Pfact.status::Open then
                error('You can not modify changes when the product status is ' + format(Pfact.Status) + '.');
        end;
    end;

    var
        Pfact: Record "Product Factory";
}
