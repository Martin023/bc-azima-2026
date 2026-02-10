table 52185440 "Digit Custodian Setup"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Digit Custodian Setup";
    LookupPageId = "Digit Custodian Setup";

    fields
    {
        // Entry No. Auto Integer
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }

        // Responsible Office Code
        field(2; "Responsible Officer Code"; Code[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Usetup: Record "User Setup";
            begin
                Usetup.get("Responsible Officer Code");
                Rec."Responsible Officer Name" := Usetup."Full Name";
                Rec."Responsible Officer Extension" := Usetup."Employee Extension No.";
                Rec."Responsible Officer Email" := Usetup."E-Mail";
            end;
        }

        // Supervisor Office Code
        field(3; "Supervisor Officer Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        // Digit Custodian
        field(4; "Digit Custodian"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        // Active
        field(5; Active; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Department; enum "Responsibility Center Enum")
        {

        }

        field(7; "Sub Module"; enum "Sub Module")
        {
        }
        field(8; "Sealed"; Boolean)
        {
            Editable = false;
        }
        field(9; "Responsible Officer Name"; Text[150])
        {
            Editable = false;
        }
        field(10; "Responsible Officer Extension"; Text[50])
        {
            Editable = false;
        }
        field(11; "Responsible Officer Email"; Text[150])
        {
            Editable = false;
        }

    }


    keys
    {
        // Primary key
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    begin

        if Sealed then Error('To delete this entry, you need to deactivate the user through system edits, filter %1', "Entry No.");
    end;
}