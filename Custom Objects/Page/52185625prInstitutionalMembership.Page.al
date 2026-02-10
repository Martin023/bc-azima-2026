page 52185625 "prInstitutional Membership"
{
    PageType = List;
    SourceTable = "prInstitutional Membership";
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
                    Editable = false;
                }
                field("Institution No"; Rec."Institution No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
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

