#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185516 "Export Guarantors"
{
    Direction = Export;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Loan Guarantors and Security"; "Loan Guarantors and Security")
            {
                AutoUpdate = false;
                // RequestFilterFields = Field1, Field2, Field16, Field14, Field7;
                XmlName = 'Guarantors';
                fieldelement(a; "Loan Guarantors and Security"."Loan No")
                {
                }
                fieldelement(b; "Loan Guarantors and Security"."Savings Account No./Member No.")
                {
                }
                fieldelement(c; "Loan Guarantors and Security".Name)
                {
                }
                fieldelement(d; "Loan Guarantors and Security".Substituted)
                {
                }
                fieldelement(e; "Loan Guarantors and Security".Date)
                {
                }
                fieldelement(f; "Loan Guarantors and Security"."Amount Guaranteed")
                {
                }
                fieldelement(g; "Loan Guarantors and Security"."Staff/Payroll No.")
                {
                }
                fieldelement(h; "Loan Guarantors and Security"."Account No.")
                {
                }
                fieldelement(i; "Loan Guarantors and Security"."Self Guarantee")
                {
                }
                fieldelement(j; "Loan Guarantors and Security"."ID No.")
                {
                }
                fieldelement(k; "Loan Guarantors and Security"."Outstanding Balance")
                {
                }
                fieldelement(l; "Loan Guarantors and Security"."Member Guaranteed")
                {
                }
                fieldelement(m; "Loan Guarantors and Security"."Total Guaranteed")
                {
                }
                fieldelement(n; "Loan Guarantors and Security"."Member No")
                {
                }
                fieldelement(o; "Loan Guarantors and Security"."Loan Type")
                {
                }
                fieldelement(p; "Loan Guarantors and Security"."Guarantor Type")
                {
                }
                fieldelement(q; "Loan Guarantors and Security"."Collateral Reg. No.")
                {
                }
                fieldelement(r; "Loan Guarantors and Security"."Collateral Value")
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
