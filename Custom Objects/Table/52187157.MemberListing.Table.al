table 52187157 "Member Listing"
{
    DataClassification = ToBeClassified;
    Caption = 'Membr Listing';

    fields
    {
        field(1; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Gender; Enum Gender)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "P.I.N Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Payroll/Staff No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Readmission Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(8; Status; enum "Member Status")
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Primary Identification Type"; Enum "Identification Type")
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Primary Identification"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Subflag; Enum "Member Status Sub Flags")
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Employer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Employer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Current Address"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "E-Mail"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Recruited By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Recruited By Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Recruited by Type"; Enum "Recruited By")
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Member Class"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(25; Salutation; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Marital Status"; Enum "Marital Status")
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Date Approved"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Member Age"; Integer)
        {
            DataClassification = ToBeClassified;
        }


        field(30; "Delegates Zone"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Risk Accont No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Risk Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Risk Monthly Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Registration Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(35; "FOSA Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "FOSA Account Status"; Enum "Savings Account Status")
        {
            DataClassification = ToBeClassified;
            // OptionCaption = ' ,New,Active,Dormant,Frozen,Withdrawal Application,Withdrawn,Deceased,Defaulter,Closed';
            // OptionMembers = " ",New,Active,Dormant,Frozen,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;
        }
        field(37; "FOSA Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Business Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "BOSA Deposit Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "BOSA Deposit Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "BOSA Deposit Account Status"; Enum "Savings Account Status")
        {
            DataClassification = ToBeClassified;
            // OptionCaption = ' ,New,Active,Dormant,Frozen,Withdrawal Application,Withdrawn,Deceased,Defaulter,Closed';
            // OptionMembers = " ",New,Active,Dormant,Frozen,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;
        }
        field(42; "BOSA Deposits Monthly Contr."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "BBF Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "BBF Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "BBF Monthly Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "BBF Account Status"; Enum "Savings Account Status")
        {
            DataClassification = ToBeClassified;
            // OptionCaption = ' ,New,Active,Dormant,Frozen,Withdrawal Application,Withdrawn,Deceased,Defaulter,Closed';
            // OptionMembers = " ",New,Active,Dormant,Frozen,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;
        }
        field(47; "Transfer Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Share Capital Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Share Capital Ac Status"; Enum "Savings Account Status")//Option)
        {
            DataClassification = ToBeClassified;
            // OptionCaption = ' ,New,Active,Dormant,Frozen,Withdrawal Application,Withdrawn,Deceased,Defaulter,Closed';
            // OptionMembers = " ",New,Active,Dormant,Frozen,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;
        }
        field(50; "Share Capital Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Trasferred Share Cap No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Trasferred Share Cap Bal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Trasferred Share Cap Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Active,Inactive;
        }
        field(54; Prorata; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55; County; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Transactional Mobile Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(57; LoanBal; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Contribution Effective Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(60; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(61; "Member No"; Code[50])
        {
            TableRelation = Members."No.";
        }
        field(62; "Work Station"; Code[20])
        {
            TableRelation = "Electrol Zones/Area Svr Center".Code WHERE(Type = CONST("Work Station"));
        }

        field(100; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(101; "Batch No."; Code[100])
        {

        }
        field(102; "Generate By"; Code[100])
        {

        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        "Generate By" := UserId;
    end;
}
