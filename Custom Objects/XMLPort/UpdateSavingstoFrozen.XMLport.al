#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185533 "Update Savings to Frozen"
{
    Direction = Both;
    Format = VariableText;

    schema
    {
        textelement(meb)
        {
            tableelement("Savings Accounts"; "Savings Accounts")
            {
                AutoUpdate = true;
                XmlName = 'Savings';
                fieldelement(a; "Savings Accounts"."No.")
                {
                }
                fieldelement(b; "Savings Accounts".Status)
                {
                    FieldValidate = no;
                }
                fieldelement(c; "Savings Accounts"."Status Change Reason")
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
        Message('Done');
    end;
}
