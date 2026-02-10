page 52186084 "Case Cost List"
{
    Caption = 'Case Cost List';
    PageType = List;
    SourceTable = "Case Cost List";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("Case Item"; Rec."Case Item")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field(Description; Rec.Description)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Cost; Rec.Cost)
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

