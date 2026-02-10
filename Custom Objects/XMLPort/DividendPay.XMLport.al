#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185434 "Dividend Pay"
{
    Direction = Both;
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(Members; Members)
            {
                AutoUpdate = true;
                XmlName = 'Members';
                fieldelement(a; Members."No.")
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
        Message('Dividend Action Updated to Pay');
    end;
}
