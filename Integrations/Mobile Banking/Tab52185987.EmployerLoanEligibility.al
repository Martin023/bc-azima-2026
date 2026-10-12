table 52185987 "Employer Loan Eligibility"
{
    Caption = 'Employer Loan Eligibility';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Product ID"; Code[20])
        {
            Caption = 'Product ID';
            TableRelation = "Product Factory"."Product ID";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Employer Code"; Code[20])
        {
            Caption = 'Employer Code';
            TableRelation = Customer."No." WHERE("Account Type" = CONST("Employer code"));

            trigger OnValidate()
            var
                Customer: Record Customer;
                ExistingEmployer: Record "Employer Loan Eligibility";
            begin
                if Customer.Get("Employer Code") then
                    "Employer Name" := Customer.Name
                else
                    "Employer Name" := '';

                if "Employer Code" <> '' then begin
                    ExistingEmployer.SetRange("Product ID", Rec."Product ID");
                    ExistingEmployer.SetRange("Employer Code", Rec."Employer Code");
                    if Rec."Line No." <> 0 then
                        ExistingEmployer.SetFilter("Line No.", '<>%1', Rec."Line No.");
                    if not ExistingEmployer.IsEmpty() then
                        Error('Employer %1 (%2) is already listed for this product.', "Employer Code", "Employer Name");
                end;
            end;
        }
        field(4; "Employer Name"; Text[100])
        {
            Caption = 'Employer Name';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Product ID", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        CheckIfProductIsOpen();
    end;

    trigger OnModify()
    begin
        CheckIfProductIsOpen();
    end;

    trigger OnDelete()
    begin
        CheckIfProductIsOpen();
    end;

    local procedure CheckIfProductIsOpen()
    var
        ProductFactory: Record "Product Factory";
    begin
        if ProductFactory.Get(Rec."Product ID") then begin
            if ProductFactory.Status <> ProductFactory.Status::Open then
                Error('Changes are not allowed because Product %1 status is %2 (Must be Open).', Rec."Product ID", ProductFactory.Status);
        end;
    end;
}
