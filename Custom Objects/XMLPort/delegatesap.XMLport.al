#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185484 "delegates ap"
{
    Format = VariableText;

    schema
    {
        textelement(Name)
        {
            tableelement("PR Transaction Codes"; "PR Transaction Codes")
            {
                AutoReplace = true;
                AutoUpdate = false;
                XmlName = 'Guarantors';
                fieldattribute(a; "PR Transaction Codes"."Transaction Code")
                {
                    FieldValidate = no;
                }
                fieldattribute(b; "PR Transaction Codes"."Transaction Name")
                {
                }
                fieldattribute(c; "PR Transaction Codes"."Balance Type")
                {
                    FieldValidate = no;
                }
                fieldattribute(d; "PR Transaction Codes"."Transaction Type")
                {
                    FieldValidate = no;
                }
                fieldattribute(e; "PR Transaction Codes".Frequency)
                {
                }
                fieldattribute(f; "PR Transaction Codes".Taxable)
                {
                    FieldValidate = no;
                }
                fieldattribute(g; "PR Transaction Codes"."Is Formula")
                {
                }
                fieldattribute(h; "PR Transaction Codes".Formula)
                {
                }
                fieldattribute(j; "PR Transaction Codes"."Special Transactions")
                {
                    FieldValidate = no;
                }
                fieldattribute(k; "PR Transaction Codes"."Include Employer Deduction")
                {
                    FieldValidate = no;
                }
                fieldattribute(l; "PR Transaction Codes"."Is Formula for employer")
                {
                }
                fieldattribute(r; "PR Transaction Codes"."GL Account")
                {
                    FieldValidate = no;
                }
                fieldattribute(n; "PR Transaction Codes".Subledger)
                {
                    FieldValidate = no;
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
