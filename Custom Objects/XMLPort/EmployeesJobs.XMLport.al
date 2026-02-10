#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185438 "Employees Jobs"
{
    Format = VariableText;

    schema
    {
        textelement(ROOT)
        {
            tableelement("HR Employees"; "HR Employees")
            {
                AutoUpdate = true;
                XmlName = 'EMO';
                fieldelement(a; "HR Employees"."No.")
                {
                }
                fieldelement(b; "HR Employees".Title)
                {
                    FieldValidate = no;
                }
                fieldelement(c; "HR Employees"."First Name")
                {
                }
                fieldelement(d; "HR Employees"."Middle Name")
                {
                }
                fieldelement(e; "HR Employees"."Last Name")
                {
                }
                fieldelement(f; "HR Employees"."Full Name")
                {
                }
                fieldelement(g; "HR Employees".Grade)
                {
                }
                fieldelement(h; "HR Employees"."Department Code")
                {
                }
                fieldelement(i; "HR Employees"."Cellular Phone Number")
                {
                }
                fieldelement(j; "HR Employees"."Date Of Birth")
                {
                    FieldValidate = no;
                }
                fieldelement(k; "HR Employees"."Date Of Join")
                {
                    FieldValidate = no;
                }
                fieldelement(l; "HR Employees"."ID Number")
                {
                }
                fieldelement(m; "HR Employees".Gender)
                {
                }
                fieldelement(n; "HR Employees"."PIN No.")
                {
                }
                fieldelement(o; "HR Employees"."NSSF No.")
                {
                }
                fieldelement(p; "HR Employees"."NHIF No.")
                {
                }
                fieldelement(q; "HR Employees"."Marital Status")
                {
                }
                fieldelement(r; "HR Employees"."Ethnic Origin")
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
