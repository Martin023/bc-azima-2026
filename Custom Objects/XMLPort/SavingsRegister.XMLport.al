#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185518 "Savings Register"
{
    Direction = Export;
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Savings Accounts"; "Savings Accounts")
            {
                XmlName = 'Savings';
                fieldelement(a; "Savings Accounts"."No.")
                {
                }
                fieldelement(b; "Savings Accounts".Name)
                {
                }
                fieldelement(c; "Savings Accounts"."Product Type")
                {
                }
                fieldelement(d; "Savings Accounts"."Payroll/Staff No.")
                {
                }
                fieldelement(e; "Savings Accounts"."Mobile Phone No")
                {
                }
                fieldelement(f; "Savings Accounts"."Employer Code")
                {
                }
                fieldelement(g; "Savings Accounts"."Balance (LCY)")
                {
                }
                fieldelement(h; "Savings Accounts"."Member No.")
                {
                }
                fieldelement(i; "Savings Accounts".Status)
                {
                }
                fieldelement(j; "Savings Accounts".Blocked)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Members.Get("Savings Accounts"."Member No.") then begin
                        "Savings Accounts"."Employer Code" := Members."Employer Code";
                        "Savings Accounts".Name := Members.Name;
                        "Savings Accounts"."Payroll/Staff No." := Members."Payroll/Staff No.";
                        "Savings Accounts"."Mobile Phone No" := Members."Phone No.";
                    end;
                end;
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

    var
        Members: Record Members;
}
