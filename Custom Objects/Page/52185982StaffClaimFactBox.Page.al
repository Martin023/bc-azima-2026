page 52185982 "Staff Claim FactBox"
{
    PageType = CardPart;
    SourceTable = "Staff Claim Lines";

    layout
    {
        //here
        area(content)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = Basic;
            }
            field(No; Rec.No)
            {
                ApplicationArea = Basic;
            }
            // field("STRSUBSTNO('%1',BudgetaryControl.PaneMgt(Rec,0))"; Rec.StrSubstNo('%1', BudgetaryControl.PaneMgt(Rec, 0)))
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Budgeted Amount';
            // }
            // field("STRSUBSTNO('%1',BudgetaryControl.PaneMgt(Rec,2))"; Rec.StrSubstNo('%1', BudgetaryControl.PaneMgt(Rec, 2)))
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Committed Amount';
            // }
            // field("STRSUBSTNO('%1',BudgetaryControl.PaneMgt(Rec,1))"; Rec.StrSubstNo('%1', BudgetaryControl.PaneMgt(Rec, 1)))
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Actual Amount';

            // field("STRSUBSTNO('%1',BudgetaryControl.PaneMgt(Rec,0)-BudgetaryControl.PaneMgt(Rec,2)-BudgetaryControl.PaneMgt(Rec,1))"; Rec.StrSubstNo('%1', BudgetaryControl.PaneMgt(Rec, 0) - BudgetaryControl.PaneMgt(Rec, 2) - BudgetaryControl.PaneMgt(Rec, 1)))
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Balance';
            // }
            field("Amount LCY"; Rec."Amount LCY")
            {
                ApplicationArea = Basic;
                Caption = 'Line Amount';
            }
        }
    }

    actions
    {
    }

    var
    // BudgetaryControl: Codeunit "Budgetary Control";
}

