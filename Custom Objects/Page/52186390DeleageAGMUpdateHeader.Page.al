page 52186390 "Deleage AGM Update Header"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Delegate AGM Update Header";



    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("AGM Year"; Rec."AGM Year")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Update Type"; Rec."Update Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control6; "Delegate Retire Lines")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No.");
                Visible = Rec."Update Type" = Rec."Update Type"::Retire;
            }
            part(Control7; "Delegate Appoint  Lines")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No.");
                Visible = Rec."Update Type" = Rec."Update Type"::Appoint;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Retire Deleagtes")
            {
                ApplicationArea = Basic, Suite;
                Image = BOMLedger;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = Rec."Update Type" = Rec."Update Type"::Retire;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField(Updated, false);
                    DelegateRetireUpdate.Reset;
                    DelegateRetireUpdate.SetRange("No.", Rec."No.");
                    if DelegateRetireUpdate.Find('-') then begin
                        repeat
                            DelegateMemberss.Reset;
                            DelegateMemberss.SetRange("Delegate MNO.", DelegateRetireUpdate."Delegate MNO.");
                            DelegateMemberss.SetRange(Code, DelegateRetireUpdate.Code);
                            if DelegateMemberss.Find('-') then begin
                                DelegateRetireUpdate.Tracker(DelegateMemberss);
                            end;
                        until DelegateRetireUpdate.Next = 0;
                    end;
                end;
            }
            action("Import Retired Delegate")
            {
                ApplicationArea = Basic, Suite;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ////RunObject = XMLport "Import Retired Delegated";
                Visible = Rec."Update Type" = Rec."Update Type"::Retire;
            }
            action("Update New Deleagtes")
            {
                ApplicationArea = Basic, Suite;
                Image = BOMLedger;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = Rec."Update Type" = Rec."Update Type"::Appoint;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField(Updated, false);
                    DelegateAppointUpdate.Reset;
                    DelegateAppointUpdate.SetRange("No.", Rec."No.");
                    if DelegateAppointUpdate.Find('-') then begin
                        repeat
                            DelegateMemberss.Reset;
                            Eno := DelegateMemberss.Count;
                            DelegateMemberss.SetRange("Delegate MNO.", DelegateAppointUpdate."Delegate MNO.");
                            DelegateMemberss.SetRange(Retired, false);
                            if not DelegateMemberss.Find('-') then begin
                                //DelegateAppointUpdate.Tracker(DelegateMemberss);
                                Eno += 1;
                                DelegateMemberss.Init;
                                DelegateMemberss.Code := DelegateAppointUpdate.Code;
                                DelegateMemberss."Entry No" := Eno;
                                DelegateMemberss."Delegate MNO." := DelegateAppointUpdate."Delegate MNO.";
                                DelegateMemberss."Delegate Name" := DelegateAppointUpdate."Delegate Name";
                                DelegateMemberss."Job Tittle" := DelegateAppointUpdate."Job Tittle";
                                DelegateMemberss.Position := DelegateAppointUpdate.Position;
                                DelegateMemberss."Appointment Date" := DelegateAppointUpdate."Appointment Date";
                                DelegateMemberss."Registered By" := UserId;
                                DelegateMemberss."ID No." := DelegateAppointUpdate."ID No.";
                                DelegateMemberss.Insert;
                            end;

                        until DelegateAppointUpdate.Next = 0;
                        Rec.Updated := true;
                        Rec.Modify;
                    end;
                end;
            }
            action("Import New Delegate")
            {
                ApplicationArea = Basic, Suite;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ////RunObject = XMLport "Import New Delegated";
                Visible = Rec."Update Type" = Rec."Update Type"::Appoint;
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
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                    // ApprovalsMgmt: Codeunit 1535;
                    // CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    begin
                        Rec.TestField(Updated, false);
                        VarVariant := Rec;
                        // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        //     CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                    // ApprovalsMgmt: Codeunit 1535;
                    //  CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    begin
                        VarVariant := Rec;
                        //  CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
            }
            group(Navigate)
            {
                Caption = 'Navigate';
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                    //// //ApprovalEntries: Page "Approval Entries";
                    //  ApprovalsMgmt: Codeunit 1535;
                    begin

                        // ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId)
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.Updated = true then CurrPage.Editable := false;
        if Rec.Status <> Rec.Status::Open then CurrPage.Editable := false;
        SetControlAppearance;
    end;

    var
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;

        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        DelegateRetireUpdate: Record "Delegate AGM Retire Update";
        DelegateMemberss: Record "Delegate Members";
        DelegateAppointUpdate: Record "Delegate AGM Appoint Update";
        Eno: Integer;

    local procedure SetControlAppearance()
    var
    // ApprovalsMgmt: Codeunit 1535;
    begin
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

