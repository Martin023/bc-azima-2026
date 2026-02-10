#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185545 standingorderlines
{
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement("Standing Order Lines";"Standing Order Lines")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(a;"Standing Order Lines"."Document No.")
                {
                    FieldValidate = No;
                }
                fieldelement(b;"Standing Order Lines"."Destination Account Type")
                {
                    FieldValidate=No;
                }
                fieldelement(c;"Standing Order Lines"."Destination Account No.")
                {
                    FieldValidate=No;
                }
                fieldelement(d;"Standing Order Lines"."Loan No.")
                {
                    FieldValidate=no;
                }
                fieldelement(e;"Standing Order Lines"."Destination Account Name")
                {
                    FieldValidate=no;
                }
               
                fieldelement(f;"Standing Order Lines".Amount)
                {
                    FieldValidate=No;
                }
                fieldelement(g;"Standing Order Lines"."Bank Code")
                {
                    FieldValidate=no;
                }
                fieldelement(h;"Standing Order Lines"."Bank Name")
                {
                    FieldValidate=no;
                }
                fieldelement(i;"Standing Order Lines"."Bank Account No.")
                {
                    FieldValidate=no;
                }
                fieldelement(j;"Standing Order Lines"."Member No")
                {
                    FieldValidate=no;
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
