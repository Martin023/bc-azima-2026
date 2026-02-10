page 52185624 "prMembership Groups"
{
    PageType = List;
    SourceTable = "prMembership Groups";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Group No"; Rec."Group No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Member Details")
            {
                Caption = 'Member Details';

                action("Institutional Listing")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Institutional Listing';
                    Image = IndustryGroups;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "prInstitutional Membership";
                    RunPageLink = "Group No" = FIELD("Group No");
                }
            }
        }
    }
}

