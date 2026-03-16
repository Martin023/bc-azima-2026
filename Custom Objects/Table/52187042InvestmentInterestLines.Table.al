table 52187042 "Investment Interest Lines"
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
        field(6; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(7; Description; Text[80])
        {
        }
        field(8; Posted; Boolean)
        {
        }
        field(9; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(10; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(11; "Accrued Interest G/L Acc"; Code[20])
        {
            Editable = false;
            TableRelation = "Investment Type"."Accrued Interest G/L Acc";
        }
        field(12; Blocked; Option)
        {
            Caption = 'Blocked';
            Editable = false;
            OptionCaption = ' ,Ship,Invoice,All';
            OptionMembers = " ",Ship,Invoice,All;
        }
        field(13; "Investment Header No"; Code[20])
        {
            TableRelation = "Investment Interest Header"."No.";
        }
        field(14; "Invested Amount"; Decimal)
        {
            TableRelation = "Investment Lines"."Face Value";
            Editable = false;
        }
        field(15; "Accrued Interest Amount"; Decimal)
        {
            Editable = false;
        }
        field(16; "Account Name"; Text[50])
        {
            Editable = false;
        }
        field(17; "Interest Income G/L Acc"; Code[20])
        {
            Editable = false;
            TableRelation = "Investment Type"."Interest Income G/L Acc";
        }
        field(18; "Applied Interest"; Decimal)
        {
            TableRelation = "Investment Header"."Interest Rate";
            Editable = false;
        }
        field(19; "Investment Type"; Option)
        {
            TableRelation = "Investment Header"."Deposit Type";
            OptionCaption = ' ,Fixed,Call,Treasury Bills,Shares,Bonds';
            OptionMembers = " ","Fixed",Call,"Treasury Bills",Shares,Bonds;
            Editable = false;
        }
        field(20; "Investment No"; Code[20])
        {
            TableRelation = "Investment Header"."Investment No";
        }
        field(21; "Date Placed"; Date)
        {
            TableRelation = "Investment Header"."Investment Date";
        }
        field(22; "Maturity Date"; Date)
        {
            TableRelation = "Investment Header"."Maturity Date";
        }

    }

    keys
    {
        key(Key1; No, "Investment Header No")
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

