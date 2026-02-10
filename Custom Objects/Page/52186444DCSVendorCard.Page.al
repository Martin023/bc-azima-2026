page 52186444 "DCS Vendor Card"
{
    PageType = List;
    SourceTable = Vendor;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
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

