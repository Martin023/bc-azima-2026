#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185526 "Import Journal Two"
{
    Format = VariableText;

    schema
    {
        textelement(NME)
        {
            tableelement("Journal Two"; "Journal Two")
            {
                AutoUpdate = true;
                MinOccurs = Zero;
                XmlName = 'JOURNAL';
                fieldelement(A; "Journal Two"."No.")
                {
                }
                fieldelement(B; "Journal Two"."Posting Date")
                {
                }
                fieldelement(C; "Journal Two"."Document No")
                {
                }
                fieldelement(D; "Journal Two"."Accout Type")
                {
                }
                fieldelement(E; "Journal Two"."Account No")
                {
                }
                fieldelement(F; "Journal Two".Description)
                {
                }
                fieldelement(G; "Journal Two".Amount)
                {
                }
                fieldelement(h; "Journal Two"."Bal Accout Type")
                {
                }
                fieldelement(i; "Journal Two"."bal Account No")
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
