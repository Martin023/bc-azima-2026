#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185549 PRTrans
{
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement(S;"PR Employee Transactions")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(AccNo; S."Employee Code")
                {
                    FieldValidate = No;
                }
                fieldelement(Name; S."Transaction Code")
                {
                    FieldValidate = No;
                }
                fieldelement(a; s."Payroll Period")
                {
                    FieldValidate = No;
                }
                 fieldelement(b; s."Transaction Name")
                {
                    FieldValidate = No;
                }
                 fieldelement(c; s.Amount)
                {
                    FieldValidate = No;
                }
                 fieldelement(d; s.Balance)
                {
                    FieldValidate = No;
                }
                 fieldelement(e; s."Loan Number")
                {
                    FieldValidate = No;
                }
             


            }
        }
    }
}
