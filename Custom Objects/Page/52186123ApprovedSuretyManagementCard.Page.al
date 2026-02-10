page 52186123 "ApprovedSurety Management Card"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Surety Management";
    SourceTableView = WHERE(Status = FILTER(Approved));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Surety No"; Rec."Surety No")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = SuretyEditable;
                }
                field("Type Of Account"; Rec."Type Of Account")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = SuretyEditable;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = SuretyEditable;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Surety Amount"; Rec."Surety Amount")
                {
                    ApplicationArea = Basic;
                    Editable = SuretyEditable;
                }
                field("Refference No"; Rec."Refference No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = SuretyEditable;
                }
                field("Refference Details"; Rec."Refference Details")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = SuretyEditable;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                }
                // field(Type; Rec.Type)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field(Court; Rec.Court)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = SuretyEditable;
                }
                field("Court Name"; Rec."Court Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = SuretyEditable;
                }
                field("Case No"; Rec."Case No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = SuretyEditable;
                }
                field(Posted;Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            // action(Print)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Print';
            //     Image = Print;
            //     Promoted = true;
            //     PromotedCategory = Process;

            //     trigger OnAction()
            //     begin
            //         if rec.Status = rec.Status::Approved then begin
            //         end else
            //             Error('You can only Print approved Document');

            //         rec.Reset;
            //         rec.SetFilter("Surety No", rec."Surety No");
            //         //REPORT.Run(39006073, true, true, Rec);
            //         rec.Reset;
            //     end;
            // }

            action("Post Surety")
            {
                ApplicationArea = Basic;
                Caption = 'Post Surety';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                GlobalFunctions: Codeunit "Global Functions";
                HoldType: Enum "Funds Witheld Types";

                begin
                    Rec.Testfield(Status, Rec.Status::Approved);
                    GlobalFunctions.HoldMoneyInAccount(rec."Surety No", rec."Account No", rec."Account No", 0, 0, rec."Surety Amount", HoldType::Surety );
                    Rec.Posted := true;
                    Rec.Modify();
                    if Rec.Posted then
                        Message('Surety Posted Successfully');
                end;
            }
        }
    }

    procedure UpdatePageControls()
    begin
        if Rec.Status =  Rec.Status::Open then begin
            SuretyEditable := True;
        end
        else begin
            if Rec.Status = Rec.Status::Pending then begin
                SuretyEditable := True;
            end
            else begin 
                if Rec.Status = Rec.Status::Approved then begin
                    SuretyEditable := False;
                end;
            end;
        end;
    end;

    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        SuretyEditable: Boolean;
}

