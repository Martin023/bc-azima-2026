#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185429 "Send PIN"
{
    Format = VariableText;

    schema
    {
        textelement(NME)
        {
            tableelement("Send PIN"; "Send PIN")
            {
                AutoUpdate = true;
                MinOccurs = Zero;
                XmlName = 'JOURNAL';
                fieldelement(A; "Send PIN"."Mobile No.")
                {
                }
                fieldelement(B; "Send PIN"."Account No.")
                {
                    MinOccurs = Zero;
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
