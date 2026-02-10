page 52186701 "Approved Electoral List"
{
    CardPageID = "Electoral Zones Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Electoral Zones";
    SourceTableView = WHERE(Status = FILTER(Approved));
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
                    Editable = false;
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
                field("County Name";Rec."County Name")
                {

                }
                field("Sub County Name";Rec."Sub County Name")
                {
                    
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
               
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

