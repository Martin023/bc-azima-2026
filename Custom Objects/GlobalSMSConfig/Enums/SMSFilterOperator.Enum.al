enum 52185970 "SMS Filter Operator"
{
    Extensible = false;

    value(0; Equal)
    {
        Caption = 'Equal (=)';
    }
    value(1; NotEqual)
    {
        Caption = 'Not Equal (<>)';
    }
    value(2; GreaterThan)
    {
        Caption = 'Greater Than (>)';
    }
    value(3; LessThan)
    {
        Caption = 'Less Than (<)';
    }
    value(4; GreaterOrEqual)
    {
        Caption = 'Greater or Equal (>=)';
    }
    value(5; LessOrEqual)
    {
        Caption = 'Less or Equal (<=)';
    }
    value(6; Range)
    {
        Caption = 'Range (..)';
    }
    value(7; Contains)
    {
        Caption = 'Contains (@*)';
    }
    value(8; StartsWith)
    {
        Caption = 'Starts With (@)';
    }
    value(9; Blank)
    {
        Caption = 'Is Blank';
    }
    value(10; NotBlank)
    {
        Caption = 'Is Not Blank';
    }
}
