#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185488 "lien Placed"
{
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement(Lien;"Cashier Transactions")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(a;Lien.No)
                {
                    FieldValidate = No;
                }
                fieldelement(b;Lien."Account No")
                {
                    FieldValidate=No;
                }
                fieldelement(c;Lien."Account Name")
                {
                    FieldValidate=No;
                }
                fieldelement(d;Lien."Transaction Type")
                {
                    FieldValidate=No;
                }
                fieldelement(e;Lien.Amount)
                {
                    FieldValidate=No;
                }
                fieldelement(f;Lien."Transaction Date")
                {
                    FieldValidate=No;
                }
                fieldelement(g;Lien."Transaction Time")
                {
                    FieldValidate=no;
                }
                fieldelement(h;Lien.Posted)
                {
                    FieldValidate=No;
                }
                fieldelement(i;Lien."Product Type")
                {
                    FieldValidate=no;
                }
                fieldelement(j;lien.Remarks)
                {
                    FieldValidate=No;
                }
                fieldelement(k;lien.Type)
                {
                    FieldValidate=no;
                }
                fieldelement(l;Lien."Transaction Description")
                {
                    FieldValidate=no;
                }
                fieldelement(m;Lien."Post Dated")
                {
                    FieldValidate=no;
                }
                fieldelement(n;lien."Book Balance")
                {
                    FieldValidate=no;
                }
                fieldelement(o;Lien."Member No.")
                {
                    FieldValidate=no;
                }
                fieldelement(p;lien."ID No")
                {
                    FieldValidate=no;
                }
                fieldelement(q;lien."Available Balance")
                {
                    FieldValidate=no;
                }
                fieldelement(r;Lien."Global Dimension 1 Code")
                {
                    FieldValidate=no;
                }
                fieldelement(s;lien."Global Dimension 2 Code")
                {
                    FieldValidate=no;
                }
                fieldelement(t;Lien."Product Category")
                {
                    FieldValidate=No;

                }
                fieldelement(u;Lien."New Account Balance")
                {
                    FieldValidate=no;

                }
                fieldelement(v;Lien."Blockage Reason")
                {
                    FieldValidate=no;
                     MinOccurs=zero;
                }
                fieldelement(w;lien."Other Reason")
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