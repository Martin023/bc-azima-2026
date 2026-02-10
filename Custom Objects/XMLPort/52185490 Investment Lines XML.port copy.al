#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185490 "Investment Lines"
{
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement("Investment Lines";"Investment Lines")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(a;"Investment Lines"."Investment No")
                {
                    FieldValidate = No;
                }
                fieldelement(b;"Investment Lines"."Line No.")
                {
                    FieldValidate=No;
                }
                fieldelement(c;"Investment Lines".Institution)
                {
                    FieldValidate=No;
                }
                fieldelement(d;"Investment Lines"."Investment Amount")
                {
                    FieldValidate=No;
                }
                fieldelement(e;"Investment Lines"."Face Value")
                {
                    FieldValidate=No;
                }
                fieldelement(f;"Investment Lines"."Interest Amount")
                {
                    FieldValidate=No;
                }
                fieldelement(g;"Investment Lines"."Net Interest Amount")
                {
                    FieldValidate=no;
                }
                fieldelement(h;"Investment Lines"."Invested Amount")
                {
                    FieldValidate=no;
                    MinOccurs=zero;
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