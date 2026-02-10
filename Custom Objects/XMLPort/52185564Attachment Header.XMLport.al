xmlport 52185564 "Attachement lines"
{
    Caption = 'DMUAttachment';
    Format=VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement("Loan Recovery Lines II";"Loan Recovery Lines II")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                
                fieldelement(a; "Loan Recovery Lines II"."Header No.")
                {
                    FieldValidate=no;
                }
                fieldelement(b; "Loan Recovery Lines II"."Account No.")
                {
                    FieldValidate=no;
                }
                fieldelement(c; "Loan Recovery Lines II"."Recovery Type")
                {
                    FieldValidate=no;
                }
                fieldelement(d;"Loan Recovery Lines II"."Attached Loan Number")
                {
                    FieldValidate=no;
                }
                fieldelement(e;"Loan Recovery Lines II"."Recovery Amount")
                {
                    FieldValidate=no;
                }
                fieldelement(be;"Loan Recovery Lines II"."Member No.")
                {
                    FieldValidate=no;
                }
                fieldelement(f; "Loan Recovery Lines II"."Member Name")
                {
                    FieldValidate=no;
                }
              
                fieldelement(g; "Loan Recovery Lines II"."Loan No.")
                {
                    FieldValidate=no;
                }
                fieldelement(h;"Loan Recovery Lines II"."Opening Interest Balance")
                {
                    FieldValidate=no;
                }
                fieldelement(i;"Loan Recovery Lines II"."Original Attached Amount")
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
