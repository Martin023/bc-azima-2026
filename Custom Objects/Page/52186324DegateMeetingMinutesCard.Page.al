page 52186324 "Degate Meeting Minutes Card"
{
    PageType = Card;
    SourceTable = "Delegates Meeting Minutes";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            group(General)
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
                group("Minutes Details")
                {
                    field(Details; Rec.Details)
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field(Feedback; Rec.Feedback)
                    {
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
        }
    }

    actions
    {
    }
}

