#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185467 "Delegate Grp"
{
    Format = VariableText;

    schema
    {
        textelement(NME)
        {
            tableelement("Delegate Region"; "Delegate Region")
            {
                MinOccurs = Zero;
                XmlName = 'JOURNAL';
                fieldelement(a; "Delegate Region".Code)
                {
                }
                fieldelement(b; "Delegate Region"."Delegate Region Description")
                {
                }
                fieldelement(c; "Delegate Region"."Electoral Zone")
                {
                }
                fieldelement(d; "Delegate Region"."Electoral Zone Name")
                {
                }
                fieldelement(e; "Delegate Region"."Global Dimension 1 Code")
                {
                }
                fieldelement(f; "Delegate Region"."Global Dimension 2 Code")
                {
                    FieldValidate = no;
                }
                fieldelement(g; "Delegate Region".Status)
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
