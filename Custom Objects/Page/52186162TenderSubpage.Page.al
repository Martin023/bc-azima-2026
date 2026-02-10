page 52186162 "Tender Subpage"
{
    PageType = ListPart;
    SourceTable = "Tender Plan Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Planned start date"; Rec."Planned start date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Planned end date"; Rec."Planned end date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Planned duration"; Rec."Planned duration")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Actual start date"; Rec."Actual start date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Actual Duration"; Rec."Actual Duration")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Actual end date"; Rec."Actual end date")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
}

