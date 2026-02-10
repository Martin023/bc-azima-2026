#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185449 savings2
{
    Format = VariableText;

    schema
    {
        textelement(Name)
        {
            tableelement("Region Delegates Tariff"; "Region Delegates Tariff")
            {
                AutoUpdate = true;
                XmlName = 'savings';
                fieldelement(a; "Region Delegates Tariff".Code)
                {
                }
                fieldelement(b; "Region Delegates Tariff".Description)
                {
                }
                fieldelement(c; "Region Delegates Tariff"."Account Type")
                {
                }
                fieldelement(d; "Region Delegates Tariff"."Account No.")
                {
                }
                fieldelement(e; "Region Delegates Tariff".Amount)
                {
                }
                fieldelement(f; "Region Delegates Tariff"."Payment Frequency")
                {
                }
                fieldelement(g; "Region Delegates Tariff"."Maximum No Paid")
                {
                }
                fieldelement(h; "Region Delegates Tariff"."Region Code")
                {
                }
                fieldelement(i; "Region Delegates Tariff"."Transaction Type")
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
