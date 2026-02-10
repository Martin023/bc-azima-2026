table 52186570 "CRB Monthly ICE File Subm."
{
    Caption = 'CRB Monthly Individual Consumer, Employer and Account File Submissions';
    DataClassification = ToBeClassified;

    LookupPageId = "CRB Monthly ICE File Subm.";
    DrillDownPageId = "CRB Monthly ICE File Subm.";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Loan No."; Code[50])
        {
            Caption = 'Loan No.';
            TableRelation = Loans."Loan No.";
            Editable = false;

            // trigger OnValidate()
            // var
            //     TheLoan: Record Loans;
            // begin
            //     TheLoan.Get("Loan No.");

            //     "Account Number" := TheLoan."Loan No.";
            //     "Original Amount" := TheLoan."Approved Amount";
            //     "Currency of Facility" := TheLoan."Currency Code";
            // end;
        }
        field(3; "Log Date Time"; DateTime)
        {
            Caption = 'Log Date Time';
            Editable = false;
        }
        field(4; "CRB Institution"; Code[50])
        {
            Caption = 'CRB Institution';
            Editable = false;
        }
        field(5; Surname; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Forename 1"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'First Name (Forename 1)';
            Editable = false;
        }
        field(7; "Forename 2"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Given Name (Forename 2)';
            Editable = false;
        }
        field(8; "Forename 3"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Other Names (Forename 3)';
            Editable = false;
        }
        field(9; "Trading As"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Name of a business if the individual runs a business as a sole proprietor that is not registered';
            Editable = false;
        }
        field(10; "Date of Birth"; Text[10])
        {
            Caption = 'Date of Birth';
            Editable = false;
        }
        field(11; "Client Number"; Text[20])
        {
            Caption = 'Client Number';
            Editable = false;
        }
        field(12; "Account Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Loan Number';
            Editable = false;
        }
        field(13; "Old Account Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Old Loan Number';
            Editable = false;
        }
        field(14; "Gender"; Code[5])
        {
            Caption = 'Gender';
            Editable = false;
            // TODO
            // M – Male
            // F – Female
        }
        field(15; "Nationality"; Code[5])
        {
            Caption = 'Nationality';
            Editable = false;
            // TODO
            // KE - Kenya
        }
        field(16; "Marital Status"; Code[5])
        {
            Caption = 'Marital Status';
            Editable = false;
            // TODO
            // M – Married
            // S - Single
            // D - Divorced
            // W - Widowed
        }
        field(17; "Primary Id Doc Type"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Identification Document Type';
            Editable = false;

            // TODO
            // 001 – National ID
            // 002 – Passport
            // 003 – Alien Registration
            // 004 – Service ID
        }
        field(18; "Primary Id Doc No."; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Identification Document Number';
            Editable = false;
        }
        field(19; "Secondary Id Doc Type"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Secondary Identification Document Type';
            Editable = false;

            // TODO
            // 001 – National ID
            // 002 – Passport
            // 003 – Alien Registration
            // 004 – Service ID
        }
        field(20; "Secondary Id Doc No."; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Secondary Identification Document Number';
            Editable = false;
        }
        field(21; "Other Id Doc Type"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Other Identification Document Type';
            Editable = false;

            // TODO
            // 001 – National ID
            // 002 – Passport
            // 003 – Alien Registration
            // 004 – Service ID
        }
        field(22; "Other Id Doc No."; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Other Identification Document Number';
            Editable = false;
        }
        field(23; "Passport Country Code"; Code[5])
        {
            Caption = 'Passport Country Code';
            Editable = false;
            // TODO
            // KE - Kenya
        }
        field(24; "Mobile Telephone No."; Text[15])
        {
            DataClassification = ToBeClassified;
            Caption = 'Mobile Telephone Number';
            Editable = false;
        }
        field(25; "Home Telephone No."; Text[15])
        {
            DataClassification = ToBeClassified;
            Caption = 'Home Telephone Number';
            Editable = false;
        }
        field(26; "Work Telephone No."; Text[15])
        {
            DataClassification = ToBeClassified;
            Caption = 'Work Telephone Number';
            Editable = false;
        }
        field(27; "Postal Address 1"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Postal Address 1';
            Editable = false;
        }
        field(28; "Postal Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Postal Address 2';
            Editable = false;
        }
        field(29; "Postal Location Town"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Postal Location Town';
            Editable = false;
        }
        field(30; "Postal Location Country"; Code[5])
        {
            Caption = 'Postal Location Country';
            Editable = false;
            // TODO
            // KE - Kenya
        }
        field(31; "Post Code"; Text[10])
        {
            Caption = 'Post Code';
            Editable = false;
            // TODO
            // KE - Kenya
        }
        field(32; "Physical Address 1"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Physical Address 1';
            Editable = false;
        }
        field(33; "Physical Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Physical Address 2';
            Editable = false;
        }
        field(34; "Plot Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Plot Number';
            Editable = false;
        }
        field(35; "Location Town"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Location Town';
            Editable = false;
        }
        field(36; "Location Country"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Location Country';
            Editable = false;
            
            // TODO
            // KE
        }
        field(37; "Type of Residency"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Type of Residency';
            Editable = false;

            // A – Owned
            // B – Rented
            // C – Mortgaged
            // D – Family Owned
        }
        field(38; "PIN Number"; Text[15])
        {
            DataClassification = ToBeClassified;
            Caption = 'PIN Number';
            Editable = false;
        }
        field(39; "Consumer E-Mail"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Consumer E-Mail';
            Editable = false;
        }
        field(40; "Employer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Employer Name';
            Editable = false;
        }
        field(41; "Occupational Industry Type"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Occupational Industry Type';
            Editable = false;

            // 001 - Agriculture
            // 002 - Manufacturing
            // 003 - Building/Construction
            // 004 - Mining/Quarrying
            // 005 - Energy /water
            // 006 -Trade
            // 007 - Tourism/ Restaurant/Hotels
            // 008 - Transport/ Communications
            // 009 - Real Estate
            // 010 - Financial Services
            // 011 – Government
        }
        field(42; "Employment Date"; Text[10])
        {
            Caption = 'Employment Date';
            Editable = false;
        }
        field(43; "Employment Type"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Employment Type';
            Editable = false;

            // 001 - Casual
            // 002 - Contract
            // 003 - Permanent
            // 004 - Pensioner
            // 005 - Self-Employed
        }
        field(44; "Income Amount"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Income Amount';
            Editable = false;
        }
        field(45; "Lenders Registered Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lenders Registered Name';
            Editable = false;
        }
        field(46; "Lenders Trading Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lenders Trading Name';
            Editable = false;
        }
        field(47; "Lenders Branch Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lenders Branch Name';
            Editable = false;
        }
        field(48; "Lenders Branch Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lenders Branch Code';
            Editable = false;

            // TODO
            // SXXXYYY
            // S For Saccos
            // XXX is the Lenders Institution Code left padded with Zeros e.g. 098 for a bank whose code is 98
            // YYY is the Lenders Branch Code left padded with Zeros e.g. 009 for a branch whose code is 9.
        }
        field(49; "Account Joint/Single Indicator"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Account Joint/Single Indicator';
            Editable = false;
            // TODO
            // J = Joint 
            // S = Single
        }
        field(50; "Account Product Type"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Account Product Type';
            Editable = false;
            // TODO
            // A –Overdraft
            // B – Credit Cards
            // C – Business Working Capital Loans
            // D – Business Expansion Loans
            // E – Mortgage Loans
            // F – Asset Finance Loans
            // G – Trade Finance Facilities
            // H – Personal Loans
            // I – Mobile Loan
            // J – Insurance Premium Financing
            // K – Group Loans
            // L – Uncleared Effects
        }
        field(51; "Date Account Opened"; Text[10])
        {
            Caption = 'Date Account Opened';
            Editable = false;
        }
        field(52; "Instalment Due Date"; Text[10])
        {
            Caption = 'Instalment Due Date';
            Editable = false;
        }
        field(53; "Original Amount"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Original Amount';
            Editable = false;
        }
        field(54; "Currency of Facility"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Currency Code';
            Editable = false;

            // TODO
            // KES – Kenya Shilling
        }
        field(55; "Current Balance in KES"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Current Balance in Kenya shillings';
            Editable = false;
        }
        field(56; "Current Balance"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Current Balance';
            Editable = false;
        }
        field(57; "Overdue Balance"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Overdue Balance';
            Editable = false;
        }
        field(58; "Overdue Date"; Text[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Overdue Date';
            Editable = false;
        }
        field(59; "Number of Days in Arrears"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Number of days the loan is overdue';
            Editable = false;
        }
        field(60; "No. of Installments in Arrears"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Number of Instalments in Arrears';
            Editable = false;
        }
        field(61; "Prudential Risk Classification"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Prudential Risk Classification';
            Editable = false;

            // TODO
            // Banks
            // A = Normal (0-30) 
            // B = Watch (>30-90)
            // C = Substandard (>90-180)
            // D = Doubtful (>180-360)
            // E = Loss (>360)

            // MFIs
            // A = Normal (0) 
            // B = Watch (>1-30)
            // C = Substandard (>31-60)
            // D = Doubtful (>61-90)
            // E = Loss (>90)
        }
        field(62; "Account Status"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Account Status';
            Editable = false;

            // TODO
            // A - Closed
            // B - Dormant
            // C - Write-Off
            // D - Legal
            // E - Collection
            // F - Active
            // G - Facility Reshceduled
            // H - Settled
            // J - Called Up
            // K - Suspended
            // L - Client Deceased
            // M - Deffered/Moratotium
            // N - Not Updated
            // P - Disputed
        }
        field(63; "Account Status Date"; Text[10])
        {
            Caption = 'Account Status Date';
            Editable = false;
        }
        field(64; "Account Closure Reason"; Text[50])
        {
            Caption = 'Account Closure Reason';
            Editable = false;
        }
        field(65; "Repayment Period"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Repayment Period';
            Editable = false;
        }
        field(66; "Deferred Payment Date"; Text[10])
        {
            Caption = 'Deferred Payment Date';
            Editable = false;
        }
        field(67; "Deferred Payment Amount"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Deferred Payment Amount';
            Editable = false;
        }
        field(68; "Payment Frequency"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Frequency';
            Editable = false;

            // TODO
            // W - Weekly 
            // M - Monthly 
            // Q – Quarterly
            // S – Semi-Annually
            // Y – Annually ( Yearly)
            // B – Bullet
            // T – Tri-annual (Three times in a year)
            // C – Biennial (Once in two years)
            // D – Daily
            // F - Fortnightly
        }
        field(69; "Disbursement Date"; Text[10])
        {
            Caption = 'Disbursement Date';
            Editable = false;
        }
        field(70; "Next Instalment Amount"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Next Instalment Amount';
            Editable = false;
        }
        field(71; "Date of Latest Payment"; Text[10])
        {
            Caption = 'Date of Latest Payment';
            Editable = false;
        }
        field(72; "Last Payment Amount"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Last Payment Amount';
            Editable = false;
        }
        field(73; "Type of Security"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Type of Security';
            Editable = false;
            // TODO
            // U – Unsecured
            // S – Fully Secured
        }
        field(74; "Group ID"; Text[15])
        {
            Caption = 'Group ID';
            Editable = false;
        }

        field(100; "Is Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Is Sent?';
            Editable = false;
        }
        field(101; "API Status"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(102; "API Response"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(103; "Batch No."; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Entry No.", "Loan No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        "Log Date Time" := CurrentDateTime;
    end;

    trigger OnDelete()
    begin
        Error('%1, deletion is NOT allowed!', UserId);
    end;
}
