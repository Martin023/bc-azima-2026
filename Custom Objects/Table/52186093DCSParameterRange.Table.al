table 52186093 "DCS Parameter Range"
{

    fields
    {
        field(1; RangeID; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Parameter Code"; Code[20])
        {
            TableRelation = "DCS Parameter".Code;
        }
        field(3; "Range MIN"; Decimal)
        {
        }
        field(4; "Range MAX"; Decimal)
        {
        }
        field(5; "Evaluation Method"; Option)
        {
            OptionCaption = 'Flat Rate,Percentage,Perc. Inc.,Perc. Decs.,Average,Summation,Multiplication,Division,Subtraction,Range,Graduated Range,Exponential';
            OptionMembers = "Flat Rate",Percentage,"Perc. Inc.","Perc. Decs.","Average",Summation,Multiplication,Division,Subtraction,Range,"Graduated Range",Exponential;
        }
        field(6; "Evaluation Factor"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; RangeID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

