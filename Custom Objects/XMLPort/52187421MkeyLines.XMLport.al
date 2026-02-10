#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52187421 "Mkey Lines"
{
    Format = VariableText;

    schema
    {
        textelement(a)
        {
            tableelement("MKey Lines"; "MKey Lines")
            {
                AutoReplace = true;
                XmlName = 'b';
                fieldelement(a; "MKey Lines"."Header No.")
                {
                    FieldValidate = no;
                }
                fieldelement(b; "MKey Lines"."Member No. ")
                {
                }
                fieldelement(c; "MKey Lines"."Old Employer Code")
                {
                    FieldValidate = no;
                }
                fieldelement(d; "MKey Lines"."New Employer Code")
                {
                }
                fieldelement(e; "MKey Lines"."New Payroll Number")
                {
                }
                fieldelement(f; "MKey Lines"."New Payroll Number")
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
