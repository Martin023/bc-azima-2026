
page 52186834 "Risk Claim List"
{
    CardPageID = "Risk Claim Notice";
    Caption = 'Deceased Member Notice';
    DeleteAllowed = false;
    // InsertAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "SinkFund Report Information";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    SourceTableView = where(Status = filter(Open | Pending));
    //, "Claim Type" = filter(" " | "Risk Claim"));
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Date of Death"; Rec."Date of Death")
                {
                    ApplicationArea = Basic, Suite;
                }

                // field("Claim Type"; Rec."Claim Type")
                // {

                // }
                field("Deceased Person"; Rec."Deceased Person")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
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

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Responsibility Centre");
            Rec.SetFilter("Current Department", UserSetup."Responsibility Centre");
        end else
            Error('You must be set up in user setup');
    end;


}


