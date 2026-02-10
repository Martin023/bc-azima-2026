#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185539 "M-PESA Manul Upload"
{
    Format = VariableText;

    schema
    {
        textelement(Upload)
        {
            tableelement("M-PESA Manual Upload"; "M-PESA Manual Upload")
            {
                XmlName = 'ManualUpload';
                fieldelement(a; "M-PESA Manual Upload"."Entry Code")
                {
                }
                fieldelement(b; "M-PESA Manual Upload"."Transaction ID")
                {
                }
                fieldelement(c; "M-PESA Manual Upload"."Transaction Date")
                {
                }
                fieldelement(d; "M-PESA Manual Upload".Transaction)
                {
                }
                fieldelement(e; "M-PESA Manual Upload".Description)
                {
                }
                fieldelement(f; "M-PESA Manual Upload"."Account No")
                {
                }
                fieldelement(g; "M-PESA Manual Upload".Amount)
                {
                }
                fieldelement(h; "M-PESA Manual Upload"."Phone No")
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
        Message('Done');
    end;
}
