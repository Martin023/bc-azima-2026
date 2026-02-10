#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185480 ACCOUNT
{
    Format = VariableText;
    FormatEvaluate = Xml;

    schema
    {
        textelement(ROOT)
        {
            tableelement("Savings Accounts"; "Savings Accounts")
            {
                XmlName = 'ACCOUNT';
                fieldelement(A; "Savings Accounts"."No.")
                {
                    MinOccurs = Zero;
                    Unbound = false;
                }
                fieldelement(B; "Savings Accounts"."Member No.")
                {
                    FieldValidate = no;
                }
                fieldelement(C; "Savings Accounts".Name)
                {
                }
                fieldelement(D; "Savings Accounts"."E-Mail")
                {
                }
                fieldelement(E; "Savings Accounts".Status)
                {
                }
                fieldelement(F; "Savings Accounts"."Product Type")
                {
                    FieldValidate = yes;
                }
                fieldelement(G; "Savings Accounts"."Account Category")
                {
                }
                fieldelement(H; "Savings Accounts"."Product Name")
                {
                }
                fieldelement(I; "Savings Accounts"."Balance (LCY)")
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
