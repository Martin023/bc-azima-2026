#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185512 "Transaction Log-Finance"
{
    Direction = Export;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Cashier Transactions"; "Cashier Transactions")
            {
                XmlName = 'CashierTrans';
                // SourceTableView = where(Field9=const(Yes));
                fieldelement(UserID; "Cashier Transactions".Cashier)
                {
                }
                fieldelement(ProductID; "Cashier Transactions"."Product Type")
                {
                }
                fieldelement(BranchID; "Cashier Transactions"."Global Dimension 2 Code")
                {
                }
                fieldelement(TransactionDescription; "Cashier Transactions"."Transaction Description")
                {
                }
                fieldelement(TransactionDateTime; "Cashier Transactions"."Transaction Time")
                {
                }
                fieldelement(TransactionDate; "Cashier Transactions"."Transaction Date")
                {
                }
                fieldelement(OldValue; "Cashier Transactions"."Book Balance")
                {
                }
                fieldelement(NewValue; "Cashier Transactions"."New Account Balance")
                {
                }
                fieldelement(AccountID; "Cashier Transactions"."Account No")
                {
                }
                fieldelement(MemberID; "Cashier Transactions"."Member No.")
                {
                }
                fieldelement(TransactionID; "Cashier Transactions".No)
                {
                }
                fieldelement(TransactionType; "Cashier Transactions"."Transaction Type")
                {
                }
                fieldelement(TransactionAmount; "Cashier Transactions".Amount)
                {
                }
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }
}
