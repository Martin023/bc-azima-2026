page 52186334 "Delegate Change Cards"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Delegate Region Mem Retirement";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = PageEditable;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegate Region"; Rec."Delegate Region")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegate Region Description"; Rec."Delegate Region Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Electoral Zone"; Rec."Electoral Zone")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Electoral Zone Name"; Rec."Electoral Zone Name")
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
                field(County; Rec.County)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("County Name"; Rec."County Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sub-County"; Rec."Sub-County")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sub-County Name"; Rec."Sub-County Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reason for retirement"; Rec."Reason for retirement")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
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
                field("Delegates Retired"; Rec."Delegates Retired")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control11; "Delegate Retire Memberss")
            {
                ApplicationArea = Basic, Suite;
                Editable = pageEditable;
                SubPageLink = Code = FIELD("Delegate Region");
                Visible = Rec."Reason for retirement" <> Rec."Reason for retirement"::Transfer;
            }
            part("Delegate Transfer"; "Delegate  Memberss Transfer")
            {
                ApplicationArea = Basic, Suite;
                Editable = pageEditable;
                SubPageLink = Code = FIELD("Delegate Region");
                Visible = Rec."Reason for retirement" = Rec."Reason for retirement"::Transfer;
            }
        }
    }

    actions
    {
        area(creation)
        {
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
                        Rec.TestField("Reason for retirement");
                        Found := false;
                        FoundDate := false;

                        if not LinesExists then
                            Error('There are no Lines created for this Document');
                        if Rec."Reason for retirement" <> Rec."Reason for retirement"::Transfer then begin
                            ChangeLine.Reset;
                            ChangeLine.SetRange(Code, Rec."Delegate Region");
                            if ChangeLine.Find('-') then begin
                                repeat
                                    if Found = false then begin

                                        if (ChangeLine.Retired = false) and (ChangeLine.Reinstate = false) then Found := true;//ERROR('Kindly Select Action on Lines');
                                                                                                                              //MESSAGE('%1',Found);
                                    end;
                                    if FoundDate = false then begin
                                        if (ChangeLine.Retired = true) and (ChangeLine."Retirement Date" = 0D) then FoundDate := true;

                                        // ERROR('Specify Retirement Date');

                                        if (ChangeLine.Reinstate = true) and (ChangeLine."Reinstatement Date" = 0D) then FoundDate := true;
                                    end;
                                //THEN ERROR('Specify Reinstatement Date');
                                until ChangeLine.Next = 0;
                            end;

                            //IF Found=FALSE THEN
                            //ERROR('Kindly Select Action on Lines');

                            //IF FoundDate=FALSE THEN
                            // ERROR('Specify Reinstatement Date');

                        end;
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
                    // CustomApprovals: Codeunit "Custom Approvals Codeunit";
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
                    // ApprovalsMgmt: Codeunit 1535;
                    begin
                        /*
                        DocumentType := DocumentType::"Payment Voucher";
                        ApprovalEntries.SetRecordFilters(DATABASE::"Payments Header","Document Type","No.");
                        ApprovalEntries.RUN;
                        */
                        //   ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId)

                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                    //   ApprovalsMgmt: Codeunit 1535;
                    begin
                        Rec.TestField(Effected, false);
                        if not Confirm('Are you sure you want to reopen this document?') then
                            exit;
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
                action("Cancel Document")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::Rejected;
                        Rec.Modify;
                    end;
                }
                action(Approve)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    // ApprovalsMgmt: Codeunit 1535;
                    begin
                        //   ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId)
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
                    var
                    //   ApprovalsMgmt: Codeunit 1535;
                    begin
                        //  // ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    //   ApprovalsMgmt: Codeunit 1535;
                    begin
                        //   ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    // RunObject = Page "Approval Comments";
#pragma warning disable AL0171
                    // RunPageLink = "Table ID" = CONST(52185888),
                    //"Document No." = FIELD("No. Series");
#pragma warning restore AL0171
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
                action("Register Delegates")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Add;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Effected, false);
                        Rec.TestField(Status, Rec.Status::Approved);
                        ChangeLine.Reset;
                        ChangeLine.SetRange(Code, Rec."Delegate Region");
                        ChangeLine.SetRange(Appoint, true);
                        ChangeLine.SetRange(Reinstate, false);
                        ChangeLine.SetRange(Retired, false);
                        if ChangeLine.Find('-') then begin
                            if (ChangeLine."Appointment Date" = 0D) then Error('Appointment date Must be specified');

                        end;




                        if not Confirm('Are you sure you want to register the selected delegates?') then
                            exit;
                        DelegateMembersRetirementss.Reset;
                        DelegateMembersRetirementss.SetRange(DelegateMembersRetirementss.Code, Rec."Delegate Region");
                        DelegateMembersRetirementss.SetRange(Retired, true);
                        if DelegateMembersRetirementss.Find('-') then begin
                            repeat
                                DelegateMemberss.Reset;
                                DelegateMemberss.SetRange(DelegateMemberss."Delegate MNO.", DelegateMembersRetirementss."Delegate MNO.");
                                //DelegateMemberss.SETRANGE("Entry No","Entry No");
                                DelegateMemberss.SetFilter(Retired, '=%1', false);
                                if DelegateMemberss.Find('-') then begin
                                    repeat
                                        DelegateMemberss."Retire Date" := Today;
                                        DelegateMemberss."Reason for retirement" := Rec."Reason for retirement";
                                        DelegateMemberss.Retired := true;
                                        DelegateMemberss."Retired By" := UserId;
                                        DelegateMemberss."Appointment Date" := DelegateMembersRetirementss."Appointment Date";
                                        DelegateMemberss.Modify;
                                    until DelegateMemberss.Next = 0;
                                end;// ELSE
                            until DelegateMembersRetirementss.Next = 0;
                        end;


                        DelegateMembersRetirement.Reset;
                        DelegateMembersRetirement.SetRange(DelegateMembersRetirement.Code, Rec."Delegate Region");
                        DelegateMembersRetirement.SetRange(Retired, false);
                        if DelegateMembersRetirement.Find('-') then begin
                            repeat
                                DelegateMember.Reset;
                                DelegateMember.SetRange(DelegateMember."Delegate MNO.", DelegateMembersRetirement."Delegate MNO.");
                                DelegateMember.SetRange(DelegateMember.Retired, false);
                                if not DelegateMember.Find('-') then begin
                                    repeat
                                        DelegateMember.Init;
                                        DelegateMember.Code := Rec."Delegate Region";
                                        DelegateMember."Delegate Name" := DelegateMembersRetirement."Delegate Name";
                                        DelegateMember."Delegate MNO." := DelegateMembersRetirement."Delegate MNO.";
                                        DelegateMember."Job Tittle" := DelegateMembersRetirement."Job Tittle";
                                        DelegateMember.Position := DelegateMembersRetirement.Position;
                                        DelegateMember."Service Period" := DelegateMembersRetirement."Service Period";
                                        DelegateMember."Appointment Date" := DelegateMembersRetirement."Appointment Date";
                                        DelegateMember.Status := DelegateMembersRetirement.Status;
                                        DelegateMember.Insert;
                                    until DelegateMember.Next = 0;
                                end;
                            until DelegateMembersRetirement.Next = 0;
                        end;
                        Rec."Delegates Retired" := true;
                        Rec.Effected := true;
                        Rec.Modify;
                        Message('Delegates has been Registered');
                    end;
                }
                action("Retire Delegates")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Effected, false);

                        Rec.TestField(Status, Rec.Status::Approved);
                        ChangeLine.Reset;
                        ChangeLine.SetRange(Code, Rec."Delegate Region");
                        if ChangeLine.Find('-') then begin
                            if (ChangeLine.Retired = true) and (ChangeLine."Retirement Date" = 0D) then Error('Specify Retirement Date');
                        end;




                        if not Confirm('Are you sure you want to retire the selected delegates?') then
                            exit;
                        MemRetirement.Reset;
                        MemRetirement.SetRange(Code, Rec.Code);
                        MemRetirement.SetRange("Delegate Region", Rec."Delegate Region");
                        if MemRetirement.Find('-') then begin
                            DelegateMembersRetirementss.Reset;
                            DelegateMembersRetirementss.SetRange(DelegateMembersRetirementss.Code, Rec."Delegate Region");
                            DelegateMembersRetirementss.SetFilter(Retired, '=%1', true);
                            if DelegateMembersRetirementss.Find('-') then begin
                                repeat
                                    DelegateMemberss.Reset;
                                    DelegateMemberss.SetRange(DelegateMemberss."Delegate MNO.", DelegateMembersRetirementss."Delegate MNO.");
                                    //DelegateMemberss.SETRANGE("Entry No","Entry No");
                                    DelegateMemberss.SetFilter(Retired, '=%1', false);
                                    if DelegateMemberss.Find('-') then begin
                                        repeat
                                            // DelegateMemberss."Retire Date":=TODAY;
                                            DelegateMemberss."Reason for retirement" := Rec."Reason for retirement";
                                            DelegateMemberss.Retired := true;
                                            DelegateMemberss."Retired By" := UserId;
                                            DelegateMemberss."Retirement Date" := DelegateMembersRetirementss."Retirement Date";
                                            DelegateMemberss.Modify;
                                        until DelegateMemberss.Next = 0;
                                    end;// ELSE
                                until DelegateMembersRetirementss.Next = 0;
                            end;

                            DelegateMembersRetirement.Reset;
                            DelegateMembersRetirement.SetRange(DelegateMembersRetirement.Code, Rec."Delegate Region");
                            DelegateMembersRetirement.SetRange(Retired, false);
                            if DelegateMembersRetirement.Find('-') then begin
                                repeat
                                    DelegateMember.Reset;
                                    DelegateMember.SetRange(DelegateMember."Delegate MNO.", DelegateMembersRetirement."Delegate MNO.");
                                    DelegateMember.SetRange(DelegateMember.Retired, false);
                                    if not DelegateMember.Find('-') then begin
                                        repeat
                                            DelegateMember.Init;
                                            DelegateMember.Code := Rec."Delegate Region";
                                            DelegateMember."Delegate Name" := DelegateMembersRetirement."Delegate Name";
                                            DelegateMember."Delegate MNO." := DelegateMembersRetirement."Delegate MNO.";
                                            DelegateMember."Job Tittle" := DelegateMembersRetirement."Job Tittle";
                                            DelegateMember.Position := DelegateMembersRetirement.Position;
                                            DelegateMember."Service Period" := DelegateMembersRetirement."Service Period";
                                            DelegateMember."Appointment Date" := DelegateMembersRetirement."Appointment Date";
                                            DelegateMember.Status := DelegateMembersRetirement.Status;
                                            DelegateMember.Insert;
                                        until DelegateMember.Next = 0;
                                    end;
                                until DelegateMembersRetirement.Next = 0;
                            end;
                        end;
                        Rec."Delegates Retired" := true;
                        Rec.Effected := true;
                        Rec.Modify;
                        Message('Delegate has been Retired');
                    end;
                }
                action("Reinstate Delegate")
                {
                    ApplicationArea = Basic, Suite;
                    Image = AddContacts;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if (Rec.Effected = true) and (Rec."Delegates Retired" = false) then begin
                            Rec."Delegates Retired" := true;
                            Rec.Modify;
                        end else
                            Rec.TestField(Effected, false);
                        Rec.TestField(Status, Rec.Status::Approved);

                        ChangeLine.Reset;
                        ChangeLine.SetRange(Code, Rec."Delegate Region");
                        if ChangeLine.Find('-') then begin

                            if (ChangeLine.Reinstate = true) and (ChangeLine."Reinstatement Date" = 0D) then Error('Specify Reinstatement Date');
                        end;



                        if not Confirm('Are you sure you want to Reinstate  the selected delegates?') then
                            exit;

                        DelegateMembersRetirement.Reset;
                        DelegateMembersRetirement.SetRange(DelegateMembersRetirement.Code, Rec."Delegate Region");
                        DelegateMembersRetirement.SetRange(Reinstate, true);
                        DelegateMembersRetirement.SetRange(Retired, false);
                        if DelegateMembersRetirement.Find('-') then begin
                            repeat
                                DelegateMember.Reset;
                                DelegateMember.SetRange(DelegateMember."Delegate MNO.", DelegateMembersRetirement."Delegate MNO.");
                                DelegateMember.SetRange(Retired, true);
                                if DelegateMember.Find('-') then begin
                                    repeat
                                        DelegateMember.Position := DelegateMembersRetirement.Position;
                                        DelegateMember.Retired := DelegateMembersRetirement.Retired;
                                        DelegateMember."Reinstatement Date" := DelegateMembersRetirement."Reinstatement Date";
                                        DelegateMember.Modify;
                                    until DelegateMember.Next = 0;
                                end;
                            until DelegateMembersRetirement.Next = 0;
                        end;

                        Rec.Effected := true;
                        Rec."Delegates Retired" := true;
                        Rec.Modify;
                        Message('Delegates has been Reinstated');
                    end;
                }
                action("Transfer Delegates")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Add;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Effected, false);
                        Rec.TestField(Status, Rec.Status::Approved);
                        ChangeLine.Reset;
                        ChangeLine.SetRange(Code, Rec."Delegate Region");
                        ChangeLine.SetRange(Reinstate, false);
                        ChangeLine.SetRange(Retired, false);
                        ChangeLine.SetRange(Transfer, true);
                        if ChangeLine.Find('-') then begin
                            if (ChangeLine."Tranfer Date" = 0D) then Error('Transfer date Must be specified');

                        end;


                        if not Confirm('Are you sure you want to retire the selected delegates?') then
                            exit;
                        MemRetirement.Reset;
                        MemRetirement.SetRange(Code, Rec.Code);
                        MemRetirement.SetRange("Delegate Region", Rec."Delegate Region");
                        if MemRetirement.Find('-') then begin
                            DelegateMembersRetirementss.Reset;
                            DelegateMembersRetirementss.SetRange(DelegateMembersRetirementss.Code, Rec."Delegate Region");
                            DelegateMembersRetirementss.SetFilter(Transfer, '=%1', true);
                            if DelegateMembersRetirementss.Find('-') then begin
                                repeat
                                    DelegateMemberss.Reset;
                                    DelegateMemberss.SetRange(DelegateMemberss."Delegate MNO.", DelegateMembersRetirementss."Delegate MNO.");
                                    DelegateMemberss.SetFilter(Retired, '=%1', false);
                                    if DelegateMemberss.Find('-') then begin
                                        repeat
                                            DelegateMemberss."Reason for retirement" := Rec."Reason for retirement";
                                            DelegateMemberss.Retired := true;
                                            DelegateMemberss."Retired By" := UserId;
                                            DelegateMemberss."Retirement Date" := DelegateMembersRetirementss."Tranfer Date";
                                            DelegateMemberss.Modify;
                                        until DelegateMemberss.Next = 0;
                                    end;// ELSE
                                until DelegateMembersRetirementss.Next = 0;
                            end;

                        end;
                        Rec."Delegates Retired" := true;
                        Rec.Modify;
                        //MESSAGE('Delegate has been Retired');
                        if not Confirm('Are you sure you want to Transfer the selected delegates?') then
                            exit;

                        DelegateMembersRetirement.Reset;
                        DelegateMembersRetirement.SetRange(Transfer, true);
                        if DelegateMembersRetirement.Find('-') then begin
                            repeat
                                DelegateMember.Reset;
                                DelegateMember.SetRange(DelegateMember."Delegate MNO.", DelegateMembersRetirement."Delegate MNO.");
                                DelegateMember.SetRange(DelegateMember.Retired, false);
                                if not DelegateMember.Find('-') then begin
                                    repeat
                                        DelegateMember.Init;
                                        DelegateMember.Code := DelegateMembersRetirement."Tranfer To";
                                        DelegateMember."Delegate Name" := DelegateMembersRetirement."Delegate Name";
                                        DelegateMember."Delegate MNO." := DelegateMembersRetirement."Delegate MNO.";
                                        DelegateMember."Appointment Date" := DelegateMembersRetirement."Tranfer Date";
                                        DelegateMember."Job Tittle" := DelegateMembersRetirement."Job Tittle";
                                        DelegateMember.Position := DelegateMembersRetirement."Transfer to Position";
                                        DelegateMember.Status := DelegateMembersRetirement.Status;
                                        DelegateMember.Insert;
                                    until DelegateMember.Next = 0;
                                end;
                            until DelegateMembersRetirement.Next = 0;
                        end;
                        Rec.Effected := true;
                        Rec."Delegates Retired" := true;
                        Rec.Modify;
                        Message('Delegates has been Registered');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        HasLines: Boolean;
        PageEditable: Boolean;
        DelegateMembersRetirementss: Record "Delegate Members Retirementss";
        DelegateMemberss: Record "Delegate Members";
        DelegateMembersRetirement: Record "Delegate Members Retirementss";
        DelegateMember: Record "Delegate Members";
        DelegateMembers: Record "Delegate Members";
        MemRetirement: Record "Delegate Region Mem Retirement";
        ChangeLine: Record "Delegate Members Retirementss";
        Found: Boolean;
        FoundDate: Boolean;

    //[Scope('OnPrem')]
    procedure LinesExists(): Boolean
    var
        PayLines: Record "Delegate Members Retirementss";
    begin
        HasLines := false;
        PayLines.Reset;
        PayLines.SetRange(PayLines.Code, Rec."Delegate Region");
        if PayLines.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
        Rec.TestField("Reason for retirement");
    end;

    //[Scope('OnPrem')]
    procedure UpdateControls()
    begin
        if Rec.Status <> Rec.Status::Open then
            PageEditable := false else
            PageEditable := true;
    end;
}

