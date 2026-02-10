#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185536 "Import Member From Legacy"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(ImportMember)
        {
            tableelement(Members; Members)
            {
                XmlName = 'Members';
                fieldelement(a; Members."No.")
                {
                }
                fieldelement(b; Members."Payroll/Staff No.")
                {
                }
                fieldelement(c; Members.Salutation)
                {
                }
                fieldelement(d; Members."First Name")
                {
                }
                fieldelement(e; Members."Middle Name")
                {
                }
                fieldelement(f; Members."Other Names")
                {
                }
                fieldelement(g; Members.Name)
                {
                }
                fieldelement(h; Members."Phone No.")
                {
                }
                fieldelement(i; Members."Phone No.")
                {
                }
                fieldelement(j; Members."Employer Code")
                {
                }
                fieldelement(k; Members."Employer Name")
                {
                }
                fieldelement(l; Members.Status)
                {
                }
                fieldelement(m; Members."Primary Identification")
                {
                }
                fieldelement(n; Members."Date of Birth")
                {
                }
                fieldelement(o; Members."Registration Date")
                {
                }
                fieldelement(p; Members.Gender)
                {
                }
                fieldelement(q; Members."Member Class")
                {
                }
                fieldelement(r; Members."Global Dimension 2 Code")
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
