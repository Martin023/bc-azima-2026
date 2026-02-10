page 52186127 "Loanee Information Base"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Loanee Infomation Base";
    ApplicationArea = Basic, Suite;
    //UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loanee Status"; Rec."Loanee Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Info; Rec.Info)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Captured By"; Rec."Captured By")
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

