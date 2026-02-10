page 52186336 "Delegate Retire Memberss"
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
                field("Appointment Date"; Rec."Appointment Date")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        Rec.Reinstate := false;
                        Rec.Retired := false;
                        Rec."Retirement Date" := 0D;
                        Rec."Reinstatement Date" := 0D;
                    end;
                }
                field(Retire; Rec.Retired)
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        Rec."Appointment Date" := 0D;
                        Rec.Reinstate := false;
                        Rec."Reinstatement Date" := 0D;
                        if Rec.Retired = true then
                            RetireDate := true else
                            RetireDate := false;
                    end;
                }
                field("Retirement Date"; Rec."Retirement Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = Rec.Retired;
                }
                field(Reinstate; Rec.Reinstate)
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        Rec.Retired := false;
                        Rec."Retirement Date" := 0D;
                        Rec."Appointment Date" := 0D;

                        if Rec.Reinstate = true then
                            Rec.Reinstate := true else
                            Rec.Reinstate := false;
                    end;
                }
                field("Reinstatement Date"; Rec."Reinstatement Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = Rec.Reinstate;
                }
                field(Appoint; Rec.Appoint)
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
              //  Promoted = true;

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

