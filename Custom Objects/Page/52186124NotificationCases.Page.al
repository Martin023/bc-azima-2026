page 52186124 "Notification Cases"
{
    PageType = List;
    SourceTable = "Cases Noitification";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Mention; Rec.Mention)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Judgment; Rec.Judgment)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Hearing; Rec.Hearing)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Action Required"; Rec."Action Required")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Hearing Date"; Rec."Hearing Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Expiry Date For Leases"; Rec."Expiry Date For Leases")
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

