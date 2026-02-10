table 52186002 Charges
{
    DrillDownPageID = "Charges List";
    LookupPageID = "Charges List";

    fields
    {
        field(1; "Code"; Code[20])
        {

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                // TestNoEntriesExist(FieldCaption(Code));
            end;
        }
        field(2; Name; Text[100])
        {

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist

            end;
        }
        field(3; "Account No."; Code[20])
        {
            NotBlank = false;
            TableRelation = "G/L Account"."No." where("Income/Balance" = filter("Income Statement"), "Account Type" = filter(Posting));

            trigger OnValidate()
            begin

                GLAccount.GET("Account No.");
                GLAccount.TESTFIELD(GLAccount."Income/Balance", GLAccount."Income/Balance"::"Income Statement");
                GLAccount.TESTFIELD(GLAccount."Account Type", GLAccount."Account Type"::Posting);
                //Prevent Changing once entries exist
                //  TestNoEntriesExist(FIELDCAPTION("Account No."));


            end;
        }
        field(4; Vatable; Boolean)
        {
        }
        field(5; "VAT Code"; Code[30])
        {
            TableRelation = "Tariff Code s";

            trigger OnValidate()
            begin
                Tariffs.Reset;
                Tariffs.Get("VAT Code");
                "VAT Percentage(%)" := Tariffs.Percentage;
                "VAT Account" := Tariffs."Account No.";
            end;
        }
        field(6; "VAT Percentage(%)"; Decimal)
        {
        }
        field(7; "Uses Rates"; Boolean)
        {

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                //  TestNoEntriesExist(FieldCaption("Uses Rates"));
            end;
        }
        field(8; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Income,Expense';
            OptionMembers = " ",Income,Expense;
        }
        field(9; "VAT Account"; Code[30])
        {
            TableRelation = "G/L Account"."No.";

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                // TestNoEntriesExist(FieldCaption("VAT Account"));
            end;
        }
        field(10; "Direct Post"; Boolean)
        {

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                // TestNoEntriesExist(FieldCaption("Direct Post"));
            end;
        }
        field(11; "Charge Once"; Boolean)
        {

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                // TestNoEntriesExist(FIELDCAPTION("Charge Once"));
            end;
        }
        field(12; "IsService Charge"; Boolean)
        {
        }
        field(13; "Legal Fees"; Boolean)
        {
        }
        field(14; No; Code[30])
        {

        }
        field(15; "Is Rent"; Boolean)
        {
        }


    }

    keys
    {
        key(Key1; No, code)
        {
            Clustered = true;
        }
        key(Key2; "VAT Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        GLAccount: Record "G/L Account";
        Tariffs: Record "Tariff Code s";
        Text000: Label 'You cannot change %1 because there are one or more ledger entries associated with this account.';

    [Scope('OnPrem')]
    procedure TestNoEntriesExist(CurrentFieldName: Text[100])
    var
        GLLedgEntry: Record "G/L Entry";
    begin
        //To prevent change of field
        GLLedgEntry.SetCurrentKey(GLLedgEntry."G/L Account No.");
        GLLedgEntry.SetRange("G/L Account No.", "Account No.");
        if GLLedgEntry.Find('-') then
            Error(
              Text000,
              CurrentFieldName);
    end;
}

