page 52186489 "HR Training Cost"
{
    Caption='Costs';
    PageType = List;
    SourceTable = "HR Training Cost";
    ApplicationArea = Basic;
    UsageCategory = Lists;
    

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cost Item"; Rec."Cost Item")
                {
                    ApplicationArea = Basic;
                    
                }
                field("Cost Item Description"; Rec."Cost Item Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Cost; Rec.Cost)
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

