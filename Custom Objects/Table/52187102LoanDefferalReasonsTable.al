table 52187103 "Loan Defferals"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Deffercode"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Exceptions/ Rejection Reason".Code;
            trigger OnValidate()
            var
                myInt: Integer;
                Exceptions: Record "Exceptions/ Rejection Reason";
            begin
                Exceptions.Reset();
                Exceptions.SetRange(Exceptions.Code, Rec.Deffercode);
                if Exceptions.FindFirst() then begin
                    Rec.Description := Exceptions."Exceptions/ Rejection Reason";
                    Rec."Captured By" := UserId;
                    rec."Date Captured" := Today;
                end;
            end;
        }
        field(3; "Description"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Loan No."; code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Member No"; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Captured By"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Date Captured"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Sms Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No", "Member No", "Loan No.", Deffercode)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}