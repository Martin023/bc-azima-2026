table 52186258 "Vendor Categories"
{
    Caption = 'Vendor Categories';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Vendor Categories List";
    LookupPageId = "Vendor Categories List";

    fields
    {
        field(1; "Vendor Category"; Code[250])
        {
            Caption = 'Vendor Category';
        }
    }
    keys
    {
        key(PK; "Vendor Category")
        {
            Clustered = true;
        }
    }
}
