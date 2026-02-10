page 52185487 "Actioned Mortgage"
{
    CardPageID = "Mortgage Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sky Mortgage";
    SourceTableView = WHERE(Actioned = CONST(true));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

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
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Number"; Rec."Member Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Age Group"; Rec."Age Group")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Source Of Income"; Rec."Source Of Income")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Gross Monthly Income"; Rec."Gross Monthly Income")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("County Of Residence"; Rec."County Of Residence")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Actioned; Rec.Actioned)
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
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Actioned By"; Rec."Actioned By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Actioned"; Rec."Date Actioned")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Actioned"; Rec."Time Actioned")
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

