#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185535 "Worker Impoter"
{
    Format = VariableText;

    schema
    {
        textelement(tab)
        {
            tableelement("Worker Table"; "Worker Table")
            {
                XmlName = 'WorkerTable';
                fieldelement(i; "Worker Table"."Loan No")
                {
                }
                fieldelement(j; "Worker Table"."Member No")
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
