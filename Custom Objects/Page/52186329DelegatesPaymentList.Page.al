page 52186329 "Delegates Payment List"
{
    CardPageID = "Delegates Payment Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Delegates Payment";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    SourceTableView = where(Status = filter(Open|Pending));

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
               
               
                field("Electoral Zone"; Rec."Electoral Zone")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Electoral Zone Name"; Rec."Electoral Zone Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = Basic, Suite;
                }
               
                field("County Name"; Rec."County Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
               
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Payment"; Rec."Total Payment")
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

