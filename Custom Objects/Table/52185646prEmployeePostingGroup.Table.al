table 52185646 "prEmployee Posting Group"
{
    DataCaptionFields = "Code", Description;
    DrillDownPageID = "prEmployee Posting Group";
    LookupPageID = "prEmployee Posting Group";

    fields
    {
        field(1; "Code"; Code[50])
        {
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Salary Account"; Code[100])
        {
            TableRelation = "G/L Account";
        }
        field(4; "Income Tax Account"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(5; "SSF Employer Account"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(6; "SSF Tier 1 Payable Account"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(21; "SSF Tier 2 Payable Account"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(25; "Housing Levy Employer"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(26; "Housing Levy Employee"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(7; "Net Salary Payable"; Code[50])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(8; "Operating Overtime"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(9; "Tax Relief"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(10; "Employee Provident Fund Acc."; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(12; "Pension Employer Acc"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(13; "Pension Employee Acc"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(14; "Earnings and deductions"; Code[50])
        {
        }

        field(19; "NHIF Employee Account"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(30; "SHIF Account"; code[50])
        {
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Earnings and deductions")
        {
        }
    }

    fieldgroups
    {
    }
}

