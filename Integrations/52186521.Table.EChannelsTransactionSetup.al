table 52186521 "E-Channels Transaction Setup"
{
    Caption = 'E-Channels Transaction Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "ATM Withdrawal Limit"; Decimal)
        {
            Caption = 'ATM Withdrawal Limit Value (Per Transaction)';
            trigger OnValidate()
            begin
                if "ATM Withdrawal Limit" <= 0 then begin
                    Error('Value must be greater than 0');
                end;
                if "ATM Daily Withdrawals Limit" <> 0 then begin
                    if "ATM Withdrawal Limit" > "ATM Daily Withdrawals Limit" then begin
                        Error('Withdrawal limit value may NOT be greater than the daily withdrawals limit value');
                    end;
                end;
            end;
        }
        field(3; "ATM Daily Withdrawals Limit"; Decimal)
        {
            Caption = 'ATM Daily Withdrawals Limit Value';
            trigger OnValidate()
            begin
                if "ATM Daily Withdrawals Limit" <= 0 then begin
                    Error('Value must be greater than 0');
                end;
                if "ATM Withdrawal Limit" <> 0 then begin
                    if "ATM Daily Withdrawals Limit" < "ATM Withdrawal Limit" then begin
                        Error('Daily withdrawal limit value may NOT be lesser than the transaction withdrawal limit value');
                    end;
                end;
            end;
        }
        field(4; "Mobile Withdrawal Limit"; Decimal)
        {
            Caption = 'Mobile Withdrawal Limit Value (Per Transaction)';
            trigger OnValidate()
            begin
                if "Mobile Withdrawal Limit" <= 0 then begin
                    Error('Value must be greater than 0');
                end;
                if "Mobile Daily Withdrawal Limit" <> 0 then begin
                    if "Mobile Withdrawal Limit" > "Mobile Daily Withdrawal Limit" then begin
                        Error('Withdrawal limit value may NOT be greater than the daily withdrawals limit value');
                    end;
                end;
            end;
        }
        field(5; "Mobile Daily Withdrawal Limit"; Decimal)
        {
            Caption = 'Mobile Daily Withdrawal Limit';
            trigger OnValidate()
            begin
                if "Mobile Daily Withdrawal Limit" <= 0 then begin
                    Error('Value must be greater than 0');
                end;
                if "Mobile Withdrawal Limit" <> 0 then begin
                    if "Mobile Daily Withdrawal Limit" < "Mobile Withdrawal Limit" then begin
                        Error('Daily Withdrawal limit value may NOT be lesser than the Withdrawals limit value');
                    end;
                end;
            end;
        }
        field(6; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(7; "Last Updated By"; Code[50])
        {
            Caption = 'Last Updated By';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Last Updated By" := UserId;

        // Validate("ATM Withdrawal Limit");
        // Validate("ATM Daily Withdrawals Limit");
        // Validate("Mobile Withdrawal Limit");
        // Validate("Mobile Daily Trans. Limit");
    end;

    trigger OnModify()
    begin
        "Last Updated By" := UserId;
    end;
}
