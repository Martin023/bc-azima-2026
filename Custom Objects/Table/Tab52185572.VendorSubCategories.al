table 52185572 "Vendor SubCategories"
{
    Caption = 'Vendor SubCategories';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Vendor SubCategories List";
    LookupPageId = "Vendor SubCategories List";

    fields
    {
        field(1; "Vendor Category"; Code[250])
        {
            Caption = 'Vendor Category';
            TableRelation = "Vendor Categories"."Vendor Category";
            NotBlank = true;
        }
        field(2; "Vendor SubCategory"; Code[250])
        {
            Caption = 'Vendor SubCategory';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(PK; "Vendor Category", "Vendor SubCategory")
        {
            Clustered = true;
        }
    }
}
