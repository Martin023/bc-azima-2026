table 52185759 "M-PESA Transactions"
{
    DrillDownPageID = "Mpesa Transactions List";
    LookupPageID = "Mpesa Transactions List";

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "Transaction Date"; Date)
        {
        }
        field(3; "Account No."; Code[50])
        {
        }
        field(4; Description; Text[220])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "Transaction Type"; Text[30])
        {
        }
        field(8; "Transaction Time"; Date)
        {
        }
        field(10; "Document Date"; Date)
        {
        }
        field(11; "Date Posted"; Date)
        {
        }
        field(12; "Time Posted"; Time)
        {
        }
        field(13; "Account Status"; Text[30])
        {
        }
        field(14; Messages; Text[200])
        {
        }
        field(15; "Needs Change"; Boolean)
        {
        }
        field(16; "Change Transaction No"; Code[20])
        {
        }
        field(17; "Old Account No"; Code[50])
        {
        }
        field(18; Changed; Boolean)
        {
        }
        field(19; "Date Changed"; Date)
        {
        }
        field(20; "Time Changed"; Time)
        {
        }
        field(21; "Changed By"; Code[30])
        {
        }
        field(22; "Approved By"; Code[30])
        {
        }
        field(25; "Key Word"; Text[30])
        {
        }
        field(27; CorporateNo; Text[30])
        {
        }
        field(28; "Telephone No"; Text[30])
        {
        }
        field(29; "Mpesa Names"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        Error('You cannot delete MPESA transactions.');
    end;

    trigger OnModify()
    begin
        /*
        ERROR('You cannot modify MPESA transactions.');
        */

    end;
}

