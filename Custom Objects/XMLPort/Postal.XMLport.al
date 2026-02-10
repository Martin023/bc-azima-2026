#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185442 Postal
{
    Format = VariableText;
    FormatEvaluate = Legacy;

    schema
    {
        textelement(Nme)
        {
            tableelement("Loans Interest"; "Loans Interest")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'Postal';
                fieldelement(Code; "Loans Interest".No)
                {
                    FieldValidate = no;
                }
                fieldelement(City; "Loans Interest"."Account No")
                {
                    FieldValidate = no;
                }
                fieldelement(a; "Loans Interest"."Account Type")
                {
                }
                fieldelement(b; "Loans Interest"."Interest Amount")
                {
                }
                fieldelement(c; "Loans Interest".Description)
                {
                }
                fieldelement(d; "Loans Interest"."Loan No.")
                {
                }
                fieldelement(e; "Loans Interest"."Loan Product type")
                {
                }
                fieldelement(f; "Loans Interest"."Interest Bill")
                {
                }
                fieldelement(g; "Loans Interest"."Outstanding Interest")
                {
                }
                fieldelement(h; "Loans Interest"."Outstanding Balance")
                {
                }
                fieldelement(i; "Loans Interest"."Shortcut Dimension 2 Code")
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
