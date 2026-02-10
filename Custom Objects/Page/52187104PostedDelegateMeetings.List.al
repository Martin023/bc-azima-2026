page 52187104 "Posted Delegate Meetings"
{
    CardPageID = "Delegate Meeting Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Delegates Minutes Header";
    SourceTableView = where("Meeting Paid" = const(True));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Electoral Name"; Rec."Electoral Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Meeting Paid";Rec."Meeting Paid")
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