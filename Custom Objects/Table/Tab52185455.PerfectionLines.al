table 52185455 "Perfection Lines"
{
    Caption = 'Perfection Lines';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Loan No."; Code[50])
        {
            Caption = 'Loan No.';
        }
        field(2; "Security No."; Code[150])
        {
            Caption = 'Security No.';
        }
        field(3; "Property No."; Code[150])
        {
            Caption = 'Property No.';
        }
        field(4; "Collateral Value Sum"; Decimal)
        {
            Caption = 'Collateral Value Sum';
        }
        field(5; "Spousal Consent"; Boolean)
        {
            Caption = 'Spousal Consent';
        }
        field(6; "Land Control Board Consent"; Boolean)
        {
            Caption = 'Land Control Board Consent';
        }
        field(7; "Fees Payable to the firm"; Decimal)
        {
            Caption = 'Fees Payable to the firm';
        }
        field(8; "Status of the fees"; Option)
        {
            Caption = 'Status of the fees';
            OptionMembers = Unpaid, Paid, "Partially Paid";
        }
        field(9; "Amount to Charge"; Decimal)
        {
            Caption = 'Amount to Charge';
        }
        field(10; "Market Value"; Decimal)
        {
            Caption = 'Market Value';
        }
        field(11; "Forced Sale Value"; Decimal)
        {
            Caption = 'Force Sale Value';
        }
        field(12; "Collateral Types"; Option)
        {
            Caption = 'Collateral Types';
            OptionMembers = "Land", "Motor Vehicle", "Shares", "Other";
        }
        field(13; "Chargor Name"; Code[900])
        {
            Caption = 'Chargor Name';
        }
        field(14; "Chargor/Owner Name"; Code[900])
        {
            Caption = 'Chargor/Owner Name';
        }
        field(15; "Chargor/Owner KRA PIN"; Code[200])
        {
            Caption = 'Chargor/Owner KRA PIN';
        }
        field(16; "Perfected"; Boolean)
        {
            Caption = 'Perfected';
        }
        field(17; "Discharged"; Boolean)
        {
            Caption = 'Discharged';
        }
        field(18; "Charge Type"; Code[100])
        {
            Caption = 'Charge Type';
        }
        field(19; "Collateral Owner"; Option)
        {
            Caption = 'Collateral Owner';
            OptionMembers = " ",Loanee,Chargor;
        }
        field(20; "Member No."; Code[20])
        {
            Caption = 'Member No.';
        }
        field(21; "Member Name"; Text[250])
        {
            Caption = 'Member Name';
        }
        field(22; "Chargor Phone No."; Code[20])
        {
            Caption = 'Chargor Phone No.';
        }
        field(23; "SMS Sent"; Boolean)
        {
            Caption = 'SMS Sent';
        }
        field(25; "Date Registered"; Date)
        {
            Caption = 'Date Registered';
        }
        field(26; "Loan Name"; Code[150])
        {
            Caption = 'Loan Name';
        }
        field(28; "Concatenated Property"; Text[250])
        {
            Caption = 'Concatenated Property';
        }
    }
    keys
    {
        key(PK; "Loan No.", "Security No.")
        {
            Clustered = true;
        }
    }
}
