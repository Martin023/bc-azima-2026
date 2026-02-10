#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185451 "Dividends p"
{
    Format = VariableText;

    schema
    {
        textelement(name)
        {
            tableelement("Credit Accounts"; "Credit Accounts")
            {
                XmlName = 'dividends';
                fieldelement(cva; "Credit Accounts"."No.")
                {
                }
                fieldelement(a; "Credit Accounts".Name)
                {
                }
                fieldelement(r; "Credit Accounts"."Product Type")
                {
                }
                fieldelement(we; "Credit Accounts"."Product Name")
                {
                }
                fieldelement(d; "Credit Accounts"."Member No.")
                {
                }
                fieldelement(tr; "Credit Accounts"."Customer Posting Group")
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
