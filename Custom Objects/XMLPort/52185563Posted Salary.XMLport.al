#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185563 Postedsalary
{
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement("Salary Lines";"Salary Lines")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(a;"Salary Lines"."Salary Header No.")
                {
                    FieldValidate = No;
                }
                fieldelement(b;"Salary Lines"."No.")
                {
                    FieldValidate=No;
                }
                fieldelement(c;"Salary Lines"."Account No.")
                {
                    FieldValidate=No;
                }
                fieldelement(d;"Salary Lines"."Staff No.")
                {
                    FieldValidate=No;
                }
                fieldelement(e;"Salary Lines".Name)
                {
                    FieldValidate=No;
                }
                fieldelement(f;"Salary Lines".Amount)
                {
                    FieldValidate=No;
                }
                fieldelement(g;"Salary Lines"."ID No.")
                {
                    FieldValidate=no;
                }
                fieldelement(h;"Salary Lines"."Employer Code")
                {
                    FieldValidate=No;
                }
                fieldelement(i;"Salary Lines"."Member No.")
                {
                    FieldValidate=no;
                }
                fieldelement(j;"Salary Lines".Status)
                {
                    FieldValidate=No;
                }
                fieldelement(k;"Salary Lines".Posted)
                {
                    FieldValidate=no;
                }
                fieldelement(l;"Salary Lines"."Posting Date")
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
        Message('Members Upload completed successfully');
    end;
}