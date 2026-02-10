page 52186674 "Monthly Returns List"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "Delegates Monthly Returns";
    SourceTableView = WHERE("Caption Type" = FILTER(<> 'TOTAL_BRANCH_MEMBERS'));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Caption Type"; Rec."Caption Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Caption; Rec.Caption)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Records Submitted"; Rec."Records Submitted")
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

