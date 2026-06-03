table 50101 "Blocked Employers"
{
    Caption = 'Blocked Employers';
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
            TableRelation = Customer."No." WHERE("Account Type" = CONST(Employer));

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if Customer.Get("Employer Code") then
                    "Employer Name" := Customer.Name
                else
                    "Employer Name" := '';

                CheckDuplicateEmployer();
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

    local procedure CheckDuplicateEmployer()
    var
        ExistingBlock: Record "Blocked Employers";
    begin
        if "Employer Code" = '' then
            exit;

        ExistingBlock.SetRange("Product ID", Rec."Product ID");
        ExistingBlock.SetRange("Employer Code", Rec."Employer Code");
        if Rec."Line No." <> 0 then
            ExistingBlock.SetFilter("Line No.", '<>%1', Rec."Line No.");

        if not ExistingBlock.IsEmpty() then
            Error('Employer %1 (%2) is already blocked for this product.', "Employer Code", "Employer Name");
    end;
}