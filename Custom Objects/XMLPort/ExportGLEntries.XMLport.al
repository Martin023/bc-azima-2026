#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185433 "Export GL Entries"
{
    Direction = Export;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Dividend Posting Buffer"; "Dividend Posting Buffer")
            {
                XmlName = 'GlEntries';
                fieldelement(a; "Dividend Posting Buffer"."Entry No.")
                {
                }
                fieldelement(b; "Dividend Posting Buffer"."Posting Date")
                {
                }
                fieldelement(c; "Dividend Posting Buffer"."Document No.")
                {
                }
                fieldelement(d; "Dividend Posting Buffer"."Account Type")
                {
                }
                fieldelement(e; "Dividend Posting Buffer"."Account No.")
                {
                }
                fieldelement(f; "Dividend Posting Buffer".Description)
                {
                }
                fieldelement(g; "Dividend Posting Buffer"."Member No.")
                {
                }
                fieldelement(h; "Dividend Posting Buffer".Amount)
                {
                }
                fieldelement(i; "Dividend Posting Buffer"."Bal. Account Type")
                {
                }
                fieldelement(j; "Dividend Posting Buffer"."Bal. Account No.")
                {
                }
                fieldelement(l; "Dividend Posting Buffer".Posted)
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
