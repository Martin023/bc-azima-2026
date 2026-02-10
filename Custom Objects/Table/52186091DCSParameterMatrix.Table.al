table 52186091 "DCS Parameter Matrix"
{

    fields
    {
        field(1; "Loan Product Code"; Code[20])
        {
            TableRelation = "Product Factory"."Product ID";
        }
        field(2; "Parameter Code"; Code[20])
        {
            TableRelation = "DCS Parameter".Code;

            trigger OnValidate()
            begin
                if Parameter.Get("Parameter Code") then begin
                    "Parameter Desc" := Parameter.Description;
                    //  "Parameter Scope":=Parameter."Parameter Scope";
                end;
            end;
        }
        field(3; "Parameter Desc"; Text[100])
        {
        }
        field(4; Factor; Decimal)
        {
        }
        field(5; "Contributes To Score As"; Option)
        {
            OptionCaption = 'Formula Factor,Flat Rate,Range,Ceiling,Multiplier,Divisor,Frequency,Sum,Difference,Graduated Range,Exponential,Terminate,Probability,Floor';
            OptionMembers = "Formula Factor","Flat Rate",Range,Ceiling,Multiplier,Divisor,Frequency,"Sum",Difference,"Graduated Range",Exponential,Terminate,Probability,Floor;
        }
        field(6; "Parameter Base"; Option)
        {
            OptionCaption = 'Open,Share Capital,Deposits,Loans,Repayment,Loans Guaranteed,Net Salary,Basic Salary,Other Income,Interest Rate,Mobile Transactions,Fixed Deposits,Dividends,Guarantors,Collateral,Date of Join,NetIncome,Gross Salary';
            OptionMembers = Open,"Share Capital",Deposits,Loans,Repayment,"Loans Guaranteed","Net Salary","Basic Salary","Other Income","Interest Rate","Mobile Transactions","Fixed Deposits",Dividends,Guarantors,Collateral,"Date of Join",NetIncome,"Gross Salary";
        }
        field(7; "Application Priority"; Integer)
        {
        }
        field(8; Formula; Text[30])
        {
        }
        field(9; "Parameter Base Unit"; Option)
        {
            OptionCaption = 'Value,Transaction date,Count';
            OptionMembers = Value,"Transaction date","Count";
        }
        field(10; "Success Default Value"; Decimal)
        {
        }
        field(11; "Parameter Scope"; Option)
        {
            OptionCaption = 'General,Long Term,Short Term,Product Specific,LoanTopUp,Current Product,Current Application';
            OptionMembers = General,"Long Term","Short Term","Product Specific",LoanTopUp,"Current Product","Current Application";
        }
        field(12; "Failure Response"; Text[100])
        {
        }
        field(13; "Date Formula"; DateFormula)
        {
        }
        field(14; "Data Source"; Code[20])
        {
            TableRelation = "DCS Data Source".Code;
        }
        field(15; "Computation Method"; Option)
        {
            OptionCaption = 'Direct Factor,Formula Factor';
            OptionMembers = "Direct Factor","Formula Factor";
        }
        field(16; "Fall Back Parameter"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Loan Product Code", "Parameter Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Parameter: Record "DCS Parameter";
}

