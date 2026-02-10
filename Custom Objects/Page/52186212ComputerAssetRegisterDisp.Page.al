page 52186212 "Computer Asset Register (Disp)"
{
    CardPageID = "Computer Asset Register";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Computer Asset Register";
    SourceTableView = WHERE(Disposed = CONST(true));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

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
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Asset Description"; Rec."Asset Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Manufacturer; Rec.Manufacturer)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Allocated User"; Rec."Allocated User")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("System Software"; Rec."System Software")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Applications; Rec.Applications)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Processor Type"; Rec."Processor Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Memory Size"; Rec."Memory Size")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Asset Serial No"; Rec."Asset Serial No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Year of Purchase"; Rec."Year of Purchase")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Year of Service Left"; Rec."Year of Service Left")
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

