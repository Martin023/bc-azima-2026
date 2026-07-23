page 52185894 "HR CEO Goal Lines"
{
    Caption = 'Goal Lines';
    PageType = ListPart;
    SourceTable = "HR CEO Goal Line";
    AutoSplitKey = true;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Perspective Code"; Rec."Perspective Code")
                {
                    ApplicationArea = Basic;
                }
                field("Perspective Name"; Rec."Perspective Name")
                {
                    ApplicationArea = Basic;
                }
                field(Objective; Rec.Objective)
                {
                    ApplicationArea = Basic;
                }
                field(Strategy; Rec.Strategy)
                {
                    ApplicationArea = Basic;
                }
                field(Measures; Rec.Measures)
                {
                    ApplicationArea = Basic;
                }
                field(Baseline; Rec.Baseline)
                {
                    ApplicationArea = Basic;
                }
                field("Targeted Score"; Rec."Targeted Score")
                {
                    ApplicationArea = Basic;
                }
                field(Change; Rec.Change)
                {
                    ApplicationArea = Basic;
                }
                field("Applies To"; Rec."Applies To")
                {
                    ApplicationArea = Basic;
                    StyleExpr = AppliestoStyle;
                }
                field("HOD Assignments"; Rec."HOD Assignments")
                {
                    ApplicationArea = Basic;
                    DrillDown = false;
                    Style = Favorable;
                    StyleExpr = Rec."HOD Assignments" > 0;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec."Applies To" = Rec."Applies To"::"All HODs" then
            AppliestoStyle := 'Favorable'
        else
            AppliestoStyle := 'Attention';
    end;

    var
        AppliestoStyle: Text;

    procedure GetSelectedLine(var GoalLine: Record "HR CEO Goal Line")
    begin
        GoalLine := Rec;
    end;
}
