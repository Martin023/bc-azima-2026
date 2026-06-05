table 52185474 "Product Supported Classes"
{
    Caption = 'Product Supported Classes';
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
        field(3; "Class Category"; Enum "Member Classes")
        {
            Caption = 'Class Category';
            trigger OnValidate()
            var
                ExistingClass: Record "Product Supported Classes";
            begin
                ExistingClass.SetRange("Product ID", Rec."Product ID");
                ExistingClass.SetRange("Class Category", Rec."Class Category");
                if not ExistingClass.IsEmpty() then
                    Error('Class category %1 has already been added.', Rec."Class Category");
            end;
        }
    }
    keys
    {
        key(PK; "Product ID", "Line No.")
        {
            Clustered = true;
        }
    }
}
