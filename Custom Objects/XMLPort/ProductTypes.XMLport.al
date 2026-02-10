#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185431 "Product Types"
{
    Format = VariableText;

    schema
    {
        textelement(Name)
        {
            tableelement("Savings Ledger Entry"; "Savings Ledger Entry")
            {
                AutoUpdate = true;
                XmlName = 'ATMS';
                fieldelement(a; "Savings Ledger Entry"."Entry No.")
                {
                }
                fieldelement(b; "Savings Ledger Entry"."Customer No.")
                {
                }
                fieldelement(c; "Savings Ledger Entry"."Posting Date")
                {
                }
                fieldelement(d; "Savings Ledger Entry"."Document No.")
                {
                }
                fieldelement(e; "Savings Ledger Entry".Description)
                {
                }
                fieldelement(f; "Savings Ledger Entry".Amount)
                {
                }
                fieldelement(g; "Savings Ledger Entry"."Customer Posting Group")
                {
                }
                fieldelement(h; "Savings Ledger Entry"."Member Name")
                {
                }
                fieldelement(i; "Savings Ledger Entry"."Member No.")
                {
                }
                fieldelement(j; "Savings Ledger Entry"."Member No.")
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
