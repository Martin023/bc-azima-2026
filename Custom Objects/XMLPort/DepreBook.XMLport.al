#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185446 "Depre Book"
{
    Format = VariableText;

    schema
    {
        textelement(name)
        {
            tableelement("FA Depreciation Book"; "FA Depreciation Book")
            {
                XmlName = 'depre';
                fieldelement(No; "FA Depreciation Book"."FA No.")
                {
                }
                fieldelement(b; "FA Depreciation Book"."Depreciation Book Code")
                {
                }
                fieldelement(c; "FA Depreciation Book"."Depreciation Method")
                {
                }
                fieldelement(d; "FA Depreciation Book"."Declining-Balance %")
                {
                }
                fieldelement(e; "FA Depreciation Book"."Acquisition Date")
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
