#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185539 "M-PESA Manul Upload"
{
    Format = VariableText;

    schema
    {
        textelement(Upload)
        {
            tableelement("M-PESA Manual Upload"; "Sky M-Banking Trans. Buffer")
            {
                XmlName = 'ManualUpload';
                fieldelement(a; "M-PESA Manual Upload"."No.")
                {
                }
                fieldelement(b; "M-PESA Manual Upload"."Originator ID")
                {
                }
                fieldelement(c; "M-PESA Manual Upload"."Transaction Type")
                {
                }
                fieldelement(d; "M-PESA Manual Upload"."Transaction Status")
                {
                }
                fieldelement(e; "M-PESA Manual Upload"."Beneficiary Reference")
                {
                }
                fieldelement(f; "M-PESA Manual Upload"."Savings Account")
                {
                }
                fieldelement(g; "M-PESA Manual Upload"."Transaction Amount")
                {
                }
                fieldelement(h; "M-PESA Manual Upload"."Transaction Description")
                {
                }
                fieldelement(h; "M-PESA Manual Upload"."PESA Type")
                {
                }
                fieldelement(h; "M-PESA Manual Upload"."Transaction Category")
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
