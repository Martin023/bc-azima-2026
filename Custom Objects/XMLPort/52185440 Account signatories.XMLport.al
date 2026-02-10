#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185440 "Account Signatories"
{
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement(signaatories; "Account Signatories")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(a; signaatories."Account No")
                {
                    FieldValidate = No;
                    //1
                }
                fieldelement(b; signaatories."Member No.")
                {
                    FieldValidate = No;
                    //2
                }
                fieldelement(c; signaatories.Names)
                {
                    FieldValidate = No;
                    //3
                }
                fieldelement(d; signaatories."Staff/Payroll")
                {
                    FieldValidate = no;
                    //4
                }
                fieldelement(e; signaatories."ID Number")
                {
                    FieldValidate = no;
                    //5
                }
                fieldelement(f; signaatories.Signatory)
                {
                    FieldValidate = No;
                    //6
                }
                fieldelement(g; signaatories."Must Sign")
                {
                    FieldValidate = No;
                    //7
                }
                fieldelement(h;signaatories."Must be Present")
                {
                    FieldValidate = No;
                    //8
                }
                fieldelement(i;signaatories."Expiry Date")
                {
                    FieldValidate = No;
                    //9
                }
                fieldelement(j;signaatories.Type)
                {
                    FieldValidate = No;
                    //10
                }
                fieldelement(k; signaatories.Gender)
                {
                    FieldValidate = No;
                    //11
                }
                fieldelement(l; signaatories."Phone No.")
                {
                    FieldValidate = No;
                    //12
                }
                fieldelement(m; signaatories."Account Type")
                {
                    FieldValidate = No;
                    //13
                }
                fieldelement(n;signaatories."PIN Number")
                {
                    MinOccurs=Zero;
                    FieldValidate = No;
                    //14
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
