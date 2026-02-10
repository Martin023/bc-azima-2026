page 52186211 "Computer Asset Register List"
{
    CardPageID = "Computer Asset Register";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Computer Asset Register";
    SourceTableView = WHERE(Disposed = CONST(false));
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
                field(Control4; Rec.Disposed)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Disposed"; Rec."Date Disposed")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Disposed)
            {
                ApplicationArea = Basic, Suite;
            }
            action("Calculate Years Left")
            {
                ApplicationArea = Basic, Suite;
                Image = Calculate;
                Promoted = true;

                trigger OnAction()
                begin
                    repeat
                        Rec."Year of Service Left" := 5 - (Date2DMY(Today, 3) - Rec."Year of Purchase");
                        if Rec."Year of Service Left" < 0 then Rec."Year of Service Left" := 0;
                        Rec.Modify;
                    until Rec.Next = 0;
                    Message('Calulated successfully');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec."Year of Service Left" := 5 - (Date2DMY(Today, 3) - Rec."Year of Purchase");
    end;
}

