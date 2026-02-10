page 52186393 "Delegates AGM Update List"
{
    CardPageID = "Deleage AGM Update Header";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Delegate AGM Update Header";
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
                field("AGM Year"; Rec."AGM Year")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Update Type"; Rec."Update Type")
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

