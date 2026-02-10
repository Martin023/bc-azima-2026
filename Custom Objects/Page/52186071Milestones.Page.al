page 52186071 Milestones
{
    PageType = ListPart;
    SourceTable = Milestones;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contract No.";  Rec."Contract No")
                {
                    ApplicationArea = Basic,Suite;
                    Editable= false;
                }
                field("Milestone Stage"; Rec."Milestone Stage")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        Milestones.Reset;
                        Milestones.SetCurrentKey("Line No");
                        Milestones.SetRange("Contract No", Rec."Contract No");
                        Milestones.SetFilter("Milestone Stage", '<>%1', Rec."Milestone Stage");
                        if Milestones.FindLast then
                            Rec."Line No" += Milestones."Line No"
                        else
                            Rec."Line No" := 1;
                    end;
                }
                field("Stage Description"; Rec."Stage Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        Milestones.Reset;
                        Milestones.SetCurrentKey("Line No");
                        Milestones.SetRange("Contract No", Rec."Contract No");
                        Milestones.SetFilter("Milestone Stage", '<>%1', Rec."Milestone Stage");
                        if Milestones.FindLast then
                            if Milestones."End Date" > Rec."Start Date" then Error('Last milestone''s end date cannot be greater than current milestone''s start date');
                    end;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        if Rec."End Date" < Rec."Start Date" then Error('End date cannot be smaller than start date');
                    end;
                }
                field("Completed %"; Rec."Completed %")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Milestone Status"; Rec."Milestone Status")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    var
        Milestones: Record Milestones;
}

