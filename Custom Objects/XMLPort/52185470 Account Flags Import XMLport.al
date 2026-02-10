#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185470 "Account Flags"
{
    Format =VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement("Account flags"; Comments)
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(a; "Account flags"."Entry No.")
                {
                    FieldValidate = No;
                
                }
                fieldelement(b; "Account flags"."Header No.")
                {
                    FieldValidate = No;
                    
                }
                fieldelement(c; "Account flags".Comment)
                {
                    FieldValidate = No;
                    
                }
                fieldelement(d; "Account flags"."Commented By")
                {
                    FieldValidate = no;
                    
                }
                fieldelement(e; "Account flags".Date)
                {
                    FieldValidate = no;
                    
                }
                fieldelement(f;"Account flags"."Global Dimension 1 Code")
                {
                    FieldValidate = No;
                    
                }
                fieldelement(g; "Account flags"."Global Dimension 2 Code")
                {
                    FieldValidate = No;
                    
                }
                fieldelement(h; "Account flags"."Responsibility Center")
                {
                    FieldValidate = No;
                    
                }
                fieldelement(i; "Account flags".Types)
                {
                    FieldValidate = No;
                    
                }
                fieldelement(j;"Account flags"."Disable Flag")
                {
                    FieldValidate = No;
                    
                }
                fieldelement(k; "Account flags".Comment)
                {
                    FieldValidate = No;
                    
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
