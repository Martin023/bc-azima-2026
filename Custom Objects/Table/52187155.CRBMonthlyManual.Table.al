table 52187155 "CRB Monthly Manual"
{
    Caption = 'CRB Monthly Manual';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Sur Name"; Text[100])
        {
            Caption = 'Surname';
        }
        field(2; "Forename 1"; Text[100])
        {
            Caption = 'Forename 1';
        }
        field(3; "Forename 2"; Text[100])
        {
            Caption = 'Forename 2';
        }
        field(4; "Forename 3"; Text[100])
        {
            Caption = 'Forename 3';
        }
        field(5; "Trading As"; Text[100])
        {
            Caption = 'Trading As';
        }
        field(6; "Date of Birth"; Text[10])
        {
            Caption = 'Date of Birth';
        }
        field(7; "Client No"; Code[20])
        {
            Caption = 'Client No';
        }
        field(8; "Account No"; Code[20])
        {
            Caption = 'Account No';
        }
        field(9; "Old Account No"; Code[20])
        {
            Caption = 'Old Account No';
        }
        field(10; Gender; Text[10])
        {
            Caption = 'Gender';
        }
        field(11; Nationality; Text[50])
        {
            Caption = 'Nationality';
        }
        field(12; "Marital Status"; Text[20])
        {
            Caption = 'Marital Status';
        }
        field(13; "Primary ID Document Type"; Text[50])
        {
            Caption = 'Primary ID Document Type';
        }
        field(14; "Primary ID Document Number"; Text[50])
        {
            Caption = 'Primary ID Document Number';
        }
        field(15; "Secondary ID Document Type"; Text[50])
        {
            Caption = 'Secondary ID Document Type';
        }
        field(16; "Secondary ID Document Number"; Text[50])
        {
            Caption = 'Secondary ID Document Number';
        }
        field(17; "Other ID Document Type"; Text[50])
        {
            Caption = 'Other ID Document Type';
        }
        field(18; "Other ID Document Number"; Text[50])
        {
            Caption = 'Other ID Document Number';
        }
        field(19; "Passport Country Code"; Code[3])
        {
            Caption = 'Passport Country Code';
        }
        field(20; "Mobile Telephone Number"; Text[20])
        {
            Caption = 'Mobile Telephone Number';
        }
        field(21; "Home Telephone Number"; Text[20])
        {
            Caption = 'Home Telephone Number';
        }
        field(22; "Work Telephone Number"; Text[20])
        {
            Caption = 'Work Telephone Number';
        }
        field(23; "Postal Adress 1"; Text[100])
        {
            Caption = 'Postal Address 1';
        }
        field(24; "Postal Adress 2"; Text[100])
        {
            Caption = 'Postal Address 2';
        }
        field(25; "Postal Location Town"; Text[100])
        {
            Caption = 'Postal Location Town';
        }
        field(26; "Postal Location Country"; Text[100])
        {
            Caption = 'Postal Location Country';
        }
        field(27; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
        }
        field(28; "Physical Adress 1"; Text[100])
        {
            Caption = 'Physical Address 1';
        }
        field(29; "Physical Adress 2"; Text[100])
        {
            Caption = 'Physical Address 2';
        }
        field(30; "Plot Number"; Text[50])
        {
            Caption = 'Plot Number';
        }
        field(31; "Location Town"; Text[100])
        {
            Caption = 'Location Town';
        }
        field(32; "Location Coutry"; Text[100])
        {
            Caption = 'Location Country';
        }
        field(33; "Type Of Residency"; Text[50])
        {
            Caption = 'Type Of Residency';
        }
        field(34; "P.I.N Number"; Text[20])
        {
            Caption = 'Pin Number';
        }
        field(35; "Consumer Email"; Text[100])
        {
            Caption = 'Consumer Email';
        }
        field(36; "Employer Name"; Text[100])
        {
            Caption = 'Employer Name';
        }
        field(37; "Occupational Industry Type"; Text[100])
        {
            Caption = 'Occupational Industry Type';
        }
        field(38; "Employment Date"; Text[10])
        {
            Caption = 'Employment Date';
        }
        field(39; "Employment Type"; Text[50])
        {
            Caption = 'Employment Type';
        }
        field(40; "Income Amount"; Text[20])
        {
            Caption = 'Income Amount';
        }
        field(41; "Lenders Registered Name"; Text[100])
        {
            Caption = 'Lenders Registered Name';
        }
        field(42; "Lenders Trading Name"; Text[100])
        {
            Caption = 'Lenders Trading Name';
        }
        field(43; "Lenders Brach Name"; Text[100])
        {
            Caption = 'Lenders Branch Name';
        }
        field(44; "Lenders Brach Code"; Code[20])
        {
            Caption = 'Lenders Branch Code';
        }
        field(45; "Account Joint Single Indicator"; Text[50])
        {
            Caption = 'Account Joint/Single Indicator';
        }
        field(46; "Account Product Type"; Text[100])
        {
            Caption = 'Account Product Type';
        }
        field(47; "Date Account Opened"; Text[10])
        {
            Caption = 'Date Account Opened';
        }
        field(48; "Installment Due Date"; Text[10])
        {
            Caption = 'Installment Due Date';
        }
        field(49; "Original Amount"; Text[20])
        {
            Caption = 'Original Amount';
        }
        field(50; "Currency Of Facility"; Code[10])
        {
            Caption = 'Currency Of Facility';
        }
        field(51; "Current Bal In Kes"; Text[20])
        {
            Caption = 'Current Balance In Kes';
        }
        field(52; "Current Bal"; Text[20])
        {
            Caption = 'Current Balance';
        }
        field(53; "Overdue Balance"; Text[20])
        {
            Caption = 'Overdue Balance';
        }
        field(54; "Overdue Date"; Text[10])
        {
            Caption = 'Overdue Date';
        }
        field(55; "Number Of Days In Arrears"; Integer)
        {
            Caption = 'Number Of Days In Arrears';
        }
        field(56; "No Of Installments In Arrears"; Integer)
        {
            Caption = 'Number Of Installments In Arrears';
        }
        field(57; "Prudential Risk Classification"; Text[50])
        {
            Caption = 'Prudential Risk Classification';
        }
        field(58; "Account Status"; Text[50])
        {
            Caption = 'Account Status';
        }
        field(59; "Account Status Date"; Text[10])
        {
            Caption = 'Account Status Date';
        }
        field(60; "Account Clossure Reason"; Text[100])
        {
            Caption = 'Account Closure Reason';
        }
        field(61; "Repayment Period"; Integer)
        {
            Caption = 'Repayment Period';
        }
        field(62; "Deffered Payment Date"; Text[10])
        {
            Caption = 'Deferred Payment Date';
        }
        field(63; "Deffered Payment Amount"; Text[20])
        {
            Caption = 'Deferred Payment Amount';
        }
        field(64; "Payment Frequency"; Text[50])
        {
            Caption = 'Payment Frequency';
        }
        field(65; "Disbursement Date"; Text[10])
        {
            Caption = 'Disbursement Date';
        }
        field(66; "Next Installment Amount"; Text[20])
        {
            Caption = 'Next Installment Amount';
        }
        field(67; "Date Of Latest Payment"; Text[10])
        {
            Caption = 'Date Of Latest Payment';
        }
        field(68; "Last Payment Amount"; Text[20])
        {
            Caption = 'Last Payment Amount';
        }
        field(69; "Type Of Security"; Text[100])
        {
            Caption = 'Type Of Security';
        }
        field(70; "Group ID"; Text[50])
        {
            Caption = 'Group ID';
        }

        //Other Fields
        field(71; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(72; "Batch No"; Code[50])
        {

        }
        field(73; "Generated By"; Code[100])
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
        "Generated By" := UserId;
    end;
}
