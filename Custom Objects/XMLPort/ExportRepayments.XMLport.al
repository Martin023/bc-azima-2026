#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185454 "Export Repayments"
{
    Format = VariableText;

    schema
    {
        textelement(NME)
        {
            tableelement("Credit Ledger Entry"; "Credit Ledger Entry")
            {
                MinOccurs = Zero;
                XmlName = 'JOURNAL';
                fieldelement(a; "Credit Ledger Entry"."Customer No.")
                {
                }
                fieldelement(b; "Credit Ledger Entry"."Posting Date")
                {
                }
                fieldelement(c; "Credit Ledger Entry"."Document No.")
                {
                }
                fieldelement(d; "Credit Ledger Entry".Description)
                {
                }
                fieldelement(e; "Credit Ledger Entry".Amount)
                {
                }
                fieldelement(f; "Credit Ledger Entry"."Customer Posting Group")
                {
                    FieldValidate = no;
                }
                fieldelement(g; "Credit Ledger Entry"."Transaction Type")
                {
                    FieldValidate = yes;
                }
                fieldelement(h; "Credit Ledger Entry"."Loan No")
                {
                }
                fieldelement(i; "Credit Ledger Entry"."Loan Type")
                {
                }
                fieldelement(k; "Credit Ledger Entry"."Member No.")
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
