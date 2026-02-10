table 52187151 "Loan Listing Report List"
{
    Caption = 'Loan Listing Report List';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            AutoIncrement = true;
        }
        field(2; "Batch No"; Code[100])
        {
            Caption = 'Batch No';
        }
        field(3; "Loan No"; Code[50])
        {
            Caption = 'Loan No';
            //1
        }
        field(26; "Loan Product Type Name"; Text[100])
        {
            Caption = 'Loan Product Type Name';
            //2
        }
        field(25; "Loan Product Type"; Code[50])
        {
            Caption = 'Loan Product Type';
            //3
        }
        field(62; "Loan Interest Rate"; Decimal)
        {
            //4
        }
        field(27; "Member No"; Code[50])
        {
            Caption = 'Member No';
            //5
        }

        field(37; "Staff No"; Code[100])
        {
            Caption = 'Staff No';
            //6

        }
        field(64; "ID Number"; Code[50])
        {
            //7
        }
        field(28; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
            //8
        }
        field(4; "Paid Prorata"; Decimal)
        {
            Caption = 'Paid Prorata';
            //9
        }
        field(22; "Application Date"; Date)
        {
            Caption = 'Application Date';
            //10
        }
        field(10; "Disbursement Date"; date)
        {
            Caption = 'Disbursement Date';
            //11
        }
        field(32; "Outstanding Balance"; Decimal)
        {
            Caption = 'Outstanding Balance';
            //12
        }
        field(33; "Outstanding Interest"; Decimal)
        {
            Caption = 'Outstanding Interest';
            //13
        }
        field(65; "Total Loan Balance"; Decimal)
        {
            //14
        }
        field(66; "Principle Plus Future Interest"; Decimal)
        {
            //15
        }
        field(67; "Loan Amortization Type"; Option)
        {
            OptionCaption = 'Amortised,Reducing Balance,Straight Line,Reducing Flat';
            OptionMembers = Amortised,"Reducing Balance","Straight Line","Reducing Flat";
            //16
        }
        field(68; "Loan Frequency"; Code[20])
        {
            //17
        }
        field(5; "Loan Status"; Text[100])
        {
            Caption = 'Loan Status';
            //18
        }
        field(34; "Principle Arrears"; Decimal)
        {
            Caption = 'Principle Arrears';
            //19
        }
        field(69; "Interest Arrears"; Decimal)
        {
            //20
        }
        field(6; "Amount In Arrears"; Decimal)
        {
            Caption = 'Amount In Arrears';
            //21
        }
        field(70; "Months In Arrears"; Decimal)
        {
            //22
        }
        field(52; "Days In Arrears"; Integer)
        {
            Caption = 'Days In Arrears';
            //23
        }
        field(24; "SASRA Caategorization"; enum "Loan Sasra categories")
        {
            Caption = 'SASRA Caategorization';
            //24
        }
        field(7; "Outstanding Installments"; Decimal)
        {
            Caption = 'Outstanding Installments';
            //25
        }
        field(71; "Total Expected Interest"; Decimal)
        {
            //26
        }
        field(72; "Total Expected Principle"; Decimal)
        {
            //27
        }
        field(8; "Interest Topped"; Decimal)
        {
            Caption = 'Interest Topped';
            //28
        }
        field(9; "Principle Toppped"; Decimal)
        {
            Caption = 'Principle Toppped';
            //29
        }
        field(17; "Loan Principle Repayment"; Decimal)
        {
            Caption = 'Loan Principle Repayment';
            //30
        }
        field(18; "Loan Interest Repayment"; Decimal)
        {
            Caption = 'Loan Interest Repayment';
            //32
        }
        field(11; Repayment; Decimal)
        {
            Caption = 'Repayment';
            //33
        }
        field(12; "Relation Officer"; Code[100])
        {
            Caption = 'Relation Officer';
            //34
        }
        field(13; "CRM Application No"; Code[100])
        {
            Caption = 'CRM Application No';
            //35
        }
        field(15; "Repayment Start Date"; Date)
        {
            Caption = 'Repayment Start Date';
            //36
        }
        field(14; "Expected Date Of Completion"; Date)
        {
            Caption = 'Expected Date Of Completion';
            //37
        }
        field(16; "FOSA Balance"; Decimal)
        {
            Caption = 'FOSA Balance';
            //38
        }
        field(19; "Last Interest Repayment"; Decimal)
        {
            Caption = 'Last Interest Repayment';
            //39
        }
        field(20; "Last Principle Repayment"; Decimal)
        {
            Caption = 'Last Principle Repayment';
            //40
        }
        field(21; "Approval Date"; Date)
        {
            Caption = 'Approval Date';
            //41
        }
        field(23; "Last Payment Date"; Date)
        {
            Caption = 'Last Payment Date';
            //42
        }
        field(29; Intallments; Integer)
        {
            Caption = 'Intallments';
            //43
        }
        field(30; "Requested Amount"; Decimal)
        {
            Caption = 'Requested Amount';
            //44
        }
        field(31; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            //45
        }
        field(35; "Share Boosted Amount"; Decimal)
        {
            Caption = 'Share Boosted Amount';
            //46
        }
        field(36; "Employer Code"; Code[100])
        {
            Caption = 'Employer Code';
            //47
        }
        field(38; "Employer Name"; Text[100])
        {
            Caption = 'Employer Name';
            //48
        }
        field(39; "Loan Appraised By"; Code[100])
        {
            Caption = 'Loan Appraised By';
            //49
        }
        field(40; "Posted By"; Code[100])
        {
            Caption = 'Posted By';
            //50
        }
        field(41; "Member Age"; Integer)
        {
            Caption = 'Member Age';
            //51
        }
        field(42; "Prorata Amount"; Decimal)
        {
            Caption = 'Prorata Amount';
            //52
        }
        field(43; "Main Sector Code"; Code[100])
        {
            Caption = 'Main Sector Code';
            //53
        }
        field(44; "Main Sector Name"; Text[100])
        {
            Caption = 'Main Sector Name';
            //54
        }
        field(45; "Sub Sector1 Code"; Code[100])
        {
            Caption = 'Sub Sector1 Code';
            //55
        }
        field(46; "Sub Sector1 Name"; Text[100])
        {
            Caption = 'Sub Sector1 Name';
            //56
        }
        field(47; "Sub Sector2 Code"; Code[100])
        {
            Caption = 'Sub Sector2 Code';
            //57
        }
        field(48; "Sub Sector2 Name"; Text[100])
        {
            Caption = 'Sub Sector2 Name';
            //58
        }
        field(49; "Member Deposits"; Decimal)
        {
            Caption = 'Member Deposits';
            //59
        }
        field(50; "Business Loan Deposits"; Decimal)
        {
            Caption = 'Business Loan Deposits';
            //60
        }
        field(51; "Source Unit"; Option)
        {
            OptionCaption = ' ,FOSA,BOSA,BUSINESS LOANS,HR LOANS';
            OptionMembers = "",FOSA,BOSA,"BUSINESS LOANS","HR LOANS";
            Caption = 'Source Unit';
            //61
        }
        field(53; "Amount On"; Decimal)
        {
            Caption = 'Amount On';
            //62
        }
        field(54; "Amount Off"; Decimal)
        {
            Caption = 'Amount Off';
            //63
        }
        field(73; "Member Status"; Enum "Member Status")
        {
            //64
        }
        field(74; "Member Sub-Status"; Enum "Member Status Sub Flags")
        {
            //65
        }
        field(55; "Activity Code"; Code[50])
        {
            Caption = 'Activity Code';
            //66
        }
        field(56; "Branch Code"; Code[50])
        {
            Caption = 'Branch Code';
            //67
        }
        field(57; "Type Of Security"; Text[100])
        {
            Caption = 'Type Of Security';
            //68
        }
        field(58; "Future Interest"; Decimal)
        {
            Caption = 'Future Interest';
            //69
        }
        field(59; "Position Of Lonee"; Text[100])
        {
            Caption = 'Position Of Lonee';
            //70
        }











        field(60; "Entry Date"; Date)
        {
            Caption = 'Entry Date';
        }
        field(61; "Entry Time"; Time)
        {
            Caption = 'Entry Time';
        }
        field(200; "Generate By"; Code[100])
        {

        }
    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        "Generate By" := UserId;
    end;
}
