table 52186197 "prBoard Earnings"
{
    DrillDownPageID = "prBoard Earning";
    LookupPageID = "prBoard Earning";

    fields
    {
        field(1; "Code"; Code[10])
        {
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Pay Type"; Option)
        {
            OptionMembers = Recurring,"Non-recurring";
        }
        field(4; "Start Date"; Date)
        {
        }
        field(5; "End Date"; Date)
        {
        }
        field(6; Taxable; Boolean)
        {
        }
        field(7; "Calculation Method"; Option)
        {
            OptionMembers = "Flat amount","% of Basic pay","% of Gross pay","% of Taxable income","% of Basic after tax","Based on Hourly Rate","Based on Daily Rate";
        }
        field(8; "Flat Amount"; Decimal)
        {
        }
        field(9; Percentage; Decimal)
        {
        }
        field(10; "G/L Account"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        // field(11; "Total Amount"; Decimal)
        // {
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(12; "Date Filter"; Date)
        {
        }
        field(13; "Posting Group Filter"; Code[10])
        {
            FieldClass = FlowFilter;

        }
        field(14; "Pay Period Filter"; Date)
        {
            ClosingDates = false;
            FieldClass = FlowFilter;
            TableRelation = "PR Payroll Periods";
        }
        field(15; Quarters; Boolean)
        {
        }
        field(16; "Non-Cash Benefit"; Boolean)
        {
        }
        field(17; "Minimum Limit"; Decimal)
        {
        }
        field(18; "Maximum Limit"; Decimal)
        {
        }
        field(19; "Reduces Tax"; Boolean)
        {
        }
        field(20; "Overtime Factor"; Decimal)
        {
        }
        field(21; "Employee Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "PrBoard Loan Transactions";
        }
        // field(22; Counter; Integer)
        // {
        //     FieldClass = FlowField;
        // }
        // field(23; NoOfUnits; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        field(24; "Low Interest Benefit"; Boolean)
        {
        }
        field(25; "Show Balance"; Boolean)
        {
        }
        field(26; CoinageRounding; Boolean)
        {
        }
        field(27; OverDrawn; Boolean)
        {
        }
        // field(28; "Opening Balance"; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        field(29; OverTime; Boolean)
        {
        }
        field(30; "Department Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(31; Months; Decimal)
        {
            Description = 'Used to cater for taxation based on annual bracket eg 1,12 months (the default is 1month) FOR NEPAL';
        }
        field(32; "Show on Report"; Boolean)
        {
        }
        field(33; "Time Sheet"; Boolean)
        {
        }
        field(34; IsMandatory; Boolean)
        {
        }
        field(35; "Is HouseAll/NonPensionable"; Boolean)
        {
        }
        field(36; Sorting; Integer)
        {
            AutoIncrement = true;
        }
        field(37; Arrear; Boolean)
        {
        }
        field(38; "Insurance Relief"; Boolean)
        {
        }
        // field(39; "Insurance Relief Amount"; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        field(40; Rounding; Boolean)
        {
        }
        field(41; "Show-Balance"; Boolean)
        {
        }
        field(42; "Balance Type"; Option)
        {
            OptionMembers = " ",Add,Deduct;
        }
        field(43; "Is Other Relief"; Boolean)
        {
        }
        field(44; "Is Pension Relief"; Boolean)
        {
        }
        field(45; "Other Allowances"; Boolean)
        {
        }
        field(46; "Is Telephone Allowance"; Boolean)
        {
        }
        field(47; "Journal Entry"; Boolean)
        {
        }
        field(48; "Is PV Item"; Boolean)
        {
        }
        field(49; IncLeaveGross; Boolean)
        {
        }
        field(50; "Is Insurance Relief"; Boolean)
        {
        }
        field(51; "Is Leave Allowance"; Boolean)
        {
        }
        field(52; "Total Board"; Decimal)
        {
            CalcFormula = Sum("PR Board Transactions".Amount WHERE(Code = FIELD(Code),
                                                                    Date = FIELD("Pay Period Filter"),
                                                                    "No." = FIELD("Employee Filter"),
                                                                    Closed = CONST(false)));
            FieldClass = FlowField;
        }
        field(53; "Is Deduction"; Boolean)
        {
        }
        field(54; "Is Salary Advance"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Show on Report")
        {
        }
        key(Key3; OverTime)
        {
        }
        key(Key4; "Time Sheet")
        {
        }
    }

    fieldgroups
    {
    }
}

