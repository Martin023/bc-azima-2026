table 52186571 "CRB Monthly NICE File Subm."
{
    Caption = 'CRB Monthly Non-Individual Consumer and Account file Submissions';
    DataClassification = ToBeClassified;

    LookupPageId = "CRB Monthly NICE File Subm.";
    DrillDownPageId = "CRB Monthly NICE File Subm.";

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
        field(5; "Registered Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            Caption = 'Registered Name';
            Editable = false;
        }
        field(6; "Trading Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            Caption = 'Trading Name';
            Editable = false;
        }
        field(7; "Registration Date"; Text[10])
        {
            Caption = 'Registration Date';
            Editable = false;
        }
        field(8; "Registration Number"; Text[25])
        {
            Caption = 'Registration Number';
            Editable = false;
        }
        field(9; "Previous Registration Number"; Text[25])
        {
            Caption = 'Previous Registration Number';
            Editable = false;
        }
        field(10; "Nationality"; Code[5])
        {
            Caption = 'Nationality';
            Editable = false;
            // TODO
            // KE - Kenya
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
        field(14; "Company Type"; Code[5])
        {
            Caption = 'Company Type';
            Editable = false;
            // TODO
            // A – Public Limited company
            // B - Private Limited company
            // C - Partnership
            // D - Sole Proprietor
            // E – Society
            // F - Club/Association
            // G – Investment Group
            // H - Public Corporation
            // J - NGO
            // L - Church
            // M - School
        }
        field(15; "Industry Code"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Industry Code';
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
        field(16; "Annual Turnover Amount"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Annual Turnover Amount';
            Editable = false;
        }
        field(17; "PIN Number"; Text[15])
        {
            DataClassification = ToBeClassified;
            Caption = 'PIN Number';
            Editable = false;
        }
        field(18; "VAT Number"; Text[15])
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Number';
            Editable = false;
        }
        field(19; "Number of Stakeholders"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Number of Stakeholders';
            Editable = false;
        }
        field(20; "Trading Status"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Trading Status';
            Editable = false;

            // TODO
            // 001=Dormant
            // 002=Actively Trading
            // 003=Under Receivership/Liquidation
            // 004=Liquidated
            // 005=Under Management
            // 006=Dissolved
            // 007=Bankrupt
        }
        field(21; "Trading Status Date"; Text[10])
        {
            Caption = 'Trading Status Date';
            Editable = false;
        }
        field(22; "Main Telephone No."; Text[15])
        {
            DataClassification = ToBeClassified;
            Caption = 'Main Telephone Number';
            Editable = false;
        }
        field(23; "Other Telephone No."; Text[15])
        {
            DataClassification = ToBeClassified;
            Caption = 'Other Telephone Number';
            Editable = false;
        }
        field(24; "Postal Address 1"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Postal Address 1';
            Editable = false;
        }
        field(25; "Postal Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Postal Address 2';
            Editable = false;
        }
        field(26; "Town"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Town';
            Editable = false;
        }
        field(27; "Country"; Code[5])
        {
            Caption = 'Country';
            Editable = false;
            // TODO
            // KE - Kenya
        }
        field(28; "Post Code"; Text[10])
        {
            Caption = 'Post Code';
            Editable = false;
        }
        field(29; "Physical Address 1"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Physical Address 1';
            Editable = false;
        }
        field(30; "Physical Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Physical Address 2';
            Editable = false;
        }
        field(31; "Plot Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Plot Number';
            Editable = false;
        }
        field(32; "Physical Location Town"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Physical Location Town';
            Editable = false;
        }
        field(33; "Physical Location Country"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Physical Location Country';
            Editable = false;

            // TODO
            // KE
        }
        field(34; "Lenders Registered Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lenders Registered Name';
            Editable = false;
        }
        field(35; "Lenders Trading Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lenders Trading Name';
            Editable = false;
        }
        field(36; "Lenders Branch Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lenders Branch Name';
            Editable = false;
        }
        field(37; "Lenders Branch Code"; Code[10])
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
        field(38; "Account Joint/Single Indicator"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Account Joint/Single Indicator';
            Editable = false;
            // TODO
            // J = Joint 
            // S = Single
        }
        field(39; "Class of Organization"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Class of Organization';
            Editable = false;
            // TODO
            // A – Corporate
            // B – SME
            // C - NGO/Church/Society
        }
        field(40; "Account Product Type"; Code[5])
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
        field(41; "Date Account Opened"; Text[10])
        {
            Caption = 'Date Account Opened';
            Editable = false;
        }
        field(42; "Instalment Due Date"; Text[10])
        {
            Caption = 'Instalment Due Date';
            Editable = false;
        }
        field(43; "Prudential Risk Classification"; Code[5])
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
        field(44; "Original Amount"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Original Amount';
            Editable = false;
        }
        field(45; "Currency of Facility"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Currency Code';
            Editable = false;

            // TODO
            // KES – Kenya Shilling
        }
        field(46; "Current Balance in KES"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Current Balance in Kenya shillings';
            Editable = false;
        }
        field(47; "Current Balance"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Current Balance';
            Editable = false;
        }
        field(48; "Overdue Balance"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Overdue Balance';
            Editable = false;
        }
        field(49; "Overdue Date"; Text[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Overdue Date';
            Editable = false;
        }
        field(50; "Number of Days in Arrears"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Number of days the loan is overdue';
            Editable = false;
        }
        field(51; "No. of Installments in Arrears"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Number of Instalments in Arrears';
            Editable = false;
        }
        field(52; "Account Status"; Code[5])
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
        field(53; "Account Status Date"; Text[10])
        {
            Caption = 'Account Status Date';
            Editable = false;
        }
        field(54; "Account Closure Reason"; Text[50])
        {
            Caption = 'Account Closure Reason';
            Editable = false;
        }
        field(55; "Repayment Period"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Repayment Period';
            Editable = false;
        }
        field(56; "Deferred Payment Date"; Text[10])
        {
            Caption = 'Deferred Payment Date';
            Editable = false;
        }
        field(57; "Deferred Payment Amount"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Deferred Payment Amount';
            Editable = false;
        }
        field(58; "Payment Frequency"; Code[5])
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
        field(59; "Disbursement Date"; Text[10])
        {
            Caption = 'Disbursement Date';
            Editable = false;
        }
        field(60; "Next Instalment Amount"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Next Instalment Amount';
            Editable = false;
        }
        field(61; "Date of Latest Payment"; Text[10])
        {
            Caption = 'Date of Latest Payment';
            Editable = false;
        }
        field(62; "Last Payment Amount"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Last Payment Amount';
            Editable = false;
        }
        field(63; "Type of Security"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Type of Security';
            Editable = false;
            // TODO
            // U – Unsecured
            // S – Fully Secured
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
