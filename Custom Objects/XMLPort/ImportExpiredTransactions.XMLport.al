#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185538 "Import Expired Transactions"
{
    Format = VariableText;

    schema
    {
        textelement(ExpiredTransactions)
        {
            tableelement("Reverse ATM Expired Trans"; "Reverse ATM Expired Trans")
            {
                XmlName = 'ExpiredTrans';
                fieldelement(a; "Reverse ATM Expired Trans"."Trace ID")
                {
                }
                fieldelement(b; "Reverse ATM Expired Trans"."Account Number")
                {
                }
                fieldelement(c; "Reverse ATM Expired Trans".Amount)
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
