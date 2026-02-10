page 52185682 "SMS Codes"
{
    PageType = List;
    SourceTable = "SMS Codes";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = Basic;
                }
                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = Basic;
                }
                field("Field ID"; Rec."Field ID")
                {
                    ApplicationArea = Basic;
                }
                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = Basic;
                }
                field("Code"; Rec.Code)
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

