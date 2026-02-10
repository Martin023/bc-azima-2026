page 52186340 "Exceptions/ Rejection Reason"
{
    PageType = List;
    SourceTable = "Exceptions/ Rejection Reason";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    InsertAllowed = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    //Visible = false;
                    //Editable = false;
                }
                field("Rejection Reason"; Rec."Exceptions/ Rejection Reason")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Creation Date"; Rec."Creation Date")
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

