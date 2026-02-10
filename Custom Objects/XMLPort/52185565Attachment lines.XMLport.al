xmlport 52185565 "Attachement Header"
{
    Caption = 'DMUAttachment';
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement("Loan Recovery Header II"; "Loan Recovery Header II")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';

                fieldelement(a; "Loan Recovery Header II"."No.")
                {
                    FieldValidate = no;
                }
                fieldelement(b; "Loan Recovery Header II"."Member No.")
                {
                    FieldValidate = no;
                }
                fieldelement(c; "Loan Recovery Header II".Status)
                {
                    FieldValidate = no;
                }
                fieldelement(d; "Loan Recovery Header II".Action)
                {
                    FieldValidate = no;
                }
                fieldelement(e; "Loan Recovery Header II"."Loan No.")
                {
                    FieldValidate = no;
                }
                fieldelement(be; "Loan Recovery Header II"."Interest Balance")
                {
                    FieldValidate = no;
                }
                fieldelement(f; "Loan Recovery Header II"."Principle Balance")
                {
                    FieldValidate = no;
                }

                fieldelement(g; "Loan Recovery Header II"."Total Balance")
                {
                    FieldValidate = no;
                }
                fieldelement(h; "Loan Recovery Header II"."Account Balance")
                {
                    FieldValidate = no;
                }
                fieldelement(i; "Loan Recovery Header II"."Prorated Funds")
                {
                    FieldValidate = no;
                }
                fieldelement(j; "Loan Recovery Header II"."Posting Date")
                {
                    FieldValidate = no;
                }
                fieldelement(k; "Loan Recovery Header II"."Recovery Type")
                {
                    FieldValidate = no;
                }

                fieldelement(l; "Loan Recovery Header II"."Account Number")
                {
                    FieldValidate = no;
                }

                fieldelement(m; "Loan Recovery Header II"."Header Reversed")
                {
                    FieldValidate = no;
                }
                fieldelement(n; "Loan Recovery Header II"."Global Dimension 2 Code")
                {
                    FieldValidate = no;
                }
                fieldelement(o; "Loan Recovery Header II"."Global Dimension 1 Code")
                {
                    FieldValidate = no;
                }

                fieldelement(p; "Loan Recovery Header II"."Responsibility Center")
                {
                    FieldValidate = no;
                }

                fieldelement(q; "Loan Recovery Header II"."Account Name")
                {
                    FieldValidate = no;
                }
                fieldelement(bq; "Loan Recovery Header II"."Amount in Arrears")
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
        Message('Upload of loans successful');
    end;
}
