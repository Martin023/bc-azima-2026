#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185468 "Delegate Trariff"
{
    Format = VariableText;

    schema
    {
        textelement(NME)
        {
            tableelement("Region Delegates Tariff"; "Region Delegates Tariff")
            {
                MinOccurs = Zero;
                XmlName = 'JOURNAL';
                fieldelement(a; "Region Delegates Tariff".Code)
                {
                }
                fieldelement(b; "Region Delegates Tariff".Description)
                {
                }
                fieldelement(c; "Region Delegates Tariff"."Region Code")
                {
                    FieldValidate = no;
                }
                fieldelement(d; "Region Delegates Tariff".Amount)
                {
                }
                fieldelement(e; "Region Delegates Tariff"."Payment Frequency")
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
