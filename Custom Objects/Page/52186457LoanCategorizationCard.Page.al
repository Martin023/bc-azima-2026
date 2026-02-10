page 52186457 "Loan Categorization"
{
    PageType = Card;
    SourceTable = "Loan Categorization";
    UsageCategory = Lists;
    Caption = 'Loan Categorization codes';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(C_Code; Rec.C_Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }

            }
            part(Control7; "Agent Tariff Details")
            {
                SubPageLink = Code = FIELD(C_Code);
            }
        }
    }

    actions
    {
    }
}

