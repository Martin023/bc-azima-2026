#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185487 "Update-"
{
    Format = VariableText;

    schema
    {
        textelement(Nme)
        {
            tableelement("HR Employees"; "HR Employees")
            {
                AutoReplace = true;
                MinOccurs = Zero;
                XmlName = 'updatre';
                fieldelement(a; "HR Employees"."No.")
                {
                    FieldValidate = no;
                    MinOccurs = Zero;
                }
                fieldelement(d; "HR Employees".Title)
                {
                }
                fieldelement(b; "HR Employees"."First Name")
                {
                    MinOccurs = Zero;
                }
                fieldelement(c; "HR Employees"."Middle Name")
                {
                }
                fieldelement(d; "HR Employees"."Last Name")
                {
                }
                fieldelement(e; "HR Employees"."Full Name")
                {
                }
                fieldelement(f; "HR Employees"."Job ID")
                {
                }
                fieldelement(g; "HR Employees"."Job Title")
                {
                }
                fieldelement(h; "HR Employees".Grade)
                {
                }
                fieldelement(j; "HR Employees"."Date Of Birth")
                {
                }
                fieldelement(k; "HR Employees"."Date Of Join")
                {
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
                fieldelement(q; "HR Employees"."Posting Group")
                {
                }
                fieldelement(r; "HR Employees"."Company E-Mail")
                {
                }
                fieldelement(s; "HR Employees".Status)
                {
                }
                fieldelement(u; "HR Employees"."Contract Type")
                {
                }
                fieldelement(v; "HR Employees"."Pay Period")
                {
                }
                fieldelement(w; "HR Employees"."Marital Status")
                {
                }
                fieldelement(x; "HR Employees"."Ethnic Origin")
                {
                }
                fieldelement(y; "HR Employees".Religion)
                {
                }
                fieldelement(z; "HR Employees".Citizenship)
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
