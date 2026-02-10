page 52186051 "Overtime Claim Lines"
{
    PageType = ListPart;
    SourceTable = "Overtime Claim Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Work Description/Reason"; Rec."Work Description/Reason")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Time From"; Rec."Time From")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time To"; Rec."Time To")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No. of Hours"; Rec."No. of Hours")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Overtime Type"; Rec."Overtime Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
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

