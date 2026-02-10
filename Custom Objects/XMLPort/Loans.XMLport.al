#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185452 Loans
{
    Format = VariableText;

    schema
    {
        textelement(Nme)
        {
            tableelement(Loans; Loans)
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'Loans';
                fieldelement(no; Loans."Loan No.")
                {

                }
                fieldelement(r; Loans."Loan Account")
                {
                    FieldValidate = no;
                }
                fieldelement(c; Loans."Loan Product Type")
                {
                    FieldValidate = no;
                }
                fieldelement(egr; Loans."Member No.")
                {
                    FieldValidate = no;
                }
                fieldelement(b; Loans."Application Date")
                {
                    FieldValidate = no;
                }
                fieldelement(grv; Loans."Requested Amount")
                {
                    FieldValidate = no;
                }
                fieldelement(efe; Loans."Approved Amount")
                {
                    FieldValidate = no;
                }
                fieldelement(er; Loans.Interest)
                {
                    FieldValidate = no;
                }
                fieldelement(ffd; Loans."Member Name")
                {
                    FieldValidate = no;
                }
                fieldelement(rhh; Loans.Status)
                {
                    FieldValidate = no;
                }
                fieldelement(eee; Loans.Installments)
                {
                    FieldValidate = no;
                }
                fieldelement(dd; Loans."Disbursement Date")
                {
                    FieldValidate = no;
                }
                fieldelement(jtjt; Loans."Loan Product Type Name")
                {
                    FieldValidate = no;
                }
                fieldelement(sg; Loans.Posted)
                {
                    FieldValidate = no;
                }
                fieldelement(d; Loans."Repayment Frequency")
                {
                    FieldValidate = No;
                }
                fieldelement(sf; Loans."Mode of Disbursement")
                {
                    FieldValidate = no;
                }
                fieldelement(e; Loans."Employer Code")
                {
                    FieldValidate = no;
                }
                fieldelement(gh; Loans."Staff No")
                {
                    FieldValidate = No;
                }
                fieldelement(go; Loans."Recovery Mode")
                {
                    FieldValidate = No;
                }
                fieldelement(bn; Loans."Interest Calculation Method")
                {
                    FieldValidate = No;
                }
                fieldelement(bhj; Loans.Repayment)
                {
                    FieldValidate = No;
                }
                fieldelement(dt; Loans."Approval Date")
                {
                    FieldValidate = No;
                }
                fieldelement(prd; Loans."Installment Period")
                {
                    FieldValidate = No;
                }
                fieldelement(max; Loans."Max. Installments")
                {
                    FieldValidate = No;
                }
                fieldelement(redt; Loans."Repayment Start Date")
                {
                    FieldValidate = No;
                }
                fieldelement(accno; Loans."Disbursement Account No")
                {
                    FieldValidate = No;
                }
                fieldelement(stfno; Loans."Staff No")
                {
                    FieldValidate = No;
                }
                fieldelement(source; Loans.Source)
                {
                    FieldValidate = No;
                }
                fieldelement(com; Loans."Expected Date of Completion")
                {
                    FieldValidate = No;
                }
                fieldelement(mode; Loans."Recovery Mode")
                {
                    FieldValidate = No;
                }
                fieldelement(mnt; Loans."Recommended Amount")
                {
                    FieldValidate = No;
                }
                fieldelement(centre; Loans."Responsibility Center")
                {
                    FieldValidate = No;
                }
                fieldelement(amt1; Loans."Loan Account")
                {
                    FieldValidate = No;
                }
                fieldelement(pr; Loans."Loan Principle Repayment")
                {
                    FieldValidate = No;
                }
                fieldelement(ln; Loans."Loan Interest Repayment")
                {
                    FieldValidate = No;
                }
                fieldelement(emp; Loans."Global Dimension 2 Code")
                {
                    FieldValidate = No;
                }
                fieldelement(rc; Loans."Responsibility Centre")
                {
                    FieldValidate = No;
                }
                fieldelement(idn; Loans."ID No.")
                {
                    FieldValidate = No;
                }
                fieldelement(pl; Loans."Purpose of Loan")
                {
                    FieldValidate = No;
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
