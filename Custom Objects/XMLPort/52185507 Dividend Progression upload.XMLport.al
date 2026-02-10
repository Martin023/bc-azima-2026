#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185507 "Dividend Progression"
{
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement(Dividend;"Dividend Progression")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(a;Dividend."Account No")
                {
                    FieldValidate = No;
                }
                fieldelement(b;Dividend."Product Type")
                {
                    FieldValidate=No;
                }
                fieldelement(c;Dividend.Year)
                {
                    FieldValidate=No;
                }
                fieldelement(d;Dividend.Month)
                {
                    FieldValidate=No;
                }
                fieldelement(e;Dividend."Entry No.")
                {
                    FieldValidate=No;
                }
                fieldelement(f;Dividend."Processing Date")
                {
                    FieldValidate=No;
                }
                fieldelement(g;Dividend."Dividend Calc. Method")
                {
                    FieldValidate=no;
                }
                fieldelement(h;Dividend."Product Name")
                {
                    FieldValidate=No;
                }
                fieldelement(i;Dividend."Member No")
                {
                    FieldValidate=no;
                }
                fieldelement(j;Dividend."Qualifying Shares")
                {
                    FieldValidate=No;
                }
                fieldelement(k;Dividend."Gross Dividends")
                {
                    FieldValidate=no;
                }
                fieldelement(l;Dividend."Witholding Tax")
                {
                    FieldValidate=no;
                }
                fieldelement(m;Dividend."Net Dividends")
                {
                    FieldValidate=no;
                }
                fieldelement(n;Dividend."Start Date")
                {
                    FieldValidate=no;
                }
                fieldelement(o;Dividend."End Date")
                {
                    FieldValidate=no;
                }
                fieldelement(p;Dividend."Employer Code")
                {
                    FieldValidate=no;
                }
                fieldelement(q;Dividend.Posted)
                {
                    FieldValidate=no;
                }
                fieldelement(r;Dividend."Month Name")
                {
                    FieldValidate=no;
                }
                fieldelement(s;Dividend.Forfeited)
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