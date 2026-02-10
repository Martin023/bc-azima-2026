xmlport 52185552 earningsdeductions
{
    Caption = 'EmployeeDeduction';
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement("PR Employee Transactions"; "PR Employee Transactions")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';

                fieldelement(a; "PR Employee Transactions"."Employee Code")
                {
                    FieldValidate = no;
                }
                fieldelement(b; "PR Employee Transactions"."Transaction Code")
                {
                    FieldValidate = no;
                }
                fieldelement(c; "PR Employee Transactions"."Period Month")
                {
                    FieldValidate = no;
                }
                fieldelement(d; "PR Employee Transactions"."Period Year")
                {
                    fieldvalidate = no;
                }

                fieldelement(e; "PR Employee Transactions"."Payroll Period")
                {
                    fieldvalidate = no;
                }
                fieldelement(f; "PR Employee Transactions"."Transaction Name")
                {
                    FieldValidate = no;
                }
                fieldelement(g; "PR Employee Transactions"."Amount")
                {
                    FieldValidate = no;
                }
                fieldelement(h; "PR Employee Transactions".Balance)
                {
                    FieldValidate = no;
                }
                fieldelement(i; "PR Employee Transactions"."Original Amount")
                {
                    FieldValidate = no;
                }
                fieldelement(j; "PR Employee Transactions"."Stop for Next Period")
                {
                    FieldValidate = no;
                }
                fieldelement(k; "PR Employee Transactions"."Start Date")
                {
                    FieldValidate = no;
                }
                fieldelement(l; "PR Employee Transactions"."End Date")
                {
                    FieldValidate = no;
                }

                fieldelement(m; "PR Employee Transactions"."Loan Number")
                {
                    FieldValidate = no;
                }
                fieldelement(n; "PR Employee Transactions"."Loan Interest Rate")
                {
                    FieldValidate = no;
                }
                fieldelement(o; "PR Employee Transactions"."Variated")
                {
                    FieldValidate = no;
                }
                fieldelement(p; "PR Employee Transactions"."Salary Grade")
                {
                    FieldValidate = no;
                    MinOccurs=zero;
                }
                fieldelement(q; "PR Employee Transactions".Frequency)
                {
                    FieldValidate = no;
                    MinOccurs=zero;
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

