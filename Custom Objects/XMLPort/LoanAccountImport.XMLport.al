#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185430 "Loan Account Import"
{
    Format = VariableText;

    schema
    {
        textelement(Name)
        {
            tableelement("Credit Accounts"; "Credit Accounts")
            {
                AutoUpdate = true;
                XmlName = 'ATMS';
                fieldelement(a; "Credit Accounts"."No.")
                {
                    FieldValidate = no;
                }
                fieldelement(b; "Credit Accounts".Name)
                {
                }
                fieldelement(c; "Credit Accounts"."Customer Posting Group")
                {
                }
                fieldelement(d; "Credit Accounts"."Product Type")
                {
                }
                fieldelement(e; "Credit Accounts"."Product Name")
                {
                }
                fieldelement(f; "Credit Accounts"."Member No.")
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
