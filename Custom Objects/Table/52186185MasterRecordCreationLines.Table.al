table 52186185 "Master Record Creation Lines"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; Type; Option)
        {
            Caption = 'Master Type';
            OptionCaption = ' ,G/L Account,Dimension,Bank,Customer,Vendor,Item,Fixed Asset,Dimension Value,Job';
            OptionMembers = " ","G/L Account",Dimension,Bank,Customer,Vendor,Item,"Fixed Asset","Dimension Value",Job;
        }
        field(4; "Suggested No."; Code[20])
        {
            Description = 'For Type G/L';
        }
        field(5; Reason; Text[100])
        {
        }
        field(6; Name; Text[100])
        {
        }
        field(7; "Created Document No."; Code[20])
        {
        }
        field(8; "Created Document Name"; Text[100])
        {
        }
        field(9; "Income/Balance Sheet A/C"; Option)
        {
            Description = 'For Type G/L';
            OptionCaption = 'Income Statement,Balance Sheet';
            OptionMembers = "Income Statement","Balance Sheet";
        }
        field(10; "Debit/Credit"; Option)
        {
            Description = 'For Type G/L';
            OptionCaption = 'Both,Debit,Credit';
            OptionMembers = Both,Debit,Credit;
        }
        field(11; "Account Type"; Option)
        {
            Description = 'For Type G/L';
            OptionCaption = 'Posting,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Posting,Heading,Total,"Begin-Total","End-Total";
        }
        field(12; Blocked; Boolean)
        {
        }
        field(13; "General Posting Type"; Option)
        {
            OptionCaption = ' ,Purchase,Sale';
            OptionMembers = " ",Purchase,Sale;
        }
        field(14; "Gen. Bus. Posting Group"; Code[20])
        {
            TableRelation = "Gen. Business Posting Group";
        }
        field(15; "Gen. Prod. Posting Group"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(16; "VAT. Bus. Posting Group"; Code[20])
        {
            TableRelation = "VAT Business Posting Group";
        }
        field(17; "VAT. Prod. Posting Group"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(18; Address; Text[50])
        {
        }
        field(19; "Post Code"; Text[30])
        {
        }
        field(20; City; Text[50])
        {
        }
        field(21; "Country/Region Code"; Code[20])
        {
        }
        field(22; "Phone No."; Code[20])
        {
        }
        field(23; "Bank Branch No."; Code[20])
        {
            Description = 'Bank';
        }
        field(24; "Bank Type"; Option)
        {
            Description = 'Bank';
            OptionCaption = 'Normal,Cash,Fixed Deposit,SMPA,Chq Collection';
            OptionMembers = Normal,Cash,"Fixed Deposit",SMPA,"Chq Collection";
        }
        field(25; "Fax No."; Code[20])
        {
        }
        field(26; Email; Text[50])
        {
        }
        field(27; "Home Page"; Text[100])
        {
        }
        field(28; "Currency Code"; Code[20])
        {
            TableRelation = Currency;
        }
        field(29; "Bank Account Posting Groups"; Code[20])
        {
            TableRelation = "Bank Account Posting Group";
        }
        field(30; "Vendor/Customer Posting Group"; Code[20])
        {
            TableRelation = IF (Type = FILTER(Customer)) "Customer Posting Group"
            ELSE
            IF (Type = FILTER(Vendor)) "Vendor Posting Group";
        }
        field(31; "Base Unit of Measure"; Code[20])
        {
            TableRelation = "Unit of Measure";
        }
        field(32; "Item G/L Budget Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(33; "Inventory Posting Group"; Code[20])
        {
            TableRelation = "Inventory Posting Group";
        }
        field(34; "Depreciation Book"; Code[20])
        {
            TableRelation = "Depreciation Book";
        }
        field(35; "FA Posting Group"; Code[20])
        {
            TableRelation = "FA Posting Group";
        }
        field(36; "Depreciation Method"; Option)
        {
            OptionCaption = 'Straight-Line,Declining-Balance 1,Declining-Balance 2,DB1/SL,DB2/SL,User-Defined,Manual';
            OptionMembers = "Straight-Line","Declining-Balance 1","Declining-Balance 2","DB1/SL","DB2/SL","User-Defined",Manual;
        }
        field(37; "FA Class Code"; Code[20])
        {
            TableRelation = "FA Class";
        }
        field(38; "FA Subclass Code"; Code[20])
        {
            TableRelation = "FA Subclass";
        }
        field(39; "FA Location Code"; Code[20])
        {
            TableRelation = "FA Location";
        }
        field(40; "Dimension Code"; Code[20])
        {
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                if Dimension.Get("Dimension Code") then "Dimension Name" := Dimension.Name;
            end;
        }
        field(41; "Dimension Value Code"; Code[20])
        {
        }
        field(42; "Dimension Value Name"; Text[100])
        {
        }
        field(43; "Dimension Name"; Code[20])
        {
        }
        field(44; "Dimension Code Insert"; Code[20])
        {
        }
        field(45; "Dimension Name Insert"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Document No.")
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
        Master.RESET;
        Master.SETRANGE(Master."Document No.",)
        Master.FIND(+)
         */

    end;

    var
        Master: Record "Master Record Creation Lines";
        Dimension: Record Dimension;
}

