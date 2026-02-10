table 52186793 "PromiseTopay SMS Log"
{

    fields
    {
        
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Header No."; Code[50])
        {
            TableRelation = "Promise Topay Header";
            Editable = false;
        }
        field(3; "Member No"; Code[100])
        {
            TableRelation = Members;
            Editable = false;
            trigger OnValidate()
            var
                Members: Record Members;
            begin
                if Members.Get("Member No") then begin
                    "Member Name" := Members.Name;
                end;
            end;
        }
        
        field(5; SMS; Text[1000])
        {
            Editable = false;
        }
        field(6; "Loan Number"; Code[50])
        {
            TableRelation = Loans;
            Editable = false;
        }
        field(7; "Date Created"; DateTime)
        {
            Editable = false;
        }
        field(8; "Created By"; Code[100])
        {

        }
        field(9; "Member Name"; Text[200])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.","Header No.","Member No","Loan Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
    begin
        "Created By" := UserId;
        "Date Created" := CurrentDateTime;
    end;

}

