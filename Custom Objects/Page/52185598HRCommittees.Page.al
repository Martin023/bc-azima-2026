page 52185598 "HR Committees"
{
    PageType = List;
    SourceTable = "HR Committees";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Roles; Rec.Roles)
                {
                    ApplicationArea = Basic;
                }
                field("Monetary Benefit?"; Rec."Monetary Benefit?")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Committee)
            {
                Caption = 'Committee';
                action(Members)
                {
                    Caption = 'Members';
                    RunObject = Page "HR Commitee Members";
                    RunPageLink = Committee = FIELD(Code);
                }
            }
        }
    }
}

