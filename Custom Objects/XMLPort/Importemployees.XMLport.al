#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185472 "Import employees"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("HR Employees"; "HR Employees")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'SalaryLines';
                fieldelement(HNo; "HR Employees"."No.")
                {
                    FieldValidate = no;
                }
                fieldelement(AccountNo; "HR Employees"."First Name")
                {
                }
                fieldelement(StaffNo; "HR Employees"."Middle Name")
                {
                }
                fieldelement(IDNo; "HR Employees"."Last Name")
                {
                }
                fieldelement(r; "HR Employees"."ID Number")
                {
                    FieldValidate = no;
                }
                fieldelement(k; "HR Employees"."Date Of Birth")
                {
                    FieldValidate = no;
                }
                fieldelement(l; "HR Employees"."Date Of Join")
                {
                    FieldValidate = no;
                }
                fieldelement(Amount; "HR Employees".Gender)
                {
                }
                fieldelement(e; "HR Employees".Status)
                {
                }
                fieldelement(g; "HR Employees"."E-Mail")
                {
                }
                fieldelement(h; "HR Employees"."Payroll Posting Group")
                {
                }
                fieldelement(j; "HR Employees"."Marital Status")
                {
                }
                fieldelement(m; "HR Employees"."PIN No.")
                {
                }
                fieldelement(n; "HR Employees"."NHIF No.")
                {
                }
                fieldelement(p; "HR Employees"."NSSF No.")
                {
                }
                fieldelement(o; "HR Employees"."Global Dimension 2 Code")
                {
                }
                fieldelement(q; "HR Employees"."Global Dimension 1 Code")
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
