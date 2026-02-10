#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185439 Sto
{
    Format = Xml;

    schema
    {
        textelement(Name)
        {
            tableelement("M-SACCO Application Details"; "M-SACCO Application Details")
            {
                AutoUpdate = true;
                XmlName = 'sto';
                fieldelement(a; "M-SACCO Application Details"."Application No")
                {
                    FieldValidate = no;
                }
                fieldelement(b; "M-SACCO Application Details"."Account Type")
                {
                    FieldValidate = no;
                }
                fieldelement(c; "M-SACCO Application Details"."Account No.")
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
