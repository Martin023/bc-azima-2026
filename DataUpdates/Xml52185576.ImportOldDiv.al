namespace KenpipeCBS.KenpipeCBS;

xmlport 52185576 "Import Old Div"
{
    Format = VariableText;
    Direction = Both;
    Caption = 'Import Old Div';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(DividendProgressionImport; "Dividend Progression Import")
            {
                fieldelement(MemberNo; DividendProgressionImport."Member No.")
                {
                }
                fieldelement(Date; DividendProgressionImport."Date")
                {
                }
                fieldelement(grossDiv; DividendProgressionImport."Gross Div.")
                {

                }
                fieldelement(Wtax; DividendProgressionImport."Wtax")
                {
                }

                fieldelement(NetDiv; DividendProgressionImport."Net Div.")
                {
                }
                fieldelement(QualifyingShares; DividendProgressionImport."Qualifying Shares")
                {
                }
                fieldelement(shaes; DividendProgressionImport.Shares)
                {
                }


            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
