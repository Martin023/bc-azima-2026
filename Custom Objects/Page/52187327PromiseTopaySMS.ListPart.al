page 52187327 "Promise Topay SMS"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "PromiseTopay SMS Log";

    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No"; Rec."Member No")
                {
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                }
                field("Loan Number"; Rec."Loan Number")
                {
                    Editable = false;
                }

                field(SMS; Rec.SMS)
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    Editable = false;
                }

            }
        }
    }
}

