#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185519 "Member Register"
{
    Direction = Export;
    Format = VariableText;

    schema
    {
        textelement(meb)
        {
            tableelement(Members; Members)
            {
                XmlName = 'Member';
                fieldelement(a; Members."No.")
                {
                }
                fieldelement(b; Members.Name)
                {
                }
                fieldelement(c; Members."Payroll/Staff No.")
                {
                }
                fieldelement(d; Members.Status)
                {
                }
                fieldelement(e; Members."Registration Date")
                {
                }
                fieldelement(f; Members."Rejoinig Date")
                {
                }
                fieldelement(g; Members."Employer Code")
                {
                }
                fieldelement(h; Members."Primary Identification")
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
