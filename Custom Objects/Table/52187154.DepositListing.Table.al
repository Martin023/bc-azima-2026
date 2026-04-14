table 52187154 "Deposit Listing"
{
    Caption = 'Deposit Listing';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Batch No"; Code[20])
        {
            Caption = 'Batch No';
            DataClassification = ToBeClassified;
        }
        field(3; "SNo"; Integer)
        {
            Caption = 'SNo';
            DataClassification = ToBeClassified;
        }
        field(4; "Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Product Category"; enum "Product Categories")
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Balance (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Last Transacted Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Last Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Monthly Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Source Unit"; Enum "Source Unit")
        {
            DataClassification = ToBeClassified;
            // OptionCaption = ' ,FOSA,BOSA,BUSINESS LOANS,HR LOANS';
            // OptionMembers = "",FOSA,BOSA,"BUSINESS LOANS","HR LOANS";
        }
        field(13; Status; Enum "Savings Account Status")
        {
            // OptionCaption = ' ,New,Active,Dormant,Frozen,Withdrawal Application,Withdrawn,Deceased,Defaulter,Closed';
            // OptionMembers = " ",New,Active,Dormant,Frozen,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;
            DataClassification = ToBeClassified;
        }
        field(14; "Member Status"; Enum "Member Status")
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Member Sub Status"; Enum "Member Status Sub Flags")
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Employer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Employer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Date Of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Payroll/Staff No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(25; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Balance AsAt StartDate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Balance AsAt EndDate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; Variance; Decimal)
        {
            DataClassification = ToBeClassified;
        }



        field(30; "Product Code"; Code[100])
        {

        }
        field(31; "Product Name"; Text[100])
        {

        }
        field(32; "Balance As At"; Decimal)
        {

        }
        field(33; "Current Balance"; Decimal)
        {
            
        }
        field(34; "As At Date"; Date)
        {

        }

        field(35; "ID Number"; Code[20])
        {

        }

        field(50; "Generate By"; Code[100])
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
