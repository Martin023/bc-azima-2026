namespace KenpipeCBS.KenpipeCBS;

enum 52185456 "Payment Mode"
{
    Extensible = true;
    
    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Cash)
    {
        Caption = 'Cash';
    }
    value(2; Cheque)
    {
        Caption = 'Cheque';
    }
    value(3; EFT)
    {
        Caption = 'EFT';
    }
    value(4; "Deposit Slip")
    {
        Caption = 'Deposit Slip';
    }
    value(5; "Banker's Cheque")
    {
        Caption = 'Banker''s Cheque';
    }
    value(6; RTGS)
    {
        Caption = 'RTGS';
    }
    value(7; STO)
    {
        Caption = 'STO';
    }
    value(8; Other)
    {
        Caption = 'Other';
    }
}
