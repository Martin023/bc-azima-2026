page 52186073 "Global Bulk SMS Filter Part"
{
    PageType = ListPart;
    SourceTable = "Global Bulk SMS Filter";
    Caption = 'Filters';
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = All;
                }
                field("Filter Source"; Rec."Filter Source")
                {
                    ApplicationArea = All;
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ApplicationArea = All;
                }
                field("Filter Operator"; Rec."Filter Operator")
                {
                    ApplicationArea = All;
                }
                field("Filter Value 1"; Rec."Filter Value 1")
                {
                    ApplicationArea = All;
                }
                field("Filter Value 2"; Rec."Filter Value 2")
                {
                    ApplicationArea = All;
                }
                field("Logical Operator"; Rec."Logical Operator")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(TestFilter)
            {
                ApplicationArea = All;
                Caption = 'Test Filter';
                Image = TestReport;

                trigger OnAction()
                var
                    FilterEngine: Codeunit "Global Filter Engine";
                    MatchCount: Integer;
                begin
                    MatchCount := FilterEngine.TestFilters(Rec."Campaign No.");
                    Message('%1 member(s) match.', MatchCount);
                end;
            }
        }
    }
}
