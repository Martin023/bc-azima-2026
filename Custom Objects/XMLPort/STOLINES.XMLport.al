#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185464 "STO LINES"
{
    Format = VariableText;

    schema
    {
        textelement(Sto)
        {
            tableelement("Standing Order Lines"; "Standing Order Lines")
            {
                XmlName = 'STOLINES';
                fieldelement(A; "Standing Order Lines"."Entry No.")
                {
                }
                fieldelement(B; "Standing Order Lines"."Document No.")
                {
                }
                fieldelement(C; "Standing Order Lines"."Destination Account Type")
                {
                }
                fieldelement(D; "Standing Order Lines"."Destination Account No.")
                {
                }
                fieldelement(F; "Standing Order Lines".Amount)
                {
                }
                fieldelement(r; "Standing Order Lines"."Loan No.")
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
