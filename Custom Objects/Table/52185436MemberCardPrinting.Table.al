
table 52185436 "Member Card Printing Log"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Member Card Printing Log";
    LookupPageId = "Member Card Printing Log";

    fields
    {
        // Entry No. Auto Integer
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        // Record ID Code[100] Primary Key
        field(2; "Record ID"; Code[100])
        {
            TableRelation = Members;
        }

        // Responsible Officer Code
        field(3; "Printed By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

        // Supervisor Officer Code
        field(4; "Printed At"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        // Entry Time DateTime
       
    }

    

    keys
    {
        // Primary Key
        key(PK; "Entry No.", "Record ID")
        {
            Clustered = true;
        }
    }
}
