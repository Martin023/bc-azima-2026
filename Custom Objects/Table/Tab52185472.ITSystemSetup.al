table 52185472 "IT System Setup"
{
    Caption = 'IT System Setup';
    DataClassification = ToBeClassified;
    LookupPageId = "IT System Setup List";
    DrillDownPageId = "IT System Setup List";

    fields
    {
        field(1; "System Code"; Code[20])
        {
            Caption = 'System Code';
            NotBlank = true;
        }

        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }

        field(3; "Requires ICT Approval"; Boolean)
        {
            Caption = 'Requires ICT Approval';
        }

        field(4; "Requires Admin Approval"; Boolean)
        {
            Caption = 'Requires Admin Approval';
        }

        field(5; Active; Boolean)
        {
            Caption = 'Active';
        }
    }

    keys
    {
        key(PK; "System Code")
        {
            Clustered = true;
        }
    }
}
