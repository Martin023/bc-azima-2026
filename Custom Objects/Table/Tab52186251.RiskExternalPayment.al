table 52186251 "Risk External Payment"
{
    Caption = 'Risk External Payment';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Risk Claim No."; Code[20])
        {
            Caption = 'Risk Claim No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            ValuesAllowed = "Bank Account";
        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            WHERE("Account Type" = CONST(Posting), Blocked = CONST(false))
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const("Bank Account")) "Bank Account" where("Bank Type" = const(Normal), Blocked = const(false));
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; Description; Text[50])
        {
        }
        field(7; "Pay Mode"; Option)
        {
            OptionMembers = " ",Cash,Cheque,EFT,"Deposit Slip","Banker's Cheque",RTGS,Custom3;
        }
        field(8; "Cheque No."; Code[20])
        {
        }
    }
    keys
    {
        key(PK; "Risk Claim No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
