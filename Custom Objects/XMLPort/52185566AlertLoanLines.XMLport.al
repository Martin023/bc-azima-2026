xmlport 52185568 "Alerts Loan Lines"
{
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement("Alerts Loan Lines"; "Alerts Loan Lines")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';

                fieldelement(a; "Alerts Loan Lines"."Header No.")
                {
                    FieldValidate = no;
                }
                fieldelement(b; "Alerts Loan Lines"."Loan No.")
                {
                    FieldValidate = yes;
                }
                fieldelement(c; "Alerts Loan Lines".Period)
                {

                }
                fieldelement(d; "Alerts Loan Lines"."Process Case")
                {

                }
            }
        }
    }
    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Upload of loans successful');
    end;
}
