page 52186680 "Sky Portal Setup List"
{
    CardPageID = "Sky Portal Setup Card";
    Editable = false;
    PageType = List;
    SourceTable = "Sky Portal Setup";
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
                field("Transaction Type"; Rec."Transaction Type")
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

