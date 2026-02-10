page 52186343 "Delegate Members List"
{
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Delegate Members";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

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
                // field("Delegate Zone Name"; Rec."Delegate Zone Name")
                // {
                //     Caption = 'Delegate Zone Name';
                // }
                field("Electoral Zone Name"; Rec."Electoral Zone Name")
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
                field("Appointment Date"; Rec."Appointment Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Expiry Date"; Rec."Expiry Date")
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
                field("Reason for retirement"; Rec."Reason for retirement")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Service Period"; Rec."Service Period")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Retired By"; Rec."Retired By")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        DelegateZone.Reset;
        DelegateZone.SetRange(Code, Rec.Code);
        if DelegateZone.Find('-') then
            "Delegate Zone Name" := DelegateZone."Delegate Region Description";
    end;

    var
        DelegateZone: Record "Delegate Region";
        "Delegate Zone Name": Text;
}

