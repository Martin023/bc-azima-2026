table 52185836 "Bond Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(5; "Bond Post Gen. Journal Templat"; Code[10])
        {
            TableRelation = "Gen. Journal Template".Name;
        }
        field(6; "Bond Post Gen. Journal Batch"; Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Bond Post Gen. Journal Templat"));
        }
        field(7; "Excise Duty Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(11; "Bid-Bond Account Type"; Code[10])
        {
            Description = '//not used';
            Enabled = false;
            TableRelation = "Product Factory"."Product ID";
        }
        field(12; "Bid-Bond Charge %(per quarter)"; Decimal)
        {
        }
        field(13; "Bid-Bond Charges Income Acc."; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(14; "Bid-Bond Chg Bank Share Vendor"; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(15; "Bid Bond Charge-Stima Share%"; Decimal)
        {
        }
        field(16; "Bid Bond Charge-Bank Share%"; Decimal)
        {
        }
        field(17; "Bid Bond Minimum Charge"; Decimal)
        {
        }
        field(21; "Performance Bond Acc. Type"; Code[10])
        {
            TableRelation = "Product Factory"."Product ID";
        }
        field(22; "Performance Bond Cover %"; Decimal)
        {
        }
        field(23; "Perf.Bond Charge%(per quarter)"; Decimal)
        {
        }
        field(24; "Performance Charge Income Acc."; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(25; "Perf.Bond Chg Bank Share Vendo"; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(26; "Perf. Bond Charge-Stima Share%"; Decimal)
        {
        }
        field(27; "Perf. Bond Charge-Bank Share%"; Decimal)
        {
        }
        field(28; "Performance Bond Min. Charg"; Decimal)
        {
        }
        field(31; "Bond Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

