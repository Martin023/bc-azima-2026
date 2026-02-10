#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185506 "Import employee transactions1"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("PR Employee Transactions"; "PR Employee Transactions")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'SalaryLines';
                fieldelement(e; "PR Employee Transactions"."Employee Code")
                {
                }
                fieldelement(HNo; "PR Employee Transactions"."Transaction Code")
                {
                    FieldValidate = no;
                }
                fieldelement(g; "PR Employee Transactions"."Period Month")
                {
                }
                fieldelement(n; "PR Employee Transactions"."Period Year")
                {
                }
                fieldelement(d; "PR Employee Transactions"."Payroll Period")
                {
                }
                fieldelement(tg; "PR Employee Transactions"."Loan Number")
                {
                }
                fieldelement(ty; "PR Employee Transactions"."Loan Interest Rate")
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

    trigger OnPostXmlPort()
    begin
        Message('Salary Uploaded Successfuly');
    end;
}
