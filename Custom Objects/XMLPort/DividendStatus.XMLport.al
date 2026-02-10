#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185428 "Dividend Status"
{
    Format = VariableText;

    schema
    {
        textelement(NME)
        {
            tableelement("Dividend Progression"; "Dividend Progression")
            {
                AutoReplace = true;
                MinOccurs = Zero;
                XmlName = 'JOURNAL';
                fieldelement(A; "Dividend Progression"."Entry No.")
                {
                }
                fieldelement(B; "Dividend Progression"."Account No")
                {
                }
                fieldelement(C; "Dividend Progression"."Processing Date")
                {
                }
                fieldelement(D; "Dividend Progression"."Dividend Calc. Method")
                {
                }
                fieldelement(e; "Dividend Progression"."Product Type")
                {
                }
                fieldelement(f; "Dividend Progression"."Product Name")
                {
                }
                fieldelement(g; "Dividend Progression"."Member No")
                {
                }
                fieldelement(i; "Dividend Progression".Shares)
                {
                }
                fieldelement(h; "Dividend Progression"."Qualifying Shares")
                {
                }
                fieldelement(j; "Dividend Progression"."Gross Dividends")
                {
                }
                fieldelement(k; "Dividend Progression"."Witholding Tax")
                {
                }
                fieldelement(l; "Dividend Progression"."Net Dividends")
                {
                }
                fieldelement(m; "Dividend Progression"."Start Date")
                {
                }
                fieldelement(n; "Dividend Progression"."End Date")
                {
                }
                fieldelement(o; "Dividend Progression".Year)
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    //"Temp Data".DELETEALL;
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
