#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185561 FDcontract
{
    Format = VariableText;

    schema
    {
        textelement(FD)
        {
            tableelement("Fixed Deposit Contract";"Fixed Deposit Contract")
            {
                AutoReplace=true;
                AutoUpdate= true;
                XmlName = 'FD';
                fieldelement(a; "Fixed Deposit Contract"."No.")
                {
                    FieldValidate=no;
                }
                fieldelement(b; "Fixed Deposit Contract".Name)
                {
                    FieldValidate=no;
                }
                fieldelement(c;"Fixed Deposit Contract"."Global Dimension 1 Code")
                {
                    FieldValidate = No;
                }
                fieldelement(d;"Fixed Deposit Contract"."Global Dimension 2 Code")
                {
                    FieldValidate = No;
                }
                fieldelement(e; "Fixed Deposit Contract"."Member No.")
                {
                    FieldValidate = No;
                }
                fieldelement(f; "Fixed Deposit Contract"."Responsibility Center")
                {
                    FieldValidate = No;
                }
                fieldelement(g; "Fixed Deposit Contract".Status)
                {
                    FieldValidate = no;
                }
                fieldelement(h;"Fixed Deposit Contract"."Payroll/Staff No.")
                {
                    FieldValidate = No;
                }
                fieldelement(i;"Fixed Deposit Contract"."ID No.")
                {
                    FieldValidate = No;
                }
                fieldelement(j;"Fixed Deposit Contract"."Product Type")
                {
                    FieldValidate = No;
                }
                fieldelement(k;"Fixed Deposit Contract"."Fixed Deposit Status")
                {
                    FieldValidate = No;
                }
                fieldelement(l; "Fixed Deposit Contract"."Registration Date")
                {
                    FieldValidate = No;
                }
                fieldelement(m; "Fixed Deposit Contract"."Expected Maturity Date")
                {
                    FieldValidate = No;
                }
                fieldelement(n;"Fixed Deposit Contract"."Fixed Deposit Account No.")
                {
                    FieldValidate = No;
                }
                fieldelement(o; "Fixed Deposit Contract"."Fixed Deposit Type")
                {
                    FieldValidate = No;
                }  
                fieldelement(p; "Fixed Deposit Contract"."FD Maturity Date")
                {
                    FieldValidate = No;
                }
                fieldelement(q; "Fixed Deposit Contract"."Neg. Interest Rate")
                {
                    FieldValidate = No;
                }
                fieldelement(r;"Fixed Deposit Contract"."FD Duration")
                {
                    FieldValidate = No;
                }
                fieldelement(s; "Fixed Deposit Contract"."FD Maturity Instructions")
                {
                    FieldValidate = No;
                } 
                fieldelement(t; "Fixed Deposit Contract"."Application Date")
                {
                    FieldValidate = No;
                }
                fieldelement(u; "Fixed Deposit Contract"."Fixed Deposit Amount")
                {
                    FieldValidate = No;
                }
                fieldelement(v;"Fixed Deposit Contract"."Product Category")
                {
                    FieldValidate=No;
                }
                  fieldelement(w;"Fixed Deposit Contract"."FOSA Main Account No.")
                {
                    MinOccurs=zero;
                    FieldValidate=No;
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
