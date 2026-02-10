xmlport 52185566 "Loans Daily Interest"
{
    Caption = 'Daily interest buffer';
    Format = VariableText;
    Direction = Export;
    schema
    {
        textelement(Name)
        {
            tableelement("Loans Interest Buffer"; "Loans Interest Buffer")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(a; "Loans Interest Buffer"."Loan No.")
                {
                    FieldValidate = no;
                }
                fieldelement(b; "Loans Interest Buffer"."Account No")
                {
                    FieldValidate = no;
                }
                fieldelement(c; "Loans Interest Buffer"."Interest Date")
                {
                    FieldValidate = no;
                }
                fieldelement(d; "Loans Interest Buffer"."Interest Amount")
                {
                    FieldValidate = no;
                }

                fieldelement(e; "Loans Interest Buffer".Posted)
                {
                    FieldValidate = no;
                }
                fieldelement(f; "Loans Interest Buffer"."Loan Product type")
                {
                    FieldValidate = no;
                }

                fieldelement(g; "Loans Interest Buffer".Status)
                {
                    FieldValidate = no;
                }
                fieldelement(h; "Loans Interest Buffer"."Outstanding Balance")
                {
                    FieldValidate = no;
                }
                fieldelement(i; "Loans Interest Buffer"."Source Unit")
                {
                    FieldValidate = no;
                }

            }
        }
    }
    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Export successful');
    end;
}
