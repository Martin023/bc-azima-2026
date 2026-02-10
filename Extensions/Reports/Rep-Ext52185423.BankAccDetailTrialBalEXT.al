reportextension 52185423 "Bank Acc. - DetailTrial BalEXT" extends "Bank Acc. - Detail Trial Bal."
{
    dataset
    {
        add("Bank Account Ledger Entry")
        {
            column(Debit_Amount__LCY_; "Debit Amount (LCY)")
            {
                 IncludeCaption = true;
            }
            column(Credit_Amount__LCY_; "Credit Amount (LCY)")
            {
                 IncludeCaption = true;
            }
        }
    }
}
