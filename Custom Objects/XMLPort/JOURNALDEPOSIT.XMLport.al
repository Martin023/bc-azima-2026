#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185509 "JOURNAL DEPOSIT"
{
    Format = VariableText;

    schema
    {
        textelement(NME)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                MinOccurs = Zero;
                XmlName = 'JOURNAL';
                fieldelement(a; "Gen. Journal Line"."Journal Template Name")
                {
                }
                fieldelement(b; "Gen. Journal Line"."Journal Batch Name")
                {
                }
                fieldelement(c; "Gen. Journal Line"."Posting Date")
                {
                }
                fieldelement(d; "Gen. Journal Line"."Document No.")
                {
                }
                fieldelement(e; "Gen. Journal Line"."Account Type")
                {
                }
                fieldelement(f; "Gen. Journal Line"."Account No.")
                {
                }
                fieldelement(g; "Gen. Journal Line".Amount)
                {
                }
                fieldelement(h; "Gen. Journal Line".Description)
                {
                }
                fieldelement(i; "Gen. Journal Line"."Line No.")
                {
                }
                fieldelement(j; "Gen. Journal Line"."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(k; "Gen. Journal Line"."Shortcut Dimension 2 Code")
                {
                }
                fieldelement(m; "Gen. Journal Line".Description)
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
