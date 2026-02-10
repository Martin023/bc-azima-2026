table 52186208 "CRB Data"
{

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Surname; Text[250])
        {
        }
        field(3; "Date of Birth"; Text[30])
        {
        }
        field(4; "Client Code"; Code[20])
        {
        }
        field(5; "Account Number"; Code[20])
        {
        }
        field(6; Gender; Text[30])
        {
        }
        field(7; Nationality; Text[30])
        {
        }
        field(8; "Marital Status"; Text[30])
        {
        }
        field(9; "Primary Identification Number"; Text[30])
        {
        }
        field(10; "Secondary Identification"; Text[30])
        {
        }
        field(11; "Mobile No"; Text[30])
        {
        }
        field(12; "Work Telephone"; Code[50])
        {
        }
        field(13; "Postal Address 1"; Code[90])
        {
        }
        field(14; "Postal Address 2"; Code[100])
        {
        }
        field(15; "Postal Location Town"; Text[30])
        {
        }
        field(16; "Postal Location Country"; Text[30])
        {
        }
        field(17; "Post Code"; Code[50])
        {
        }
        field(18; "Physical Address 1"; Text[50])
        {
        }
        field(19; "Physical Address 2"; Text[50])
        {
        }
        field(20; "Location Town"; Text[50])
        {
        }
        field(21; "Location Country"; Text[50])
        {
        }
        field(22; "Date of Physical Address"; Text[30])
        {
        }
        field(23; "Customer Work Email"; Text[100])
        {
        }
        field(24; "Employer Name"; Text[250])
        {
        }
        field(25; "Employment Type"; Text[30])
        {
        }
        field(26; "Account Type"; Text[30])
        {
        }
        field(27; "Account Product Type"; Code[10])
        {
        }
        field(28; "Date Account Opened"; Text[30])
        {
        }
        field(29; "Installment Due Date"; Text[30])
        {
        }
        field(30; "Original Amount"; Text[30])
        {
        }
        field(31; "Currency of Facility"; Code[10])
        {
        }
        field(32; "Amount in Kenya shillings"; Text[30])
        {
            AutoFormatType = 0;
        }
        field(33; "Current Balance"; Text[30])
        {
        }
        field(34; "Overdue Balance"; Text[30])
        {
        }
        field(35; "No of Days in Arreas"; Integer)
        {
        }
        field(36; "No of Installment In"; Integer)
        {
        }
        field(37; "Performing / NPL Indicator"; Text[30])
        {
        }
        field(38; "Account Status"; Code[10])
        {
        }
        field(39; "Account Status Date"; Text[30])
        {
        }
        field(40; "Repayment Period"; Integer)
        {
        }
        field(41; "Payment Frequency"; Text[30])
        {
        }
        field(42; "Disbursement Date"; Text[30])
        {
        }
        field(43; "Insallment Amount"; Text[30])
        {
        }
        field(44; "Date of Latest Payment"; Text[30])
        {
        }
        field(45; "Last Payment Amount"; Text[30])
        {
        }
        field(46; "Forename 1"; Text[250])
        {
        }
        field(47; "Forename 2"; Text[250])
        {
        }
        field(48; "Forename 3"; Text[250])
        {
        }
        field(49; Salutation; Text[30])
        {
        }
        field(50; "Primary Identification code"; Code[30])
        {
        }
        field(51; "Secondary Identification code"; Code[30])
        {
        }
        field(52; "Other Identification Type"; Text[30])
        {
        }
        field(53; "Home Telephone"; Text[30])
        {
        }
        field(54; "Plot Number"; Text[30])
        {
        }
        field(55; "PIN Number"; Text[30])
        {
        }
        field(56; "Employment Date"; Text[30])
        {
        }
        field(57; "Salary Band"; Text[30])
        {
        }
        field(58; "Lenders Registered Name"; Text[30])
        {
        }
        field(59; "Lenders Trading Name"; Text[30])
        {
        }
        field(60; "Lenders Branch Name"; Text[30])
        {
        }
        field(61; "Lenders Branch Code"; Code[30])
        {
        }
        field(62; "Account Closure Reason"; Text[30])
        {
        }
        field(63; "Deferred Payment Date"; Text[30])
        {
        }
        field(64; "Deferred Payment"; Text[30])
        {
        }
        field(65; "Type of Security"; Text[30])
        {
        }
        field(66; "Other Identification Number"; Code[30])
        {
        }
        field(67; "Employer Industry Type"; Text[30])
        {
        }
        field(68; "Overdue Date"; Text[30])
        {
        }
        field(69; "Name 2"; Text[200])
        {
        }
        field(70; "Name 3"; Text[200])
        {
        }
        field(71; "Loan No."; Code[80])
        {
            Editable = false;
        }
        field(72; Outbal; Decimal)
        {
        }
        field(73; "Income Amount"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

