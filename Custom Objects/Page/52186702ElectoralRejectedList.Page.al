page 52186702 "Electoral Rejected List"
{
    CardPageID = "Electoral Zones Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Electoral Zones";
    SourceTableView = WHERE(Status = CONST(Rejected));

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
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {

                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
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
                field("Sub-County"; Rec."Sub-County")
                {

                    ApplicationArea = Basic, Suite;
                }
                field("Sub County Name";Rec."Sub County Name")
                {

                    ApplicationArea = Basic, Suite;
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

