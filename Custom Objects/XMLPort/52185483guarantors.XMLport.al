#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185483 guarantors
{
    Format = VariableText;

    schema
    {
        textelement(Name)
        {
            tableelement("Loan Guarantors and Security"; "Loan Guarantors and Security")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'Guarantors';
                fieldelement(a; "Loan Guarantors and Security"."Loan No")
                {
                    FieldValidate = no;
                }
                fieldelement(b; "Loan Guarantors and Security"."Staff/Payroll No.")
                {
                    FieldValidate = no;
                }
                fieldelement(c; "Loan Guarantors and Security"."Savings Account No./Member No.")
                {
                    FieldValidate = no;
                }
                fieldelement(d; "Loan Guarantors and Security"."Collateral Reg. No.")
                {
                    FieldValidate = no;
                }
                fieldelement(e; "Loan Guarantors and Security".Name)
                {
                    FieldValidate = no;
                }
                fieldelement(f; "Loan Guarantors and Security"."Loan Balance")
                {
                    FieldValidate = no;
                }
                fieldelement(g; "Loan Guarantors and Security"."Deposits/Shares")
                {
                    FieldValidate = no;
                }
                fieldelement(h; "Loan Guarantors and Security".Substituted)
                {
                    FieldValidate = no;
                }
                fieldelement(i; "Loan Guarantors and Security"."Amount Guaranteed")
                {
                    FieldValidate = no;
                }


                fieldelement(j; "Loan Guarantors and Security"."Self Guarantee")
                {
                    FieldValidate = no;
                }


                fieldelement(k; "Loan Guarantors and Security"."ID No.")
                {
                    FieldValidate = no;
                }
                fieldelement(l; "Loan Guarantors and Security"."Member Guaranteed")
                {
                    FieldValidate = no;
                }


                fieldelement(m; "Loan Guarantors and Security"."Percentage Guaranteed")
                {
                    FieldValidate = no;
                }
                fieldelement(n; "Loan Guarantors and Security"."Member No")
                {
                    FieldValidate = no;
                }
                fieldelement(o; "Loan Guarantors and Security"."Loanee Name")
                {
                    FieldValidate = no;
                }
                fieldelement(p; "Loan Guarantors and Security"."Guarantor Type")
                {
                    FieldValidate = no;
                }
                fieldelement(q; "Loan Guarantors and Security"."No Of Major Loans Guaranteed")
                {
                    FieldValidate = no;
                }
                fieldelement(r; "Loan Guarantors and Security"."No Of Minor Loans Guaranteed")
                {
                    FieldValidate = no;
                }
                fieldelement(s; "Loan Guarantors and Security".Deceased)
                {
                    FieldValidate = no;
                }
                fieldelement(t; "Loan Guarantors and Security"."Source Unit")
                {
                    FieldValidate = no;
                    MinOccurs=Zero;
                }
               


            }
        }
    }
    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Process completed successfully');
    end;
}