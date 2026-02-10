table 52186238 "Log Endpoint  Entiries"
{
    DrillDownPageID = "Log Entries Endpoints";
    LookupPageID = "Log Entries Endpoints";

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Name; Code[50])
        {
        }
        field(3; Enabled; Option)
        {
            OptionMembers = YES,NO;
        }
        field(4; "Password Verification"; Option)
        {
            OptionMembers = ACTIVE,INACTIVE;
        }
        field(5; "OTP Verification"; Option)
        {
            OptionMembers = ACTIVE,INACTIVE;
        }
        field(6; "User ID"; Code[50])
        {
        }
        field(7; Date; Date)
        {
        }
        field(8; Time; Time)
        {
        }
        field(9; "Action"; Option)
        {
            OptionMembers = Insert,Delete,Modify;
        }
        field(10; "Affected Field/Row"; Text[60])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    var
        userN: Record "Portal Endpoints";
    begin
    end;

    var
        logentry: Record "Portal Endpoints";
}

