table 52185547 "Mobile Transaction Types Lines"
{
    Caption = 'Mobile Transaction Types Lines';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Transaction Type"; Code[20])
        {
            TableRelation = "Mobile Transaction Types";
            // trigger OnValidate()
            // begin
            //     TransactionTypes.Reset;
            //     TransactionTypes.SetRange(TransactionTypes.Code, "Transaction Type");
            //     if TransactionTypes.Find('-') then
            //         Description := TransactionTypes.Description;
            // end;
        }
        field(2; "Charge Code"; Code[20])
        {
            Editable = false;
            Enabled = false;
        }
        field(3; Description; Text[50])
        {
        }
        field(4; "Charge Type"; Option)
        {
            OptionCaption = 'Flat Amount,% of Amount,Staggered';
            OptionMembers = "Flat Amount","% of Amount",Staggered;
        }
        field(5; "Charge Amount"; Decimal)
        {
            Editable = true;
            trigger OnValidate()
            begin
                if "Charge Amount" < 0 then
                    Error('Charge Amount cannot be negative');
            end;
        }
        field(6; "Percentage of Amount"; Decimal)
        {
            Editable = true;
            trigger onValidate()
            begin
                if "Percentage of Amount" < 0 then
                    Error('Percentage of Amount cannot be negative');
                if rec."Charge Type" = rec."Charge Type"::"% of Amount" then
                    rec.testfield("Percentage of Amount");
            end;
        }
        field(7; "Account No."; Code[20])
        {
            Editable = false;
            TableRelation = if ("Account Type" = const("Account Type"::"G/L Account")) "G/L Account"
            else
            if ("Account Type" = const("Account Type"::Vendor)) Vendor
            else
            if ("Account Type" = const("Account Type"::Customer)) Customer
            else
            if ("Account Type" = const("Account Type"::"Bank Account")) "Bank Account";
        }
        field(8; "Minimum Amount"; Decimal)
        {
        }
        field(9; "Maximum Amount"; Decimal)
        {
        }
        field(10; "Staggered Charge Code"; Code[20])
        {
            TableRelation = "Tiered Charges Header";
        }
        field(11; "Transaction Charge Category"; Option)
        {
            OptionMembers = Normal,"Stamp Duty","Withdrawal Frequency","Withdrawn Amount","Failed STO Charge";
        }
        field(12; "Recover Excise Duty"; Boolean)
        {
        }
        field(13; "Withholding Tax"; Boolean)
        {

        }
        field(14; "Account Type"; enum "Gen. Journal Account Type")
        {
            ValuesAllowed = vendor, "G/L Account", Customer, "Bank Account";
        }
        field(15; "Sky Revenue Share"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if not "Sky Revenue Share" then begin
                    "Sky Revenue Share %" := 0;
                    "Sky Revenue Account No." := '';
                end;
            end;
        }
        field(16; "Sky Revenue Share %"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 1;
            MaxValue = 100;
        }
        field(17; "Sky Revenue Account No."; Code[20])
        {
            TableRelation = Vendor."No.";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                TestField("Sky Revenue Share", true);
                TestField("Sky Revenue Share %");
            end;
        }
        // useFinancialChargesExciseDuty
        field(18; "useFinancialChargesExciseDuty"; Boolean)
        {

        }
        // Excempt From Charges
        field(19; "Excempt From Charges"; Boolean)
        {

        }

    }

    keys
    {
        key(Key1; "Transaction Type", Description)
        {
            Clustered = true;
        }
        // Secondary keys for non-primary fields
        key(IdxTransactionType; "Transaction Type")
        {
            Clustered = false;
        }

        key(IdxAccountNo; "Account No.")
        {
            Clustered = false;
        }

        // Composite key for efficient queries involving multiple fields
        key(IdxTransactionTypeAccountNo; "Transaction Type", "Account No.")
        {
            Clustered = false;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        theHeader: Record "Mobile Transaction Types";
    begin
        "Recover Excise Duty" := true;

        if theHeader.Get("Transaction Type") then begin
            theHeader."Created By" := UserId;
            theHeader."Updated By" := UserId;

            theHeader.Modify;
        end;

        if "Sky Revenue Share" then begin
            TestField("Sky Revenue Share %");
            TestField("Sky Revenue Account No.");
        end;
    end;

    trigger OnModify()
    var
        theHeader: Record "Mobile Transaction Types";
    begin
        if theHeader.Get("Transaction Type") then begin
            theHeader."Created By" := UserId;
            theHeader."Updated By" := UserId;

            theHeader.Modify;
        end;

        if "Sky Revenue Share" then begin
            TestField("Sky Revenue Share %");
            TestField("Sky Revenue Account No.");
        end;
    end;

    var
        TransactionTypes: Record "Mobile Transaction Types";
}


