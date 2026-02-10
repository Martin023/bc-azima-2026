#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185520 "Import User Station"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("User Stations"; "User Stations")
            {
                XmlName = 'FileMVT';
                fieldelement(f; "User Stations"."User Id")
                {
                }
                fieldelement(t; "User Stations"."Station Code")
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
        Message('DONE!!!');
    end;
}
