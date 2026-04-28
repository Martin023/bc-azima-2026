table 52185465 "Gaming Paybills Setup"
{
    Caption = 'Gaming Paybills Setup';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Paybill / Till No."; Code[20])
        {
            Caption = 'Paybill / Till No.';
        }
        field(2; "Paybill / Till Name"; Text[250])
        {
            Caption = 'Paybill / Till Name';
        }
        field(3; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = "Active", "Inactive";
        }
        field(4; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(5; "Last Updated By"; Code[50])
        {
            Caption = 'Last Updated By';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Paybill / Till No.")
        {
            Clustered = true;
        }
    }

     trigger OnInsert()
    var
        myInt: Integer;
    begin
        "Created By" := UserId;
        "Last Updated By" := UserId;
    end;

    trigger OnModify()
    var
        myInt: Integer;
    begin
        "Last Updated By" := UserId;
    end;
}

