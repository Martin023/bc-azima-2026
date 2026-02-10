table 52186564 "Channel Application Documents"
{
    Caption = 'Channel Application Documents';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Application No."; Code[50])
        {
            Caption = 'Application No.';
            TableRelation = if ("Application Type" = const("Application Type"::"Loan Application")) Loans."Loan No."
            else if ("Application Type" = const("Application Type"::"Member Application")) "Member Application"."No.";
            
            Editable = false;
        }
        field(3; "Document Name"; Text[1000])
        {
            Caption = 'Document Name';
            Editable = false;
        }
        field(4; Document; Blob)
        {
            Caption = 'Document';
        }
        field(5; "Document Extension"; Enum "EDMS File Types")
        {
            Caption = 'Document Extension';
            Editable = false;
        }
        field(6; "Application Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Loan Application","Member Application","Dependancy Application";
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
