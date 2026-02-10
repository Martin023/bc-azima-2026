#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185432 "Member Loans"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(Members; Members)
            {
                AutoReplace = true;
                XmlName = 'tabel';
                fieldelement(a; Members."No.")
                {
                }
                fieldelement(b; Members."First Name")
                {
                }
                fieldelement(c; Members."Middle Name")
                {
                }
                fieldelement(d; Members."Other Names")
                {
                }
                fieldelement(e; Members.Name)
                {
                }
                fieldelement(f; Members."Primary Identification")
                {
                }
                fieldelement(g; Members."Employer Code")
                {
                }
                fieldelement(h; Members."Payroll/Staff No.")
                {
                }
                fieldelement(i; Members.Gender)
                {
                }
                fieldelement(j; Members."Marital Status")
                {
                }
                fieldelement(k; Members."Date of Birth")
                {
                }
                fieldelement(l; Members."Registration Date")
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
