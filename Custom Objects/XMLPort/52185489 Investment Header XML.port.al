#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185489 "Investment Header"
{
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement(InvestHd;"Investment Header")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(a;InvestHd."Investment No")
                {
                    FieldValidate = No;
                }
                fieldelement(b;InvestHd."Investment Type Code")
                {
                    FieldValidate=No;
                }
                fieldelement(c;InvestHd."Investment Type Description")
                {
                    FieldValidate=No;
                }
                fieldelement(d;InvestHd.Status)
                {
                    FieldValidate=No;
                }
                fieldelement(e;InvestHd."Responsibility Center")
                {
                    FieldValidate=No;
                }
                fieldelement(f;InvestHd."Asset Type")
                {
                    FieldValidate=No;
                }
                fieldelement(g;InvestHd."Transaction Date")
                {
                    FieldValidate=no;
                }
                fieldelement(h;InvestHd."Institution Name")
                {
                    FieldValidate=No;
                }
                fieldelement(i;InvestHd."Investment Date")
                {
                    FieldValidate=no;
                }
                fieldelement(j;InvestHd."Interest Rate")
                {
                    FieldValidate=No;
                }
                fieldelement(k;InvestHd."Deposit Type")
                {
                    FieldValidate=no;
                }
                fieldelement(l;InvestHd."Period Type")
                {
                    FieldValidate=no;
                }
                fieldelement(m;InvestHd."Frequency Period")
                {
                    FieldValidate=no;
                }
                fieldelement(n;InvestHd."Available Amount")
                {
                    FieldValidate=no;
                }
                fieldelement(o;InvestHd."Vendor Credit Limit(LCY)")
                {
                    FieldValidate=no;
                }
                fieldelement(p;InvestHd.Posted)
                {
                    FieldValidate=no;
                }
                fieldelement(q;InvestHd."Accrued Interest G/L Acc")
                {
                    FieldValidate=no;
                }
                fieldelement(r;InvestHd."Interest Income G/L Acc")
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