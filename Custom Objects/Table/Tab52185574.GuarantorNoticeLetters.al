table 52185574 "Guarantor Notice Letters"
{
    Caption = 'Guarantor Notice Letters';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Guarantor Notice Letters List";
    LookupPageId = "Guarantor Notice Letters List";

    fields
    {
        field(1; EntryNo; integer)
        {
            Caption = 'No';
        }
        field(2; "Header No"; Code[20])
        {
            Caption = 'Header No';
        }
        field(3; "Loan No"; Code[20])
        {
            Caption = 'Loan No';
        }
        field(5; "Recipient Member No"; code[20])
        {
            Caption = 'Member No';
        }
        field(6; Letter; Blob)
        {
            Caption = 'Letter';
            DataClassification = ToBeClassified;
        }
        field(16; Recepient; Option)
        {
            OptionMembers = "Lonee","Guarantor";

        }
    }
    keys
    {
        key(EntryNo; EntryNo)
        {
            Clustered = true;
        }
    }
}
