table 52187348 "Appeal Lines Table"
{
    Caption = 'Appeal Lines Table';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "No"; Code[20])
        {
            Caption = '';
        }
        field(2; "Appeal No"; Code[20])
        {
            Caption = '';
        }
        field(3; Court; Option)
        {
            OptionMembers = "High Court", "Trubunal", "Employment Court";  
        }
        field(5; Discussion; Text[250])
        {
            Caption = '';
        }
        field(6; "Date of Discussion"; Date)
        {
            Caption = '';
        }
        field(7; "Captured By"; Code[20])
        {
            Caption = '';
        }
        field(8; "Date Captured"; DateTime)
        {
            Caption = '';
        }

    }
    keys
    {
        key(PK; "No")
        {
            Clustered = true;
        }
    }
trigger OnInsert()
    
    begin
        Rec."Date Captured" := CURRENTDATETIME;
        Rec."Captured By" := UserId;
    end;
}
