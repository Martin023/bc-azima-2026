#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185457 "Savings Account Export"
{
    Direction = Export;
    Format = VariableText;

    schema
    {
        textelement(Name)
        {
            tableelement("Savings Accounts"; "Savings Accounts")
            {
                AutoReplace = false;
                AutoUpdate = false;
                // RequestFilterFields = Field41, Field58, Field21, Field18;
                XmlName = 'No';
                fieldelement(a; "Savings Accounts"."No.")
                {
                    FieldValidate = no;
                }
                fieldelement(b; "Savings Accounts"."Member No.")
                {
                    FieldValidate = no;
                }
                fieldelement(c; "Savings Accounts"."Payroll/Staff No.")
                {
                }
                fieldelement(EmpCode; "Savings Accounts"."Employer Code")
                {
                }
                fieldelement(d; "Savings Accounts".Name)
                {
                }
                fieldelement(e; "Savings Accounts"."Global Dimension 1 Code")
                {
                }
                fieldelement(f; "Savings Accounts"."Global Dimension 2 Code")
                {
                    FieldValidate = no;
                }
                fieldelement(h; "Savings Accounts"."Product Type")
                {
                }
                fieldelement(i; "Savings Accounts"."Product Name")
                {
                    FieldValidate = no;
                }
                fieldelement(Balance; "Savings Accounts"."Balance (LCY)")
                {
                }
                fieldelement(Status; "Savings Accounts".Status)
                {
                }
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }
}
