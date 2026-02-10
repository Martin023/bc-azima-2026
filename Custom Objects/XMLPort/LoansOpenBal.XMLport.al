#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185517 "Loans Open Bal"
{
    Direction = Export;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Loans; Loans)
            {
                // RequestFilterFields = Field3, Field64;
                XmlName = 'CashierTrans';
                fieldelement(a; Loans."Loan No.")
                {
                }
                fieldelement(u; Loans."Application Date")
                {
                }
                fieldelement(b; Loans."Member No.")
                {
                }
                fieldelement(c; Loans."Staff No")
                {
                }
                fieldelement(d; Loans."Member Name")
                {
                }
                fieldelement(n; Loans."Employer Code")
                {
                }
                fieldelement(e; Loans."Loan Product Type")
                {
                }
                fieldelement(k; Loans."Requested Amount")
                {
                }
                fieldelement(f; Loans."Approved Amount")
                {
                }
                fieldelement(s; Loans."Repayment Start Date")
                {
                }
                fieldelement(l; Loans.Interest)
                {
                }
                fieldelement(m; Loans.Installments)
                {
                }
                fieldelement(p; Loans.Repayment)
                {
                }
                fieldelement(q; Loans."Loan Principle Repayment")
                {
                }
                fieldelement(r; Loans."Loan Interest Repayment")
                {
                }
                fieldelement(h; Loans."Outstanding Balance")
                {
                }
                fieldelement(i; Loans."Outstanding Interest")
                {
                }
                fieldelement(o; Loans."Loans Category-SASRA")
                {
                }
                textelement(arrears)
                {
                    XmlName = 'p';
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
