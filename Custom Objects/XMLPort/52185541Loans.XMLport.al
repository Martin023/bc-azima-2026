#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185541 "Loans migration"
{
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement(Loan; Loans)
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(a; Loan."Loan No.")
                {
                    FieldValidate = No;
                    //1
                }
                fieldelement(b; Loan."Application Date")
                {
                    FieldValidate = No;
                    //2
                }
                fieldelement(c; Loan."Loan Product Type")
                {
                    FieldValidate = No;
                    //3
                }
                fieldelement(d; Loan."Member No.")
                {
                    FieldValidate = no;
                    //4
                }
                fieldelement(e; loan."Requested Amount")
                {
                    FieldValidate = no;
                    //5
                }
                fieldelement(f; Loan."Approved Amount")
                {
                    FieldValidate = No;
                    //6
                }
                fieldelement(g; Loan.Interest)
                {
                    FieldValidate = No;
                    //7
                }
                fieldelement(h; Loan."Member Name")
                {
                    FieldValidate = No;
                    //8
                }
                fieldelement(i; Loan."Approval Date")
                {
                    FieldValidate = No;
                    //9
                }
                fieldelement(j; Loan.Installments)
                {
                    FieldValidate = No;
                    //10
                }
                fieldelement(k; Loan."Disbursement Date")
                {
                    FieldValidate = No;
                    //11
                }
                fieldelement(l; Loan."Installment Period")
                {
                    FieldValidate = No;
                    //12
                }
                fieldelement(m; Loan.Repayment)
                {
                    FieldValidate = No;
                    //13
                }
                fieldelement(n; Loan."Loan Product Type Name")
                {
                    FieldValidate = No;
                    //14
                }
                fieldelement(o; Loan.Posted)
                {
                    FieldValidate = no;
                    //15
                }
                fieldelement(p; Loan."Amount To Disburse")
                {
                    FieldValidate = no;
                    //16
                }
                fieldelement(q; Loan."Loan Rescheduled")
                {
                    FieldValidate = no;
                    //17
                }
                fieldelement(r; Loan."Date Rescheduled")
                {
                    FieldValidate = no;
                    //18
                }
                fieldelement(s; Loan."Interest Calculation Method")
                {
                    FieldValidate = no;
                    //19
                }
                fieldelement(t; Loan."Repayment Start Date")
                {
                    FieldValidate = no;
                    //20
                }
                fieldelement(u; Loan."Disbursement Account No")
                {
                    FieldValidate = no;
                    //21
                }
                fieldelement(v; Loan."Staff No")
                {
                    FieldValidate = no;
                    //22
                }
                fieldelement(w; Loan.Defaulted)
                {
                    FieldValidate = no;
                    //23
                }
                fieldelement(x; Loan."Expected Date of Completion")
                {
                    FieldValidate = no;
                    //24
                }
                fieldelement(y; Loan."Recovery Mode")
                {
                    FieldValidate = no;
                    //25
                }
                fieldelement(z; Loan."Repayment Frequency")
                {
                    FieldValidate = no;
                    //26
                }
                fieldelement(aa; Loan.Status)
                {
                    FieldValidate = no;
                    //27
                }
                fieldelement(ab; Loan."Responsibility Center")
                {
                    FieldValidate = no;
                    //28
                }
                fieldelement(ac; Loan."Loan Span")
                {
                    FieldValidate = no;
                    //29              
                }
                fieldelement(ad; Loan."Loan Principle Repayment")
                {
                    FieldValidate = no;
                    //30
                }
                fieldelement(ae; Loan."Loan Interest Repayment")
                {
                    FieldValidate = no;
                    //31               
                }
                fieldelement(af; Loan."Employer Code")
                {
                    FieldValidate = no;
                    //32
                }
                fieldelement(ag; Loan."Global Dimension 1 Code")
                {
                    FieldValidate = no;
                    //33               
                }
                fieldelement(ah; Loan."Global Dimension 2 Code")
                {
                    FieldValidate = no;
                    //34
                }
                fieldelement(ai; Loan."Recovered Loan")
                {
                    FieldValidate = No;
                    //35
                }
                fieldelement(aj; Loan."Recovery Priority")
                {
                    FieldValidate = No;
                    //36
                }
                fieldelement(ak; Loan."Mortgage Loan")
                {
                    FieldValidate = no;
                    //37
                }
                fieldelement(al; Loan."Source Unit")
                {
                    FieldValidate = No;
                    //38
                }
                fieldelement(am; Loan."Appraisal Parameter Type")
                {
                    FieldValidate = No;
                    //39
                }
                fieldelement(an; Loan."Tpay Approved")
                {
                    FieldValidate = No;
                    //40
                }
                fieldelement(ao; Loan."Purpose of Loan")
                {
                    FieldValidate = no;
                    //41
                }
                fieldelement(ap; loan."Main Sector")
                {
                    FieldValidate = no;
                    //42
                }
                fieldelement(aq; Loan."Main Sector Description")
                {
                    FieldValidate = No;
                    //43
                }
                fieldelement(ar; Loan."Sub Sector Level1")
                {
                    FieldValidate = No;
                    //44
                }
                fieldelement(as; Loan."Sub Sector Level1 Description")
                {
                    FieldValidate = No;
                    //45
                }
                fieldelement(at; Loan."Sub Sector Level2")
                {
                    FieldValidate = No;
                    //46
                }
                fieldelement(au; Loan."Sub Sector Level2 Description")
                {
                    FieldValidate = No;
                    //47
                }
                fieldelement(av; Loan."Prorata Amount")
                {
                    FieldValidate = No;
                    //48
                }
                fieldelement(aw; Loan."Compute Interest Due on Postin")
                {
                    FieldValidate = No;
                    //49
                }
                fieldelement(ax; Loan."Relation Officer")
                {
                    FieldValidate = No;
                    //50
                }
                fieldelement(ay; Loan."Loan Account")
                {
                    FieldValidate = No;
                    //51
                }


            }
        }
    }

    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Process completed successful');
    end;
}
