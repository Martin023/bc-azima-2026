table 52187008 "52187008 Employer Product Attr"
{
    Caption = 'Employer Product Attributes';
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
                customer: Record Customer;
            begin
                if customer.get(Rec."Employer Code") then begin
                    "Employer Name" := customer.Name;
                    Installments := 0;
                    Interest := 0;
                end;
            end;
        }
        field(3; Installments; Integer)
        {
            Caption = 'Installments';
        }
        field(4; Interest; Decimal)
        {
            Caption = 'Interest';
        }
        field(5; "Max Amount"; Decimal)
        {
            Caption = 'Max Amount';
        }
        field(6; "Grace Period"; DateFormula)
        {
            Caption = 'Grace Period';
        }
        field(7; "Recovery Mode"; Enum "Loan Recovery Mode")
        {
            Caption = 'Recovery Mode';
        }
        field(8; "Employer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Minimum Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Max Service year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Min service Year"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Product ID", "Employer Code", "Max Service year")
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
