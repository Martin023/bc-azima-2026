table 52186272 "Loan Ageing Table"
{
    Caption = 'Loan Ageing Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Loan Product Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Loan Product Type Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Employer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Employer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Member Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Member Status"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Sub Flag"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Requested Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Disbursed Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Disbursement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Loan Amortization Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Repayment Frequency"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Installments"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Loan Principle Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Loan Interest Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Monthly Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "First Installment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Next Expected Date of Payment"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Last Payment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Last Amount Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Outstanding Installments"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Loan Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Total Expected Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Total Interest Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Total Expected Principle"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Total Principle Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Total Principle Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Total Interest Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Total Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Days In Arrears"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Months In Arrears"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Loans Category-SASRA"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Outstanding Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Outstanding Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Daily Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Total Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "P Plus I Future Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Loan Amount Bridged"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Net Take Home"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "FOSA Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "BOSA Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Business Loans Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Security Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Collateral Ref Number"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Amount In Lien"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Collateral Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Net Exposure"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Rescheduled"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Loan Purpose"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Branch Domicile"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Position"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Loan Dep"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Suspended Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}