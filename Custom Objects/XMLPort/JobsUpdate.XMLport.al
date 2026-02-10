#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185437 "Jobs Update"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("M-SACCO Applications"; "M-SACCO Applications")
            {
                AutoUpdate = true;
                XmlName = 'job';
                fieldelement(id; "M-SACCO Applications".No)
                {
                }
                fieldelement(F; "M-SACCO Applications"."Date Entered")
                {
                    FieldValidate = no;
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
