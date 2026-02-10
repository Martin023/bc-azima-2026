#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185447 Segments
{
    Format = VariableText;

    schema
    {
        textelement(Name)
        {
            tableelement("Segment/County/Dividend/Signat"; "Segment/County/Dividend/Signat")
            {
                XmlName = 'Segment';
                fieldelement(a; "Segment/County/Dividend/Signat".Type)
                {
                }
                fieldelement(b; "Segment/County/Dividend/Signat".Code)
                {
                }
                fieldelement(c; "Segment/County/Dividend/Signat".Description)
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
