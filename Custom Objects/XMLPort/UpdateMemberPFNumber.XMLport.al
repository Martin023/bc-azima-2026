#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185529 "Update Member PF Number"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(meb)
        {
            tableelement(Members; Members)
            {
                AutoUpdate = true;
                XmlName = 'Member';
                fieldelement(a; Members."No.")
                {
                }
                fieldelement(d; Members."Payroll/Staff No.")
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

    trigger OnPostXmlPort()
    begin
        Message('PF Number Update Complete');
    end;
}
