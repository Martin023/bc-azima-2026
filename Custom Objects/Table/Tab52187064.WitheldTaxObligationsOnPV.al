table 52187064 "Witheld Tax Obligations On PV"
{
    Caption = 'Witheld Tax Obligations On PV';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Witheld Tax Obligations On PV";

    fields
    {
        field(1; "Payment No."; Code[20])
        {
            Caption = 'Payment No.';
        }
        field(2; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';

            trigger OnValidate()
            begin
                if Vendor.Get(rec."Vendor No.") then begin
                    rec."Vendor Name" := Vendor.Name;
                    rec."Vendor KRA PIN" := Vendor."KRA Pin No.";
                    // rec.
                end;
            end;
        }
        field(3; "VAT witholding Tax code"; Code[20])
        {
            Caption = 'VAT witholding  Tax code';
        }
        field(4; "VAT withheld Amount"; Decimal)
        {
            Caption = 'Withholding VAT Amount';
            // FieldClass = FlowField;

            // if Accoun
        }
        field(5; "Withholding Tax Code"; Code[20])
        {
            Caption = 'Withholding Tax Code';
        }
        field(6; "Withholding Tax Amount"; Decimal)
        {
            Caption = 'Withholding Tax Amount';
        }
        field(7; "Vendor KRA PIN"; code[20])
        {
            Caption = 'Vendor KRA PIN';
        }
        field(8; "Vendor Name"; text[150])
        {
            Caption = 'Vendor Name';
        }
        field(9; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
        }
        field(10; "VAT Amount"; Decimal)
        {
            Caption = 'VAT Amount';
        }
        field(11; "Invoice No."; Code[100])
        {
            Caption = 'Invoce No.';
        }
        field(12; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(13; "Invoice Date"; Date)
        {
            Caption = 'Invoice Date';
        }
        field(14; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(15; "No."; Integer)
        {
            Caption = 'No.';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var
        TarriffCode: record "Tariff Code s";
        AccountNo: code[50];
        SavingsAccount: record "Savings Accounts";
        Vendor: record Vendor;
        Customer: record Customer;
        Credit: record "Credit Accounts";

    // local procedure CheckAccountNo(): code[50];
    // begin
    //     TarriffCode.Reset();
    //     TarriffCode.Get(rec."VAT witholding Tax code");
    //     exit(TarriffCode."Account No.");
    // end;

    // local procedure GetAcctType(AccountNo: Code[50]): Enum "Gen. Journal Account Type";
    // begin
    //     if SavingsAccount.Get(AccountNo) then
    //         exit("G/L Account Type"::Saving)
    //     else if Credit.Get(AccountNo) then
    //         exit(Credit)
    //     else
    //         exit('Other Account');
    // end;


}
