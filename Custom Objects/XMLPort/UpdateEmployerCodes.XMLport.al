#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185523 "Update Employer Codes"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Update Employer Code"; "Update Employer Code")
            {
                XmlName = 'FileMVT';
                fieldelement(a; "Update Employer Code".No)
                {
                }
                fieldelement(b; "Update Employer Code"."Emp Code")
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
