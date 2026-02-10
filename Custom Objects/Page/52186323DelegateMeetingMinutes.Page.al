page 52186323 "Delegate Meeting Minutes"
{
    CardPageID = "Degate Meeting Minutes Card";
    PageType = List;
    SourceTable = "Delegates Meeting Minutes";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Meeting No."; Rec."Meeting No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Details; Rec.Details)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Feedback; Rec.Feedback)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Feedback By"; Rec."Feedback By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Feedback Date"; Rec."Feedback Date")
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

