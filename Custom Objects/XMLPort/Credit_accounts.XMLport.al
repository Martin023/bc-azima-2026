#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185461 Credit_accounts
{
    Format = VariableText;

    schema
    {
        textelement(a)
        {
            tableelement("Credit Accounts"; "Credit Accounts")
            {
                AutoReplace = true;
                XmlName = 'b';
                fieldelement(aa; "Credit Accounts"."No.")
                {
                    FieldValidate = no;
                }
                fieldelement(bb; "Credit Accounts".Name)
                {
                }
                fieldelement(c; "Credit Accounts"."Customer Posting Group")
                {
                }
                fieldelement(d; "Credit Accounts"."Employer Code")
                {
                }
                fieldelement(e; "Credit Accounts"."Payroll/Staff No.")
                {
                }
                fieldelement(f; "Credit Accounts"."Account Category")
                {
                }
                fieldelement(g; "Credit Accounts"."Product Type")
                {
                }
                fieldelement(h; "Credit Accounts"."Member No.")
                {
                }
                fieldelement(i; "Credit Accounts"."Product Name")
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
