page 52185568 "Hr Leave Planner Lines"
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
                }
                field("Staff Name"; Rec."Staff Name")
                {

                    ApplicationArea = Basic;
                }
                field(January; Rec.January)
                {

                    ApplicationArea = Basic;
                    DrillDown = true;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown."Employee No", Rec."Staff No.");
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Month, 1);
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Year, Rec.Year);

                        PAGE.Run(52185672, LeavePlannerDrillDown);
                    end;
                }
                field(Feburuary; Rec.Feburuary)
                {

                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnDrillDown()
                    begin
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown."Employee No", Rec."Staff No.");
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Month, 2);
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Year, Rec.Year);

                        PAGE.Run(52185672, LeavePlannerDrillDown);
                    end;
                }
                field(March; Rec.March)
                {

                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnDrillDown()
                    begin
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown."Employee No", Rec."Staff No.");
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Month, 3);
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Year, Rec.Year);

                        PAGE.Run(52185672, LeavePlannerDrillDown);
                    end;
                }
                field(April; Rec.April)
                {

                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnDrillDown()
                    begin
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown."Employee No", Rec."Staff No.");
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Month, 4);
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Year, Rec.Year);

                        PAGE.Run(52185672, LeavePlannerDrillDown);
                    end;
                }
                field(May; Rec.May)
                {

                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnDrillDown()
                    begin
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown."Employee No", Rec."Staff No.");
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Month, 5);
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Year, Rec.Year);

                        PAGE.Run(52185672, LeavePlannerDrillDown);
                    end;
                }
                field(June; Rec.June)
                {

                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnDrillDown()
                    begin
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown."Employee No", Rec."Staff No.");
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Month, 6);
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Year, Rec.Year);

                        PAGE.Run(52185672, LeavePlannerDrillDown);
                    end;
                }
                field(July; Rec.July)
                {

                    ApplicationArea = Basic;

                    trigger OnDrillDown()
                    begin
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown."Employee No", Rec."Staff No.");
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Month, 7);
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Year, Rec.Year);

                        PAGE.Run(52185672, LeavePlannerDrillDown);
                    end;
                }
                field(August; Rec.August)
                {

                    ApplicationArea = Basic;

                    trigger OnDrillDown()
                    begin
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown."Employee No", Rec."Staff No.");
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Month, 8);
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Year, Rec.Year);

                        PAGE.Run(52185672, LeavePlannerDrillDown);
                    end;
                }
                field(September; Rec.September)
                {

                    ApplicationArea = Basic;

                    trigger OnDrillDown()
                    begin
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown."Employee No", Rec."Staff No.");
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Month, 9);
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Year, Rec.Year);

                        PAGE.Run(52185672, LeavePlannerDrillDown);
                    end;
                }
                field(October; Rec.October)
                {

                    ApplicationArea = Basic;

                    trigger OnDrillDown()
                    begin
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown."Employee No", Rec."Staff No.");
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Month, 10);
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Year, Rec.Year);

                        PAGE.Run(52185672, LeavePlannerDrillDown);
                    end;
                }
                field(November; Rec.November)
                {

                    ApplicationArea = Basic;

                    trigger OnDrillDown()
                    begin
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown."Employee No", Rec."Staff No.");
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Month, 11);
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Year, Rec.Year);

                        PAGE.Run(52185672, LeavePlannerDrillDown);
                    end;
                }
                field(December; Rec.December)
                {

                    ApplicationArea = Basic;

                    trigger OnDrillDown()
                    begin
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown."Employee No", Rec."Staff No.");
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Month, 12);
                        LeavePlannerDrillDown.SetRange(LeavePlannerDrillDown.Year, Rec.Year);

                        PAGE.Run(52185672, LeavePlannerDrillDown);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    var
        LeavePlannerDrillDown: Record "HR Leave Planner Drill";
}

