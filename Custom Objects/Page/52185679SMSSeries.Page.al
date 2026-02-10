page 52185679 "SMS Series"
{
    PageType = List;
    SourceTable = "SMS Series";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field("Message Body"; Rec."Message Body")
                {
                    ApplicationArea = Basic;
                }
                field("Email Body"; Rec."Email Body")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

