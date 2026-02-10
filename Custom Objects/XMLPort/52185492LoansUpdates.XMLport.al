#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185492 "LoansUp migration"
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
                fieldelement(b; Loan."Prorata Amount")
                {
                    FieldValidate = No;
                    //2
                }
                fieldelement(c; Loan."Member No.")
                {
                    FieldValidate = No;
                    //2
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
