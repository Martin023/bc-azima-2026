#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185495 "Import Default Cheques"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Data Translation"; "Data Translation")
            {
                XmlName = 'Translation';
                fieldelement(Code; "Data Translation".Code)
                {
                }
                fieldelement(MembeNo; "Data Translation"."Member No")
                {
                }
                fieldelement(CH_Account; "Data Translation"."Cheque Account No")
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
