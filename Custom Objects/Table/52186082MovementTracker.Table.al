table 52186082 "Movement Tracker"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "Approval Type"; Option)
        {
            OptionCaption = ' ,Loans,Special Loans,Personal Loans,Refunds,Funeral Expenses,Withdrawals - Resignation,Withdrawals - Death,Branch Loans';
            OptionMembers = " ",Loans,"Special Loans","Personal Loans",Refunds,"Funeral Expenses","Withdrawals - Resignation","Withdrawals - Death","Branch Loans";
        }
        field(3; Stage; Integer)
        {
            TableRelation = "File Stations".Description WHERE("Station No." = FIELD("Approval Type"));
        }
        field(4; Remarks; Text[50])
        {
        }
        field(5; Status; Option)
        {
            OptionCaption = 'Being Processed,Approved,Rejected';
            OptionMembers = "Being Processed",Approved,Rejected;
        }
        field(6; "Current Location"; Boolean)
        {
        }
        field(7; "Date/Time In"; DateTime)
        {
        }
        field(8; "Date/Time Out"; DateTime)
        {
        }
        field(9; "USER ID"; Code[20])
        {
        }
        field(10; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(11; Description; Text[50])
        {
        }
        field(12; Station; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

