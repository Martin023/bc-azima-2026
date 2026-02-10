table 52187005 "Treasury Cheques Register"
{

    fields
    {
        field(1; "Cheque No."; Code[6])
        {
        }
        field(2; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Pending,Approved,Cancelled,Received';
            OptionMembers = Pending,Approved,Cancelled,Received;
        }
        field(3; "Approval Date"; Date)
        {
        }
        field(4; "Application No."; Code[10])
        {
        }
        field(5; "Cancelled/Stopped By"; Code[50])
        {
        }
        field(6; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(10; Payee; Text[100])
        { }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(9; "Leaf Limit Amount"; Decimal)
        {
        }
        field(11; Amount; Decimal) { }
        field(12; "Treasury Control"; Code[20])
        {
            TableRelation = "Bank Account";
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Cheque No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Cheque No.", Payee)
        {

        }

    }
}

