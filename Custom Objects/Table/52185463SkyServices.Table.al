table 52185463 "Sky Services"
{

    fields
    {
        field(1; "Key"; Integer)
        {
            Editable = false;
        }
        field(2; "Mpesa Withdrawal"; Boolean)
        {
        }
        field(3; "Utility Bill Payment"; Boolean)
        {
        }
        field(4; "Bank Transfer"; Boolean)
        {
        }
        field(5; "Type of Change"; Option)
        {
            OptionMembers = " ","Mpesa Withdrawal","Utility Bill Payment","Bank Transfer","Transfer to Other Account","Agent Withdrawal";
        }
        field(6; "Reason For Change"; Text[250])
        {
        }
        field(7; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Pending,Approved;
        }
        field(50050; "Initiated By"; Code[50])
        {
            Editable = false;
        }
        field(50051; "Date Initiated"; Date)
        {
            Editable = false;
        }
        field(50052; "Change ID"; Guid)
        {
            Editable = false;
        }
        field(50053; "Approved By"; Code[50])
        {
            Editable = false;
        }
        field(50054; "Date Approved"; Date)
        {
            Editable = false;
        }
        field(50055; "Rejected By"; Code[50])
        {
            Editable = false;
        }
        field(50056; "Date Rejected"; Date)
        {
            Editable = false;
        }
        field(50057; "Transfer to Other Account"; Boolean)
        {
        }
        field(50058; "Agent Withdrawal"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

