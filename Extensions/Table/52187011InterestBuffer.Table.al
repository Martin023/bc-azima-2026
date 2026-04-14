table 52187011 "Loans Interest Buffer"
{
    fields
    {
        field(1; No; Integer)
        {
            Editable = false;
            AutoIncrement = true;
        }
        field(2; "Account No"; Code[20])
        {
            Editable = false;
        }
        field(3; "Account Type"; Enum "Gen. Journal Account Type")
        {
        }
        field(4; "Interest Date"; Date)
        {
        }
        field(5; "Interest Amount"; Decimal)
        {
        }
        field(6; "User ID"; Code[100])
        {
        }
        field(8; "Account Matured"; Boolean)
        {
        }
        field(9; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(10; "Late Interest"; Boolean)
        {
        }
        field(11; Transferred; Boolean)
        {
        }
        field(12; "Mark For Deletion"; Boolean)
        {
        }
        field(13; Description; Text[80])
        {
        }
        field(14; Posted; Boolean)
        {
        }
        field(15; "Loan No."; Code[50])
        {
            Editable = false;
            TableRelation = Loans;
        }
        field(16; "Loan Product type"; Code[10])
        {
            Editable = false;
            TableRelation = "Product Factory";
        }
        field(17; "Bal. Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Bal. Account Type';
            Editable = false;
        }
        field(18; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Editable = false;
        }
        field(19; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Editable = false;
        }
        field(20; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            Editable = false;
        }
        field(21; Blocked; Option)
        {
            Caption = 'Blocked';
            Editable = false;
            OptionCaption = ' ,Ship,Invoice,All';
            OptionMembers = " ",Ship,Invoice,All;
        }
        field(22; Status; Enum "Member Status")
        {
            Editable = false;
        }
        field(23; "Issued Date"; Date)
        {
            Editable = false;
        }
        field(24; "Bill Loan"; Boolean)
        {
        }
        field(25; "Charge Interest"; Boolean)
        {
        }
        field(26; "Repayment Amount"; Decimal)
        {
        }
        field(27; "Monthly Repayment"; Decimal)
        {
        }
        field(28; "Bill Account"; Code[20])
        {
        }
        field(29; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(31; "Repayment Bill"; Decimal)
        {
        }
        field(32; "Interest Bill"; Decimal)
        {
        }
        field(33; "Outstanding Interest"; Decimal)
        {
            Editable = false;
        }
        field(34; "Outstanding Balance"; Decimal)
        {
            Editable = false;
        }
        field(35; "Appraisal Amount"; Decimal)
        {
        }
        field(36; "Date Captured"; Date)
        {
        }
        field(37; "Bal. Account No.(Suspended)"; Code[100])
        {
        }
        field(38; "Account Blocked"; Option)
        {
            OptionCaption = ' ,Credit,Debit,All';
            OptionMembers = " ",Credit,Debit,All;
        }
        field(39; "Outstanding Bill"; Decimal)
        {
        }
        field(40; "Employer Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Member No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Source Unit"; Enum "Source Unit")
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Loans."Source Unit" where("Loan No." = field("Loan No.")));
            Editable = false;
        }
    }

    keys
    {
        key(Key1; No, "Loan No.", "Account No", "Interest Date")
        {
            Clustered = true;
        }
        key(key2; "Loan No.", Posted, "Interest Date")
        {
            SumIndexFields = "Interest Amount";
        }
    }

    fieldgroups
    {
    }
}

