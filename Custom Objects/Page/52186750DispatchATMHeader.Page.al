page 52186750 "Dispatch ATM Header"
{
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = "Dispatch ATM Header";
    PromotedActionCategories = 'New,Process,Report,Workflows, ,Request Approval';


    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("User Id"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Date Of Dispatch"; Rec."Date Of Dispatch")
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
                field("Record Count"; Rec."Record Count")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Total Received"; Rec."Total Received")
                {
                    ApplicationArea = Basic, Suite;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;

                }
            }
            // part(Control17; "Dispatch ATM Lines")
            // {
            //     SubPageLink = "Global Dimension 1 Code" = field("Global Dimension 1 Code"), "Global Dimension 2 Code" = field("Global Dimension 2 Code"), Status = filter(Open);
            //     ApplicationArea = Basic;
            // }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action22)
            {
                Caption = 'Dispatch';
                action(Dispatch)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    // Enabled = (ATMLines."To Branch" = false);

                    trigger OnAction()
                    var

                    begin
                        if rec.Status = rec.Status::Approved then begin

                            // ATMLines.Reset();
                            // ATMLines.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                            // ATMLines.SetRange(Status, ATMLines.Status::Open);
                            // ATMLines.SetRange("To Branch", true);
                            // if ATMLines.Find('-') then begin
                            //     repeat
                            //         ATMLines.Status := ATMLines.Status::"In Transit";
                            //         // ATMLines."To Branch" := true;
                            //         ATMLines.Modify;
                            //     until ATMLines.Next = 0;
                            // end;

                        end;
                        CurrPage.Update;
                        MESSAGE('Cards In Transit!!')
                    end;
                }

                action(Received)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Insert;
                    Promoted = true;
                    PromotedCategory = Process;
                    // Enabled = (ATMLines."To Branch" = true) and (ATMLines.Received = false);

                    trigger OnAction()
                    var
                    // ATMLines: Record "ATM Inventory";
                    begin
                        if rec.Status = rec.Status::Approved then begin

                            // ATMLines.Reset();
                            // ATMLines.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                            // ATMLines.SetRange(Status, ATMLines.Status::"In Transit");
                            // ATMLines.SetRange(Received, true);
                            // if ATMLines.Find('-') then begin
                            //     repeat
                            //         ATMLines.Status := ATMLines.Status::Pending;
                            //         // ATMLines.Received := true;
                            //         ATMLines.Modify;
                            //     until ATMLines.Next = 0;
                            // end;
                        end;

                        CurrPage.Update;
                        MESSAGE('Cards Received!!')
                    end;
                }
                action(Returned)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Return;
                    Promoted = true;
                    PromotedCategory = Process;
                    // Enabled = (ATMLines."To HQ" = true) and (ATMLines.Discarded = false);

                    trigger OnAction()
                    var
                    // ATMLines: Record "ATM Inventory";
                    begin
                        if rec.Status = rec.Status::Approved then begin
                            // ATMLines.Reset();
                            // ATMLines.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                            // ATMLines.SetRange(Status, ATMLines.Status::Pending);
                            // ATMLines.SetRange("To HQ", true);
                            // if ATMLines.Find('-') then begin
                            //     repeat
                            //         ATMLines.Status := ATMLines.Status::Returned;
                            //         ATMLines.Modify;
                            //     until ATMLines.Next = 0;
                            // end;
                        end;
                        CurrPage.Update;
                        MESSAGE('Cards Returned!!')
                    end;
                }

                action(Discard)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Return;
                    Promoted = true;
                    PromotedCategory = Process;
                    // Enabled = (ATMLines."To HQ" = true) and (ATMLines.Discarded = false);

                    trigger OnAction()
                    var
                    // ATMLines: Record "ATM Inventory";
                    begin
                        if rec.Status = rec.Status::Approved then begin
                            // ATMLines.Reset();
                            // ATMLines.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                            // ATMLines.SetRange(Status, ATMLines.Status::Pending);
                            // ATMLines.SetRange("To HQ", true);
                            // if ATMLines.Find('-') then begin
                            //     repeat
                            //         ATMLines.Status := ATMLines.Status::Discarded;
                            //         ATMLines.Modify;
                            //     until ATMLines.Next = 0;
                            // end;
                        end;
                        CurrPage.Update;
                        MESSAGE('Cards Discarded!!')
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        if Rec.Status <> Rec.Status::Open then
                            Error(DocMustbeOpen);

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        if Rec.Status <> Rec.Status::Pending then
                            Error(DocMustbePending);

                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    // var
                    //     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    // begin
                    //     // ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    // end;
                    begin

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
    end;

    trigger OnAfterGetRecord()
    begin
        //SetControlAppearance;
        // UpdateControl;

        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
    end;

    trigger OnInit()
    begin
        // UpdateControl;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin

        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        DocMustbeOpen: Label 'This application request must be open';
        DocMustbePending: Label 'This application request must be Pending';
        TransType: Boolean;
        AccType: Boolean;
        AccNo: Boolean;
        DocNo: Boolean;
        Rmarks: Boolean;
        Amnt: Boolean;
        EmployerC: Boolean;
        IncType: Boolean;
        Pdate: Boolean;
        SalaryLines: Record "Salary Lines";
        LastloanDate: Boolean;
    // ATMLines: Record "ATM Inventory";


}

