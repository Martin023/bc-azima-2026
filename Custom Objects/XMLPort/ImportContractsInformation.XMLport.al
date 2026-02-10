#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185537 "Import Contracts Information"
{
    Format = VariableText;

    schema
    {
        textelement(contractsinfo)
        {
            tableelement(Contracts; Contracts)
            {
                XmlName = 'contracts';
                fieldelement(b; Contracts."Contract No")
                {
                }
                fieldelement(a; Contracts."Type Of Service")
                {
                }
                fieldelement(c; Contracts."Contract Description")
                {
                }
                fieldelement(d; Contracts."Start Date")
                {
                }
                fieldelement(e; Contracts."End Date")
                {
                }
                fieldelement(f; Contracts."Contractor Type")
                {
                }
                fieldelement(g; Contracts."Contractor No")
                {
                }
                fieldelement(k; Contracts."Payment Terms")
                {
                }
                fieldelement(m; Contracts."Responsible Employee")
                {
                }
                fieldelement(n; Contracts."User Department")
                {
                }
                fieldelement(o; Contracts."Contract Sum")
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
