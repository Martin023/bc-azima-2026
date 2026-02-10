#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185455 "Accounts Imports-"
{
    Format = VariableText;

    schema
    {
        textelement(Nme)
        {
            tableelement("Savings Accounts"; "Savings Accounts")
            {
                AutoReplace = false;
                AutoUpdate = true;
                MinOccurs = Zero;
                XmlName = 'updatre';
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
                fieldelement(g; "Savings Accounts"."Customer Posting Group")
                {
                }
                fieldelement(h; "Savings Accounts"."Product Type")
                {
                }
                fieldelement(i; "Savings Accounts"."Product Name")
                {
                    FieldValidate = no;
                }
                fieldelement(j; "Savings Accounts"."Can Guarantee Loan")
                {
                    FieldValidate = no;
                }
                fieldelement(k; "Savings Accounts"."Loan Disbursement Account")
                {
                    FieldValidate = no;
                }
                fieldelement(l; "Savings Accounts"."Product Category")
                {
                    FieldValidate = no;
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
