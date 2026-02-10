page 52186391 "Delegate Retire Lines"
{
    PageType = ListPart;
    SourceTable = "Delegate AGM Retire Update";

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
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Job Tittle"; Rec."Job Tittle")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegate MNO."; Rec."Delegate MNO.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegate Name"; Rec."Delegate Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Retired; Rec.Retired)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Retire Date"; Rec."Retire Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Retired By"; Rec."Retired By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reason for retirement"; Rec."Reason for retirement")
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

