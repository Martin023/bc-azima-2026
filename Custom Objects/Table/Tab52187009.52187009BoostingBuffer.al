table 52187009 "Member Form List"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Member Form List";

    fields
    {
        field(1; "Reference No"; Code[20])
        {
            Caption = 'Loan No.';
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(3; "Member No."; Code[50])
        {
            Caption = 'Member No.';
            TableRelation = Members."No.";
        }
        field(4; "Member Form Types"; Enum "Member Form Types")
        {
            Caption = 'Form Type';
        }
        field(5; filed; Boolean)
        {
            Caption = 'Filed/Received';

            trigger OnValidate()
            begin
                "Filed By" := userid;
                "Filed Date" := Today;
                "Received Date" := Today;
            end;
        }
        field(6; "Filed By"; code[20])
        {
            Caption = 'Filed By.';
        }
        field(7; "Filed Date"; Date)
        {
            Caption = 'Filed Date';
        }
        field(9; "Received Date"; Date)
        {
            Caption = 'Received Date';
        }
    }
    keys
    {
        key(PK; "Reference No", "Member No.")
        {
            Clustered = true;
        }
    }
}
