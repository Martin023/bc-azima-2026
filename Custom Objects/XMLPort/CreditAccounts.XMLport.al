#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185458 "Credit Accounts"
{

    schema
    {
        textelement(NME)
        {
            tableelement("Credit Accounts"; "Credit Accounts")
            {
                AutoUpdate = true;
                MinOccurs = Zero;
                XmlName = 'JOURNAL';
                fieldelement(a; "Credit Accounts"."No.")
                {
                    FieldValidate = no;
                }
                fieldelement(b; "Credit Accounts"."Member No.")
                {
                }
                fieldelement(c; "Credit Accounts"."Product Type")
                {
                }
                fieldelement(d; "Credit Accounts"."Product Name")
                {
                }
                fieldelement(e; "Credit Accounts"."Payroll/Staff No.")
                {
                }
                fieldelement(f; "Credit Accounts"."Customer Posting Group")
                {
                }
                fieldelement(g; "Credit Accounts".Name)
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
