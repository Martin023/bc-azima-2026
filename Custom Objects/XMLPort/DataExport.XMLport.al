#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185426 "Data Export"
{

    schema
    {
        textelement(NME)
        {
            tableelement("Loan Guarantors and Security"; "Loan Guarantors and Security")
            {
                AutoUpdate = true;
                MinOccurs = Zero;
                XmlName = 'JOURNAL';
                fieldelement(a; "Loan Guarantors and Security"."Loan No")
                {
                }
                fieldelement(b; "Loan Guarantors and Security"."Savings Account No./Member No.")
                {
                    FieldValidate = no;
                }
                fieldelement(c; "Loan Guarantors and Security".Name)
                {
                }
                fieldelement(d; "Loan Guarantors and Security"."Staff/Payroll No.")
                {
                    FieldValidate = no;
                }
                fieldelement(e; "Loan Guarantors and Security"."Member No")
                {
                }
                fieldelement(f; "Loan Guarantors and Security"."Member Guaranteed")
                {
                }
                fieldelement(g; "Loan Guarantors and Security"."Loanee Name")
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
