table 52186213 "Journal Two"
{

    fields
    {
        field(1; "No."; Integer)
        {
        }
        field(2; "Account No"; Code[30])
        {
            TableRelation = IF ("Accout Type" = FILTER("G/L Account")) "G/L Account"
            ELSE
            IF ("Accout Type" = FILTER("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Accout Type" = FILTER(Savings)) "Savings Accounts"
            ELSE
            IF ("Accout Type" = FILTER(Credit)) "Credit Accounts"
            ELSE
            IF ("Accout Type" = FILTER("Bank Account")) "Bank Account"
            ELSE
            IF ("Accout Type" = FILTER(Customer)) Customer
            ELSE
            IF ("Accout Type" = FILTER(Vendor)) Vendor;

            trigger OnValidate()
            begin
                if SavingsAccounts.Get("Account No") then begin
                    if Members.Get(SavingsAccounts."Member No.") then
                        Dim1 := SavingsAccounts."Global Dimension 1 Code";// ."Global Dimension 1 Code";
                    Dim2 := SavingsAccounts."Global Dimension 2 Code";
                end;

                if CreditAccounts.Get("Account No") then begin
                    if Members.Get(CreditAccounts."Member No.") then
                        Dim1 := Members."Global Dimension 1 Code";// ."Global Dimension 1 Code";
                    Dim2 := CreditAccounts."Global Dimension 2 Code";

                end;
            end;
        }
        field(3; Description; Code[50])
        {
        }
        field(4; "Accout Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Savings,Credit,Member';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit,Member;
        }
        field(8; "Posting Date"; Date)
        {
        }
        field(9; Amount; Decimal)
        {
        }
        field(10; Dim1; Code[20])
        {
        }
        field(12; "Document No"; Code[30])
        {
        }
        field(13; "External Doc"; Code[30])
        {
        }
        field(14; Posted; Boolean)
        {
        }
        field(15; "Depreciation Book"; Code[50])
        {
        }
        field(16; "Batch Name"; Code[50])
        {
        }
        field(17; Userid; Code[20])
        {
        }
        field(18; "System created"; Boolean)
        {
        }
        field(19; "G/L ACC No."; Code[20])
        {
        }
        field(69021; "Bal Accout Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,None,Staff';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,"None",Staff;
        }
        field(69022; "bal Account No"; Code[30])
        {
        }
        field(69023; "TransaCTION tYPE"; Option)
        {
            OptionCaption = ' ,Loan,Repayment,Interest Due,Interest Paid,Bills,Appraisal';
            OptionMembers = " ",Loan,Repayment,"Interest Due","Interest Paid",Bills,Appraisal;
        }
        field(69024; "Loan No"; Code[21])
        {
        }
        field(69025; Duplicate; Integer)
        {
        }
        field(69026; Dim2; Code[20])
        {
        }
        field(69027; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Credit,Debit,All';
            OptionMembers = " ",Credit,Debit,All;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        SavingsAccounts: Record "Savings Accounts";
        Members: Record Members;
        CreditAccounts: Record "Credit Accounts";
}

