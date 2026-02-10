#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185543 Creditaccount
{
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement("Credit Accounts";"Credit Accounts")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(a;"Credit Accounts"."No.")
                {
                    FieldValidate = No;
                }
                fieldelement(b;"Credit Accounts"."Product Type")
                {
                    FieldValidate=No;
                }
                fieldelement(c;"Credit Accounts"."Member No.")
                {
                    FieldValidate=No;
                }
                fieldelement(d;"Credit Accounts".Name)
                {
                    FieldValidate=no;
                }
                fieldelement(e;"Credit Accounts"."Customer Posting Group")
                {
                    FieldValidate=No;
                }
                fieldelement(f;"Credit Accounts"."Global Dimension 1 Code")
                {
                    FieldValidate=No;
                }
                fieldelement(g;"Credit Accounts"."Global Dimension 2 Code")
                {
                    FieldValidate=no;
                }
                fieldelement(i;"Credit Accounts"."Payroll/Staff No.")
                {
                    FieldValidate=no;
                }
                fieldelement(j;"Credit Accounts"."Product Name")
                {
                    FieldValidate=No;
                }
                fieldelement(k;"Credit Accounts"."Member No.")
                {
                    FieldValidate=no;
                }
                fieldelement(l;"Credit Accounts".Status)
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
        Message('Upload of credit account successful');
    end;
}
