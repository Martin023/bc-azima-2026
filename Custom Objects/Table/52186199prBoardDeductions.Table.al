table 52186199 "prBoard Deductions"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Type; Option)
        {
            OptionMembers = Recurring,"Non-recurring";
        }
        field(6; "Tax deductible"; Boolean)
        {
        }
        field(7; Advance; Boolean)
        {
        }
        field(8; "Start date"; Date)
        {
        }
        field(9; "End Date"; Date)
        {
        }
        field(10; Percentage; Decimal)
        {
        }
        field(11; "Calculation Method"; Option)
        {
            OptionMembers = "Flat Amount","% of Basic Pay","Based on Table","Based on Hourly Rate","Based on Daily Rate ","% of Gross Pay","% of Basic Pay+Hse Allowance";
        }
        field(12; "G/L Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(13; "Flat Amount"; Decimal)
        {
        }
        // field(14; "Total Amount"; Decimal)
        // {
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(15; "Date Filter"; Date)
        {
        }
        field(16; "Posting Group Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            // 
        }
        field(17; Loan; Boolean)
        {
        }
        field(18; "Maximum Amount"; Decimal)
        {
        }
        field(19; "Grace period"; DateFormula)
        {
        }
        field(20; "Repayment Period"; DateFormula)
        {
        }
        field(21; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(26; "Pension Scheme"; Boolean)
        {
        }
        field(27; "Deduction Table"; Code[10])
        {
        }
        field(28; "G/L Account Employer"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(29; "Percentage Employer"; Decimal)
        {
        }
        field(30; "Minimum Amount"; Decimal)
        {
        }
        field(31; "Flat Amount Employer"; Decimal)
        {
        }
        // field(32; "Total Amount Employer"; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        field(33; "Loan Type"; Option)
        {
            OptionMembers = " ","Low Interest Benefit","Fringe Benefit";
        }
        field(34; "Show Balance"; Boolean)
        {
        }
        field(35; CoinageRounding; Boolean)
        {
        }
        field(36; "Employee Filter"; Code[10])
        {
            FieldClass = FlowFilter;
        }
        // field(37; "Opening Balance"; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        field(38; "Department Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(39; "Balance Mode"; Option)
        {
            FieldClass = FlowFilter;
            OptionMembers = Increasing," Decreasing";

        }
        field(40; "Main Loan Code"; Code[10])
        {
        }
        field(41; Shares; Boolean)
        {
        }
        field(42; "Show on report"; Boolean)
        {
        }
        field(43; "Non-Interest Loan"; Boolean)
        {
        }
        field(44; "Exclude when on Leave"; Boolean)
        {
        }
        field(45; "Co-operative"; Boolean)
        {
        }
        // field(46; "Total Shares"; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        field(47; Rate; Decimal)
        {
        }
        field(48; IsMandatory; Boolean)
        {
        }
        field(49; IsStatutoryDeduction; Boolean)
        {
        }
        field(50; "IsCoop/LnRep"; Boolean)
        {
        }
        field(51; "IsUnion/SalAdvance"; Boolean)
        {
        }
        field(52; Sorting; Integer)
        {
            AutoIncrement = true;
        }
        field(53; Rounding; Boolean)
        {
        }
        field(54; IsProvident; Boolean)
        {
        }
        field(55; StaffBenevolent; Boolean)
        {
        }
        field(56; "NSSF Vol."; Boolean)
        {
        }
        field(57; "Show-Balance"; Boolean)
        {
        }
        field(58; "Balance Type"; Option)
        {
            OptionMembers = " ",Add,Deduct;
        }
        field(59; IsOtherDeduction; Boolean)
        {
        }
        // field(60; "Total Shares OB"; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        field(61; "Journal Entry"; Boolean)
        {
        }
        field(62; "Is PV Item"; Boolean)
        {
        }
        field(63; "Is Insurance Premium"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

