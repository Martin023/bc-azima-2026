#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185505 "Import Fixed Asset"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Fixed Asset"; "Fixed Asset")
            {
                XmlName = 'General';
                fieldelement(a; "Fixed Asset"."No.")
                {
                }
                fieldelement(b; "Fixed Asset".Description)
                {
                }
                fieldelement(c; "Fixed Asset"."FA Class Code")
                {
                }
                fieldelement(d; "Fixed Asset"."FA Subclass Code")
                {
                }
                fieldelement(f; "Fixed Asset"."Serial No.")
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
