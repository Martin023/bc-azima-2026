page 52185791 "Bulk SMS Header List"
{
    CardPageID = "Bulk SMS Header";
    Editable = false;
    PageType = List;
    SourceTable = "Bulk SMS Header";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    SourceTableView = where("SMS Status" = filter(<> Sent));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Message_; Rec.Message_)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("SMS Type"; Rec."SMS Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("SMS Status"; Rec."SMS Status")
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

