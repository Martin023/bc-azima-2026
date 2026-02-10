page 52186119 "Surety Management List"
{
    CardPageID = "Surety Management Card";
    PageType = List;
    SourceTable = "Surety Management";
    //SourceTableView = WHERE(Status = FILTER(<> Approved));
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Surety No"; Rec."Surety No")
                {
                    ApplicationArea = Basic;
                }
                // field("Type Of Account"; Rec."Type Of Account")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Member No."; Rec."Account No")
                {
                    Caption = 'Member No';
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'BOSA Deposit Balance';
                    ApplicationArea = Basic;
                }
                field(Liabilities; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Surety Amount"; Rec."Surety Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                Field("Status"; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                
            }
        }
    }

    actions
    {
    }
    // trigger OnOpenPage()
    // var
    // UserSetup: Record "User Setup";
    // begin
    //     if UserSetup.Get(UserId) then begin
    //         UserSetup.TestField("Responsibility Centre");
    //         Rec.SetFilter("Current Departmrnt",UserSetup."Responsibility Centre");
    //     end else
    //         Error('You must be set up in user setup');
    // end;
}

