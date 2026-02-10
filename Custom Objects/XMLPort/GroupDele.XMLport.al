#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185482 "Group Dele"
{

    schema
    {
        textelement(Name)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                XmlName = 'Guarantors';
                fieldattribute(a; "Gen. Journal Line"."Line No.")
                {
                    FieldValidate = no;
                }
                fieldattribute(b; "Gen. Journal Line"."Journal Template Name")
                {
                }
                fieldattribute(c; "Gen. Journal Line"."Journal Batch Name")
                {
                }
                fieldattribute(d; "Gen. Journal Line"."Posting Date")
                {
                }
                fieldattribute(e; "Gen. Journal Line"."Document No.")
                {
                }
                fieldattribute(f; "Gen. Journal Line"."Account Type")
                {
                }
                fieldattribute(h; "Gen. Journal Line"."Account No.")
                {
                }
                fieldattribute(j; "Gen. Journal Line".Amount)
                {
                }
                fieldattribute(g; "Gen. Journal Line".Description)
                {
                }
                fieldattribute(k; "Gen. Journal Line"."Shortcut Dimension 1 Code")
                {
                }
                fieldattribute(t; "Gen. Journal Line"."Shortcut Dimension 2 Code")
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
