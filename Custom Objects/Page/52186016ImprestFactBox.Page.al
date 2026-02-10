page 52186016 "Imprest FactBox"
{
    PageType = CardPart;
    SourceTable = "Imprest Lines";

    layout
    {
        area(content)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field(No; Rec.No)
            {
                ApplicationArea = Basic, Suite;
            }
            // field("STRSUBSTNO('%1',BudgetaryControl.PaneMgt(Rec,0))"; Rec.StrSubstNo('%1', BudgetaryControl.PaneMgt(Rec, 0)))
            // {
            //     Caption = 'Budgeted Amount';
            // }
            // field("STRSUBSTNO('%1',BudgetaryControl.PaneMgt(Rec,2))"; Rec.StrSubstNo('%1', BudgetaryControl.PaneMgt(Rec, 2)))
            // {
            //     Caption = 'Committed Amount';
            // }
            // field("STRSUBSTNO('%1',BudgetaryControl.PaneMgt(Rec,1))"; Rec.StrSubstNo('%1', BudgetaryControl.PaneMgt(Rec, 1)))
            // {
            //     Caption = 'Actual Amount';
            // }
            // field("STRSUBSTNO('%1',BudgetaryControl.PaneMgt(Rec,0)-BudgetaryControl.PaneMgt(Rec,2)-BudgetaryControl.PaneMgt(Rec,1))"; Rec.StrSubstNo('%1', BudgetaryControl.PaneMgt(Rec, 0) - BudgetaryControl.PaneMgt(Rec, 2) - BudgetaryControl.PaneMgt(Rec, 1)))
            // {
            //     Caption = 'Balance';
            // }
            field("Amount LCY"; Rec."Amount LCY")
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

