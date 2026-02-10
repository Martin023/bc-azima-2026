#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185479 "Recruited By"
{
    Format = VariableText;
    FormatEvaluate = Xml;

    schema
    {
        textelement(root)
        {
            tableelement("HR Jobs"; "HR Jobs")
            {
                XmlName = 'recruitred';
                fieldelement(a; "HR Jobs"."Job ID")
                {
                }
                fieldelement(b; "HR Jobs"."Job Description")
                {
                }
                fieldelement(c; "HR Jobs"."Occupied Positions")
                {
                }
                fieldelement(e; "HR Jobs".Grade)
                {
                }
                fieldelement(f; "HR Jobs".Status)
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
