page 52186320 "Delegate Meeting Header"
{
    CardPageID = "Delegate Meeting Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Delegates Minutes Header";
    SourceTableView = where(Status = filter(Open|Pending));
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
                field(Year; Rec.Year)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Quarter;Rec.Quarter)
                {
                    
                }
            }
        }
    }

    actions
    {
       

}

}