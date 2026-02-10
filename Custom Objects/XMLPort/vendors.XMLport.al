#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185486 vendors
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(Vendor; Vendor)
            {
                XmlName = 'tab';
                fieldelement(a; Vendor."No.")
                {
                }
                fieldelement(b; Vendor.Name)
                {
                }
                fieldelement(c; Vendor."Vendor Posting Group")
                {
                }
                fieldelement(d; Vendor."Gen. Bus. Posting Group")
                {
                }
                fieldelement(e; Vendor."VAT Bus. Posting Group")
                {
                }
                fieldelement(f; Vendor.Status)
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
