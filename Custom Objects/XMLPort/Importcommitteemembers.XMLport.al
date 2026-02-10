#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185476 "Import committee members"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("HR Commitee Members"; "HR Commitee Members")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'SalaryLines';
                fieldelement(HNo; "HR Commitee Members".Committee)
                {
                    FieldValidate = no;
                }
                fieldelement(AccountNo; "HR Commitee Members"."Member No.")
                {
                    FieldValidate = no;
                }
                fieldelement(g; "HR Commitee Members"."Member Name")
                {
                }
                fieldelement(h; "HR Commitee Members".Role)
                {
                }
                fieldelement(i; "HR Commitee Members".Active)
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
