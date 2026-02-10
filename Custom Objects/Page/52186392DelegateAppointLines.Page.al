page 52186392 "Delegate Appoint  Lines"
{
    PageType = ListPart;
    SourceTable = "Delegate AGM Appoint Update";

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
                field("Appointment Date"; Rec."Appointment Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ID No."; Rec."ID No.")
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

