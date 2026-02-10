#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185514 "Transaction Log-Finance2"
{
    Direction = Export;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Sky Transactions"; "Sky Transactions")
            {
                XmlName = 'CashierTrans';
                // SourceTableView = where(Field18=const(Yes));
                fieldelement(TID; "Sky Transactions"."Transaction ID")
                {
                }
                fieldelement(TDate; "Sky Transactions"."Transaction Date")
                {
                }
                fieldelement(TTime; "Sky Transactions"."Transaction Time")
                {
                }
                fieldelement(MemberAcc; "Sky Transactions"."Member Account")
                {
                }
                fieldelement(Description; "Sky Transactions".Description)
                {
                }
                fieldelement(Amount; "Sky Transactions".Amount)
                {
                }
                fieldelement(TType; "Sky Transactions"."Transaction Type")
                {
                }
                fieldelement(TName; "Sky Transactions"."Transaction Name")
                {
                }
                fieldelement(DPosted; "Sky Transactions"."Date Posted")
                {
                }
                fieldelement(TPosted; "Sky Transactions"."Time Posted")
                {
                }
                fieldelement(PostedBy; "Sky Transactions"."Posted By")
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
