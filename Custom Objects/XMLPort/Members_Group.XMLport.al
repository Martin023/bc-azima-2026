#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185444 Members_Group
{
    Format = VariableText;
    FormatEvaluate = Legacy;

    schema
    {
        textelement(Name)
        {
            tableelement("Savings Accounts"; "Savings Accounts")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(a; "Savings Accounts"."No.")
                {
                }
                fieldelement(b; "Savings Accounts".Name)
                {
                }
                fieldelement(c; "Savings Accounts"."Member No.")
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
