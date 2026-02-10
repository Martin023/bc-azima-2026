#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185496 "Import Salaries"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Salary Lines"; "Salary Lines")
            {
                XmlName = 'SalaryLines';
                fieldattribute(HNo; "Salary Lines"."Salary Header No.")
                {
                }
                fieldattribute(AccountNo; "Salary Lines"."Account No.")
                {
                }
                fieldattribute(StaffNo; "Salary Lines"."Staff No.")
                {
                }
                fieldattribute(MemberNo; "Salary Lines"."Member No.")
                {
                }
                fieldattribute(Amount; "Salary Lines".Amount)
                {
                }
                fieldattribute(Document_No; "Salary Lines"."Document No.")
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
