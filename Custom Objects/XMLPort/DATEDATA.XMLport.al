#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185471 "DATE DATA"
{
    Format = VariableText;

    schema
    {
        textelement(TTU)
        {
            tableelement("Loan Product Charges"; "Loan Product Charges")
            {
                XmlName = 'TMP';
                fieldelement(A; "Loan Product Charges"."Charge Code")
                {
                }
                fieldelement(B; "Loan Product Charges"."Charge Description")
                {
                }
                fieldelement(C; "Loan Product Charges"."Use Percentage")
                {
                }
                fieldelement(e; "Loan Product Charges".Percentage)
                {
                }
                fieldelement(f; "Loan Product Charges"."Charge Type")
                {
                }
                fieldelement(g; "Loan Product Charges"."Charging Option")
                {
                }
                fieldelement(h; "Loan Product Charges"."Product Code")
                {
                }
                fieldelement(i; "Loan Product Charges"."Charges G_L Account")
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
