table 52185482 "Loan Product Availability"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan Product Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Product Factory"."Product ID";
            editable = false;
        }

        field(2; Month; Enum "Loan Month")
        {
            DataClassification = CustomerContent;
        }

        field(3; Accessible; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(4; "Last Modified By"; Code[50])
        {
            Editable = false;
        }

        field(5; "Last Modified At"; DateTime)
        {
            Editable = false;
        }
        field(6; "Upfront Interest Rate"; Decimal)
        {
            trigger OnValidate()
            var
                TheProduct: Record "Product Factory";
            begin

                TheProduct.Reset();
                TheProduct.SetRange("Product ID", "Loan Product Code");

                if TheProduct.FindFirst() then begin
                    if TheProduct."Status" = TheProduct."Status"::Active then begin
                        Error('Kindly Open the product for editing');
                    end;
                end;

                if "Upfront Interest Rate" = 0 then begin
                    Error('Upfront Interest Rate must be provided and cannot be zero.');
                end else if "Upfront Interest Rate" < 0 then begin
                    Error('Upfront Interest Rate cannot be negative.');
                end;
            end;
        }
    }

    keys
    {
        key(PK; "Loan Product Code", Month)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Last Modified By" := UserId;
        "Last Modified At" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        "Last Modified By" := UserId;
        "Last Modified At" := CurrentDateTime;
        // if status of the product is active do not allow edit instead throw error 

    end;
}