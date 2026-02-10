#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185504 "Export Cheque Book Application"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Cheque Book Application"; "Cheque Book Application")
            {
                XmlName = 'Export_ChequeBook_App';
                fieldelement(Name; "Cheque Book Application".Name)
                {
                }
                fieldelement(Member_No; "Cheque Book Application"."Translation Code")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    "Cheque Book Application"."Application Exported" := true;
                    "Cheque Book Application".Select := false;
                    "Cheque Book Application".Modify;
                end;
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
