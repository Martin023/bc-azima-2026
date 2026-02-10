#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185466 Signatories
{
    Format = VariableText;

    schema
    {
        textelement(Signatories)
        {
            tableelement("Account Signatories"; "Account Signatories")
            {
                XmlName = 's';
                fieldelement(a; "Account Signatories"."Entry No")
                {
                }
                fieldelement(b; "Account Signatories"."Account No")
                {
                }
                fieldelement(c; "Account Signatories".Names)
                {
                }
                fieldelement(d; "Account Signatories"."Date Of Birth")
                {
                }
                fieldelement(e; "Account Signatories"."ID Number")
                {
                }
                fieldelement(f; "Account Signatories".Signatory)
                {
                }
                fieldelement(g; "Account Signatories"."Must Sign")
                {
                }
                fieldelement(h; "Account Signatories"."Must be Present")
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
