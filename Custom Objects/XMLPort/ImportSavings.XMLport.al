#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185450 "Import Savings"
{
    Format = VariableText;

    schema
    {
        textelement(Name)
        {
            tableelement("Savings Accounts"; "Savings Accounts")
            {
                AutoUpdate = true;
                XmlName = 'savings';
                fieldelement(a; "Savings Accounts"."No.")
                {
                }
                fieldelement(b; "Savings Accounts"."Member No.")
                {
                    FieldValidate = no;
                }
                fieldelement(c; "Savings Accounts".Name)
                {
                }
                fieldelement(d; "Savings Accounts"."Global Dimension 1 Code")
                {
                }
                fieldelement(e; "Savings Accounts"."Global Dimension 2 Code")
                {
                }
                fieldelement(f; "Savings Accounts".Status)
                {
                }
                fieldelement(g; "Savings Accounts"."ID No.")
                {
                }
                fieldelement(h; "Savings Accounts"."Payroll/Staff No.")
                {
                }
                fieldelement(i; "Savings Accounts"."Employer Code")
                {
                }
                fieldelement(j; "Savings Accounts"."Product Type")
                {
                    FieldValidate = no;
                }
                fieldelement(l; "Savings Accounts"."Loan Disbursement Account")
                {
                }
                fieldelement(m; "Savings Accounts"."Customer Posting Group")
                {
                }
                fieldelement(n; "Savings Accounts"."Product Name")
                {
                }
                fieldelement(O; "Savings Accounts"."Product Category")
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
