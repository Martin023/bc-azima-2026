page 52185490 "Insurance Actioned List"
{
    CardPageID = "Sky Insurance Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sky Insurance";
    SourceTableView = WHERE(Actioned = CONST(true));
    UsageCategory = Lists;
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Session ID"; Rec."Session ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Entry Time"; Rec."Entry Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Entry Date"; Rec."Entry Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Actioned; Rec.Actioned)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Actioned By"; Rec."Actioned By")
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

