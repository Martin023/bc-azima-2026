table 52186505 "EDMS Files"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Application No.", "EDMS Document Name";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Application No."; Text[100])
        {
            Caption = 'Application/CRM Number';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "EDMS Document ID"; Text[100])
        {
            Caption = 'EDMS Document ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "EDMS Document Name"; Text[1000])
        {
            Caption = 'EDMS Document Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "EDMS Document Link"; Text[1000])
        {
            Caption = 'EDMS Document Link';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "EDMS File Type"; enum "EDMS File Types")
        {
            Caption = 'EDMS File Type';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Created By"; Text[100])
        {
            Caption = 'Viewed By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Updated By"; Text[100])
        {
            Caption = 'Last Viewed By';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(11; "EDMS Data Class Name"; enum "EDMS Data Classes")
        {
            Caption = 'EDMS Data Class Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }


    trigger OnInsert()
    var
        LastRecord: Record "EDMS Files";
    begin
        if LastRecord.FindLast then begin
            Rec."Entry No." := LastRecord."Entry No." + 1;
        end;
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