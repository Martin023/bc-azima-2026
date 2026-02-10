namespace KenpipeCBS.KenpipeCBS;

xmlport 52185577 "Import Saving Monthly Interest"
{
    Caption = 'Import Saving Monthly Interest';
    Format = VariableText;
    Direction = Both;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(SavingsInterestBuffer; "Saving Interest Import Buffer")
            {
                fieldelement(A; SavingsInterestBuffer."Header No.") { }
                fieldelement(B; SavingsInterestBuffer.No) { }
                fieldelement(C; SavingsInterestBuffer."Member No") { }
                fieldelement(D; SavingsInterestBuffer."Interest Date") { }
                fieldelement(E; SavingsInterestBuffer."Interest Amount") { }
                fieldelement(G; SavingsInterestBuffer."Lowest Bal") { }
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
