#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185562 Dividend
{
    Format = VariableText;

    schema
    {
        textelement(DV)
        {
            tableelement("Dividend Instructions - Member";"Dividend Instructions - Member")
            {
                AutoReplace=true;
                AutoUpdate= true;
                XmlName = 'FD';
                fieldelement(a; "Dividend Instructions - Member"."Member No.")
                {
                }
                fieldelement(b; "Dividend Instructions - Member"."Account Type")
                {
                }
                fieldelement(c;"Dividend Instructions - Member"."Account No.")
                {
                    FieldValidate = No;
                }
                fieldelement(d;"Dividend Instructions - Member"."Recovery Type")
                {
                    FieldValidate = No;
                }
                fieldelement(e; "Dividend Instructions - Member".Amount)
                {
                    FieldValidate = No;
                }
                fieldelement(f;"Dividend Instructions - Member"."Product Type")
                {
                    FieldValidate = No;
                }
                fieldelement(g;"Dividend Instructions - Member".Priority)
                {
                    FieldValidate = No;
                }
                fieldelement(h;"Dividend Instructions - Member"."Recurrent Over Years")
                {
                    MinOccurs=Zero;
                    FieldValidate = No;
                }
                
           

            }
            
        }
    }
    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Processing completed successfully');
    end;
    
    
}
