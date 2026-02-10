#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185999 "Import Salaries P"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Salary Lines P"; "Salary Lines P")
            {
                XmlName = 'SalaryLines';
                fieldattribute(HNo; "Salary Lines P"."Salary Header No.")
                {
                }
                fieldattribute(AccountNo; "Salary Lines P"."Account No.")
                {
                }
                fieldattribute(StaffNo; "Salary Lines P"."Staff No.")
                {
                }
                fieldattribute(IDNo; "Salary Lines P"."ID No.")
                {
                }
                fieldattribute(Amount; "Salary Lines P".Amount)
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
