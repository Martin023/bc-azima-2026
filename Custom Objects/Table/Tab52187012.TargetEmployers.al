table 52187012 "Target Employers"
{
    Caption = 'Target Employers';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Product ID"; Code[20])
        {
            Caption = 'Product ID';
            TableRelation = "Product Factory";
        }
        field(2; "Employer Code"; Code[20])
        {
            Caption = 'Employer Code';
            TableRelation = Customer;
            trigger OnValidate()
            var
                Cust: Record customer;
            begin
                "Employer Name" := '';
                if Cust.get("Employer Code") then
                    "Employer Name" := Cust.name else
                    "Employer Name" := '';
            end;
        }
        field(3; "Employer Name"; Text[50])
        {
            Caption = 'Employer Name';
        }
    }
    keys
    {
        key(PK; "Product ID", "Employer Code")
        {
            Clustered = true;
        }
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
        if PFact.get(Rec."Product ID") then begin
            if Pfact.Status <> Pfact.status::Open then
                error('You can not modify changes when the product status is ' + format(Pfact.Status) + '.');
        end;
    end;

    var
        ProdFac: Record "Product Factory";
        PFact: Record "Product Factory";
}
