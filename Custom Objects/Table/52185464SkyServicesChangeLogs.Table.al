table 52185464 "Sky Services Change Logs"
{

    fields
    {
        field(1; GUID; Guid)
        {
        }
        field(2; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(5; "Type of Change"; Option)
        {
            OptionMembers = " ","Mpesa Withdrawal","Utility Bill Payment","Bank Transfer","Transfer to Other Account","Agent Withdrawal";
        }
        field(6; "Reason For Change"; Text[250])
        {
        }
        field(50050; "Initiated By"; Code[50])
        {
        }
        field(50051; "Date Initiated"; Date)
        {
        }
        field(50052; "Change ID"; Guid)
        {
        }
        field(50053; "Approved By"; Code[50])
        {
        }
        field(50054; "Date Approved"; Date)
        {
        }
        field(50055; "Rejected By"; Code[50])
        {
        }
        field(50056; "Date Rejected"; Date)
        {
        }
    }

    keys
    {
        key(Key1; GUID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

