page 52185968 "Asset Transfer List Effected"
{
    CardPageID = "Asset Transfer";
    Editable = false;
    PageType = List;
    SourceTable = "Asset Transfer";
    SourceTableView = WHERE(Transferred = FILTER(true));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
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
                field("Raised By"; Rec."Raised By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Transferred; Rec.Transferred)
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

