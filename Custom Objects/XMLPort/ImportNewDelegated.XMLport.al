#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185522 "Import New Delegated"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Delegate AGM Appoint Update"; "Delegate AGM Appoint Update")
            {
                XmlName = 'FileMVT';
                fieldelement(a; "Delegate AGM Appoint Update"."No.")
                {
                }
                fieldelement(b; "Delegate AGM Appoint Update".Code)
                {
                }
                fieldelement(f; "Delegate AGM Appoint Update"."Job Tittle")
                {
                    FieldValidate = no;
                }
                fieldelement(c; "Delegate AGM Appoint Update"."Delegate MNO.")
                {
                }
                fieldelement(d; "Delegate AGM Appoint Update"."Delegate Name")
                {
                }
                fieldelement(e; "Delegate AGM Appoint Update".Position)
                {
                }
                fieldelement(g; "Delegate AGM Appoint Update"."Appointment Date")
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

    trigger OnPostXmlPort()
    begin
        Message('DONE!!!');
    end;
}
