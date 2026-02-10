page 52185972 "Purchase Line Budget FactBox"
{
    PageType = CardPart;
    SourceTable = "Purchase Line";

    layout
    {

        area(content)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("No."; Rec."No.")
            {
                ApplicationArea = Basic, Suite;
            }

            field("Line Amount"; Rec."Line Amount")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Line Amount';
            }
        }
    }

    actions
    {
    }

    var
        BudgetaryControl: Codeunit "Budgetary Control";
}

