#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185501 "Electronic Fund Transfer"
{
    Direction = Export;
    Format = VariableText;

    schema
    {
        textelement(roots)
        {
            XmlName = 'Transfer_Line';
            tableelement("EFT Transfer Lines"; "RTGS Transfer Lines")
            {
                XmlName = 'TransferLine';
                fieldelement(ExportFormat; "EFT Transfer Lines".ExportFormat)
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
