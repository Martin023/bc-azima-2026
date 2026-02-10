table 52187152 "Bulk Processing Errors"
{
    Caption = 'Bulk Processing Errors';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            AutoIncrement = true;
        }
        field(2; "Record ID"; Code[100])
        {
            Caption = 'Record ID';
        }
        field(3; "Member No"; Code[100])
        {
            Caption = 'Member No';
        }
        field(4; Error; Text[1000])
        {
            Caption = 'Error';
        }
        field(5; Process; Enum "Bulk Errors Process")
        {
            Caption = 'Process';
        }
        field(6; Severity; Option)
        {
            OptionMembers = " ",Warning,Error;
        }
        field(7; "Batch No"; code[100])
        {
            
        }
        field(50; "Generate By"; Code[100])
        {

        }
    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Generate By" := UserId;
    end;
}
