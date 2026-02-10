page 52186636 "HR Leave Planner"
{
    PageType = ListPart;
    SourceTable = "HR Leave Planner Lines";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(January; Rec.January)
                {
                    ApplicationArea = Basic;
                }
                field(Feburuary; Rec.Feburuary)
                {
                    ApplicationArea = Basic;
                }
                field(March; Rec.March)
                {
                    ApplicationArea = Basic;
                }
                field(April; Rec.April)
                {
                    ApplicationArea = Basic;
                }
                field(May; Rec.May)
                {
                    ApplicationArea = Basic;
                }
                field(June; Rec.June)
                {
                    ApplicationArea = Basic;
                }
                field(July; Rec.July)
                {
                    ApplicationArea = Basic;
                }
                field(August; Rec.August)
                {
                    ApplicationArea = Basic;
                }
                field(September; Rec.September)
                {
                    ApplicationArea = Basic;
                }
                field(October; Rec.October)
                {
                    ApplicationArea = Basic;
                }
                field(November; Rec.November)
                {
                    ApplicationArea = Basic;
                }
                field(December; Rec.December)
                {
                    ApplicationArea = Basic;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Document Number"; Rec."Document Number")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

