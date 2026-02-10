table 52186118 "Related Product Application"
{

    fields
    {
        field(1; "Product Code"; Code[10])
        {
            TableRelation = "Product Factory"."Product ID";
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
        field(4; "Document No."; Code[20])
        {
        }
        field(5; "Entry No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Product: Record "Product Factory";
}

