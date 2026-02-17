table 52185848 "End Year Interest Buffer"
{
    DrillDownPageId = "End Year Interest Buffer";
    LookupPageId = "End Year Interest Buffer";
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            Editable = false;
        }
        field(2; "Account Type"; Enum "Gen. Journal Account Type")
        {

        }
        field(3; "Account No"; Code[20])
        {
            Editable = false;
            TableRelation = "Savings Accounts";
        }
        field(4; "Interest Date"; Date)
        {
        }
        field(5; "Interest Rate"; Decimal)
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(6; "Interest Amount"; Decimal)
        {
        }
        field(7; "User ID"; Code[20])
        {
        }
        field(8; Description; Text[80])
        {
        }
        field(9; "Product Factory Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Product Factory";
        }
        field(10; "Bal. Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Bal. Account Type';
            Editable = false;
        }
        field(11; "Payable Account"; Code[20])
        {
            Caption = 'Payable Account';
            Editable = false;
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Bal. Account Type" = CONST("IC Partner")) "IC Partner";
            //ELSE
            // IF ("Bal. Account Type" = CONST(Member)) Members;
        }
        field(12; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(13; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(14; Blocked; Option)
        {
            Caption = 'Blocked';
            Editable = false;
            OptionCaption = ' ,Credit,Debit,All';
            OptionMembers = " ",Credit,Debit,All;
        }
        field(15; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawal,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Apportioned,Suspended,Awaiting Verdict,New';
            OptionMembers = Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawal,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter,Apportioned,Suspended,"Awaiting Verdict",New;
        }
        field(16; "Account Balance"; Decimal)
        {
            Editable = false;
        }
        field(17; Posted; Boolean)
        {
        }
        field(18; "Expense Account"; Code[20])
        {
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Bal. Account Type" = CONST("IC Partner")) "IC Partner";
            // ELSE
            //  IF ("Bal. Account Type" = CONST(Member)) Members;
        }
        field(19; Name; Text[80])
        {
            Caption = 'Name';
        }
        field(20; Wtax; Decimal)
        {
            Caption = 'Withholding Tax';
        }
        field(21; "Net Interest"; Decimal)
        {
            Caption = 'Net Interest';
        }
    }

    keys
    {
        key(Key1; "Account No", "Interest Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
          IF No = '' THEN BEGIN
          NoSetup.GET(0);
          NoSetup.TESTFIELD(NoSetup."Interest Buffer No");
          NoSeriesMgt.InitSeries(NoSetup."Interest Buffer No",xRec."No. Series",0D,No,"No. Series");
          END;
        */

    end;

    var
        NoSetup: Record "Purchases & Payables Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
}

