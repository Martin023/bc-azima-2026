#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185544 "standing order"
{
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement("Standing Order Header";"Standing Order Header")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(a;"Standing Order Header"."No.")
                {
                    FieldValidate = No;
                }
                fieldelement(b;"Standing Order Header"."Application Date")
                {
                    FieldValidate=No;
                }
                fieldelement(c;"Standing Order Header".Status)
                {
                    FieldValidate=No;
                }
                fieldelement(d;"Standing Order Header"."Source Account Type")
                {
                    FieldValidate=no;
                }
                fieldelement(e;"Standing Order Header"."Source Account No.")
                {
                    FieldValidate=no;
                }
               
                fieldelement(f;"Standing Order Header"."Source Account Name")
                {
                    FieldValidate=No;
                }
                fieldelement(g;"Standing Order Header"."Member No.")
                {
                    FieldValidate=no;
                }
                fieldelement(h;"Standing Order Header".Description)
                {
                    FieldValidate=No;
                }
                fieldelement(i;"Standing Order Header".Amount)
                {
                    FieldValidate=no;
                }
                fieldelement(j;"Standing Order Header"."Standing Order Type")
                {
                    FieldValidate=No;
                }
                fieldelement(k;"Standing Order Header"."Allow Partial Deduction")
                {
                    FieldValidate=no;
                }
                fieldelement(l;"Standing Order Header"."Income Type")
                {
                    FieldValidate=no;
                }
                fieldelement(m;"Standing Order Header"."Effective/Start Date")
                {
                    FieldValidate=no;
                }
                fieldelement(n;"Standing Order Header"."Frequency (Months)")
                {
                    FieldValidate=no;
                }
                fieldelement(o;"Standing Order Header"."Duration (Months)")
                {
                    FieldValidate=no;
                }
                fieldelement(p;"Standing Order Header"."End Date")
                {
                    FieldValidate=no;
                }
                fieldelement(q;"Standing Order Header"."Next Run Date")
                {
                    FieldValidate=no;
                }
                fieldelement(r;"Standing Order Header".Unrecovered)
                {
                    FieldValidate=no;
                }
                fieldelement(s;"Standing Order Header"."Transaction Type")
                {
                    FieldValidate=no;
                }
                fieldelement(t;"Standing Order Header"."Global Dimension 1 Code")
                {
                    FieldValidate=No;

                }
                fieldelement(u;"Standing Order Header"."Global Dimension 2 Code")
                {
                    FieldValidate=no;

                }
                fieldelement(v;"Standing Order Header"."Date Stopped")
                {
                    FieldValidate=no;
                    MinOccurs=zero;
                }
                fieldelement(w;"Standing Order Header"."Target Amount")
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
        Message('Upload of loans successful');
    end;
}
