page 52186389 "Delegate  Memberss Transfer"
{
    PageType = ListPart;
    SourceTable = "Delegate Members Retirementss";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Job Tittle"; Rec."Job Tittle")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Position; Rec.Position)
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
                field(Transfer; Rec.Transfer)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Tranfer To"; Rec."Tranfer To")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Tranfer Date"; Rec."Tranfer Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transfer to Position"; Rec."Transfer to Position")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transfer to Name"; Rec."Transfer to Name")
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
            action("Retire all Members")
            {
                ApplicationArea = Basic, Suite;
                Image = ReturnCustomerBill;
               // Promoted = true;

                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to retire all delegates?') then
                        exit;
                    Rec.Retired := true;
                    Rec.ModifyAll(Retired, true);
                end;
            }
            action("`")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    var
        RetireDate: Boolean;
        ReinstateDate: Boolean;
}

