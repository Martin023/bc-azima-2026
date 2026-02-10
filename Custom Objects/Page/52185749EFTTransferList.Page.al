page 52185749 "RTGS Transfer List"
{
    CardPageID = "RTGS Transfer Header";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "RTGS Transfer Header";
    SourceTableView = WHERE(Status = FILTER(Open | Pending | Approved));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Record Total"; Rec."Record Total")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Record Count"; Rec."Record Count")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
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

