#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185475 "Import employeenxt  of kin"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("HR Employee Kin"; "HR Employee Kin")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'SalaryLines';
                fieldelement(HNo; "HR Employee Kin"."Employee Code")
                {
                    FieldValidate = no;
                }
                fieldelement(AccountNo; "HR Employee Kin"."Other Names")
                {
                }
                fieldelement(d; "HR Employee Kin".Relationship)
                {
                }
                fieldelement(e; "HR Employee Kin"."Date Of Birth")
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
