table 52186508 "Sky Background Process Manager"
{
    Caption = 'Sky Background Process Manager';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Integer)
        {
            Caption = 'No';
            AutoIncrement = true;
        }
        field(2; "Records Pause Count"; Integer)
        {
            Caption = 'Records Pause Count';
            Editable = true;

            trigger OnValidate()
            begin
                if Rec."Records Pause Count" <= 0 then begin
                    Error('Value must be greater than 0');
                end;
            end;
        }
        field(3; "Threads Count"; Integer)
        {
            Caption = 'Threads Count';
            Editable = true;

            trigger OnValidate()
            begin
                if Rec."Threads Count" <= 0 then begin
                    Error('Value must be greater than 0');
                end;
            end;
        }

        // Mbanking Posting Manager
        field(4; "Disable Mob. Loan Disb."; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Disable Mobile Loan Disbursement';
        }
        field(5; "Disable Mob. Dep. Post"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Disable Mobile Deposit Transactions Posting';
        }
        field(6; "Disable Mob. Wtd. Post"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Disable Mobile Withdrawal Transactions Posting';
        }
        field(7; "Disable Mob. Internal Post"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Disable Mobile Internal Transactions Posting';
        }

        // ATM Posting Manager
        field(10; "Disable ATM. Post"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Disable ATM Transactions Posting';
        }

        field(100; "Last Modified By"; Code[50])
        {
            Caption = 'Last modified By';
            Editable = false;
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        Settings: record "Sky Background Process Manager";
    begin
        "Last Modified By" := UserId;

        if Settings.Count = 1 then begin
            Error('Insertion of more than one record is NOT allowed');
        end;
    end;

    trigger OnModify()
    begin
        "Last Modified By" := UserId;
    end;
}
