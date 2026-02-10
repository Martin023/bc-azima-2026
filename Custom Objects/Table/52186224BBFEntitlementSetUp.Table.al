table 52186224 "BBF Entitlement SetUp"
{

    fields
    {
        // field(1; "BBF Code"; Code[50])
        // {
        //     TableRelation = "BBF Entitlement".Code;
        // }
        field(2; "Start Date"; Date)
        {
        }
        field(3; "End Date"; Date)
        {
        }
        field(4; "Member Amount"; Decimal)
        {
        }
        field(5; "Sacco Amount"; Decimal)
        {
        }
        field(6; "Sacco G/L"; Code[30])
        {
            TableRelation = "G/L Account"."No.";

            trigger OnValidate()
            var
                GLAccount: Record "G/L Account";
            begin
                if GLAccount.Get("Sacco G/L") then
                    "Sacco G/L Name" := GLAccount.Name;
            end;
        }
        field(7; "Sacco G/L Name"; Text[100])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1;  "Start Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

