#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185521 "Import Retired Delegated"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Delegate AGM Retire Update"; "Delegate AGM Retire Update")
            {
                XmlName = 'FileMVT';
                fieldelement(a; "Delegate AGM Retire Update"."No.")
                {
                }
                fieldelement(b; "Delegate AGM Retire Update".Code)
                {
                }
                fieldelement(c; "Delegate AGM Retire Update"."Delegate MNO.")
                {
                }
                fieldelement(d; "Delegate AGM Retire Update"."Job Tittle")
                {
                }
                fieldelement(e; "Delegate AGM Retire Update"."Delegate Name")
                {
                }
                fieldelement(f; "Delegate AGM Retire Update".Position)
                {
                }
                fieldelement(g; "Delegate AGM Retire Update"."Retire Date")
                {
                }
                fieldelement(h; "Delegate AGM Retire Update"."Reason for retirement")
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
