page 52186120 "Surety Management Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Surety Management";
    PromotedActionCategories = 'New, Report, Process, Approval, Case Forwarding';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Surety No"; Rec."Surety No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                    Editable = SuretyEditable;
                }
                // field("Type Of Account"; Rec."Type Of Account")
                // {
                //     ApplicationArea = Basic;
                //     Editable = SuretyEditable;
                // }
                field("Account No"; Rec."Account No")
                {
                    Caption = 'Member No.';
                    ApplicationArea = Basic;
                    Editable = SuretyEditable;
                }
                //field("Account Name"; Rec."Account Name")
                field("Member Name"; Rec."Member Name")
                {
                    Caption = 'Member Name';
                    ApplicationArea = Basic;
                    //Editable = SuretyEditable;
                    Editable = false;
                }
                // field("Member No"; Rec."Member Account No")
                // {
                //     Caption = 'Member No.';
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                field("BOSA Acc No."; Rec."BOSA Acc No.")
                {
                    Caption = 'BOSA Acc No.';
                    ApplicationArea = Basic;
                    Editable = False;
                }
                field("BOSA A/c Status"; Rec."BOSA A/c Status")
                {
                    Caption = 'BOSA A/c Status';
                    ApplicationArea = Basic;
                    Editable = False;
                }
                field("Deposit Balance"; Rec.Amount)
                {
                    Caption = 'BOSA Deposit Balance';
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Shows the value of the BOSA deposits available balance';
                }
                field("Liabilities"; Rec."Outstanding Balance")
                {
                    Caption = 'Liabilities (BOSA)';
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = Basic;
                    Editable = False;
                }
                field("Surety Amount"; Rec."Surety Amount")
                {
                    ApplicationArea = Basic;
                    Editable = SuretyEditable;
                }
                // field("Member Name"; Rec."Member Name")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                field(Accused; Rec.Accused)
                {
                    ApplicationArea = Basic;
                    Editable = SuretyEditable;
                }
                // field("Refference No"; Rec."Refference No")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Refference Details"; Rec."Refference Details")
                // {
                //     ApplicationArea = Basic;
                // }

                // field(Type; Rec.Type)
                // {
                //     ApplicationArea = Basic;
                // }

                field("Court Name"; Rec."Court Name")
                {
                    ApplicationArea = Basic;
                    Editable = SuretyEditable;
                }
                field("Court Address"; Rec."Court Address")
                {
                    ApplicationArea = Basic;
                    Editable = SuretyEditable;
                }
                field("Court Physical Address"; Rec."Court Physical Address")
                {
                    Caption = 'Court Physical Address';
                    ApplicationArea = Basic;
                    Editable = SuretyEditable;
                }
                // field(Court; Rec.Court)
                // {
                //     ApplicationArea = Basic;
                // }
                field("Case No"; Rec."Case No")
                {
                    ApplicationArea = Basic;
                    Editable = SuretyEditable;
                }
                field("Name of Case"; Rec."Name of Case")
                {
                    Caption = 'Name of Case';
                    ApplicationArea = Basic;
                    Editable = SuretyEditable;
                }
                field(Summary; Rec.Summary)
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                    Editable = SuretyEditable;
                }
                field(Signatory; Rec.Signatory)
                {
                    ApplicationArea = Basic;
                    //Editable = SuretyEditable;
                    Editable = EditableApproved;
                    trigger OnValidate()
                    var
                        myInt: Integer;

                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                    end;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                Field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created At"; Rec."Created At")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    trigger OnValidate()
                    begin
                        UpdatePageControls;
                    end;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("SMS Sent"; Rec."SMS Sent")
                {
                    //Visible = VisibleOnPosting;
                    Editable = false;
                }
            }
            // group("Case Forwarding")
            // {
            //     Editable = ForwardingEditable;
            //     field("Send/Forward to"; Rec."Send/Forward to")
            //     {
            //         Editable = ForwardingEditable;
            //     }
            //     field("Originating Department"; Rec."Originating Department")
            //     {
            //         Editable = false;
            //     }
            //     field("Current Departmrnt"; Rec."Current Departmrnt")
            //     {
            //         Editable = false;
            //     }
            // }
            group(Comments)
            {
                field(Control35; Rec.Comment)
                {
                    ApplicationArea = Basic;
                    Editable = SuretyEditable;
                    MultiLine = true;
                }
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")//"Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = Const(52185964), "No." = field("Surety No");
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                // action(Comment)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Comments';
                //     Image = ViewComments;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     RunObject = Page "Approval Comments";
                //     Visible = OpenApprovalEntriesExistForCurrUser;
                // }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField("Account No");
                        Rec.TestField("Surety Amount");
                        Rec.TestField("Name of Case");
                        Rec.TestField("Summary");
                        Rec.TestField("Accused");
                        Rec.TestField("Court Name");
                        REc.TestField("Court Address");
                        Rec.TestField("Court Physical Address");

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }

            // action("Surety Letter Issue")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Surety Letter Issue';
            //     Image = AddToHome;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Visible = false;

            //     trigger OnAction()
            //     begin
            //         SuretyHeld.Get(SavingsAccounts."Member No.");
            //         begin
            //             if SuretyHeld.Status = SuretyHeld.Status::Approved then 
            //             begin
            //                 SuretyHeld.Init();
            //                 SuretyHeld."Record No." := Rec."Surety No";
            //                 SuretyHeld."Member No." := Rec."Account No";
            //                 //SuretyHeld."Interest Amount" := GuarantorInterestPayments;
            //                 //SuretyHeld."Principal Amount" := GuarantorPrinciplePayments;
            //                 SuretyHeld.Total := Rec."Surety Amount";
            //                 //SuretyHeld.Total := GuarantorInterestPayments + GuarantorPrinciplePayments;
            //                 SuretyHeld."Funds Status" := SuretyHeld."Funds Status"::WithHeld;
            //                 SuretyHeld.Type := SuretyHeld.Type::Surety;
            //                 SuretyHeld."Entry Date" := CurrentDateTime;
            //                 SuretyHeld."Created By" := UserId;
            //                 SuretyHeld.Insert();
            //             end;
            //         end;  
            //     end;
            // }
            // action("Deattach Surety Letter Issue")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Deattach Surety Letter Issue';
            //     Image = Accounts;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Visible = false;

            //     trigger OnAction()
            //     begin
            //         Rec.TestField(Comment);
            //         Member.Reset;
            //         Member.SetRange(Member."No.", Rec."Member Account No");
            //         // if Member.Find('-') then
            //         //     Member."Surety Letter Issued" := false;
            //         Member.Modify;
            //         Rec."Stopped USER ID" := UserId;
            //         Rec."Stopped Date" := Today;
            //         Rec."Stopped Time" := Time;
            //     end;
            // }
            group(Process)
            {
                action("Surety Letter")
                {

                    ApplicationArea = Basic;
                    Caption = 'Issue Surety Letter';
                    Image = AddToHome;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    trigger OnAction()
                    begin
                        //Rec.TestField(Status, Rec.Status::Approved);
                        Surety.Reset();
                        Surety.SetRange("Surety No", Rec."Surety No");
                        if Surety.Find('-') then begin
                            if Rec.Signatory = Rec.Signatory::" " then
                                Error('Please Select A Signatory')
                            else
                                if Rec.Signatory = Rec.Signatory::"C.E.O" then begin
                                    Report.Run(Report::"Instruction Template - Surety", true, false, Surety);
                                end;
                            if Rec.Signatory = Rec.Signatory::"Company Secretary" then begin
                                Report.RUN(Report::"Surety Instruction Template LO", true, false, Surety)
                            end;
                        end
                    end;
                }
                action("Append Signature")
                {
                    ApplicationArea = Basic;
                    Caption = 'Append Signature';
                    Image = AddToHome;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        if Rec.Status = Rec.Status::Approved then begin
                            if Rec.Signatory = Rec.Signatory::" " then
                                Message('Please Select A Signatory!')
                        end
                        else
                            Error('You can only Append Signature to approved Document');
                    end;
                }
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
                        SuretyHeld: Record "One Month Installment";

                    //begin
                    // Rec.Testfield(Status, Rec.Status::Approved);
                    // REc.TestField(Posted, false);
                    // SavingsAccounts.Reset;
                    // SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                    // SavingsAccounts.SetRange("Member No.", Rec."Account No");
                    // if SavingsAccounts.Get(SavingsAccounts."No.") then
                    //     ///GlobalFunctions.HoldSurety(rec."Surety No", SavingsAccounts."No.", rec."Account No", /*SavingsAccounts."No.",*/ 0, 0, rec."Surety Amount", SuretyHeld.Type::Surety);
                    // begin
                    //     Rec.Posted := true;
                    //     Rec.Modify;
                    //     if Rec.Posted = true then begin
                    //         Message('Surety Posted Successfully!');
                    //     end;
                    // end;
                    //end;
                    begin
                        If not Confirm('Are you sure you want to post this Surety?') then
                            exit;
                        Rec.Testfield(Status, Rec.Status::Approved);
                        REc.TestField(Posted, false);
                        if Rec."Surety Amount" > Rec.Amount then
                            Error('Member does not have enough deposits to cover the surety amount!')
                        else
                            SavingsAccounts.Reset;
                        SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                        SavingsAccounts.SetRange("Member No.", Rec."Account No");
                        //if SavingsAccounts.Find('-') then
                        if SavingsAccounts.Get(SavingsAccounts."No.") then
                            //GlobalFunctions.HoldSurety(rec."Surety No", SavingsAccounts."No.", rec."Account No", 0, 0, rec."Surety Amount");

                        SuretyHeld.Get(SavingsAccounts."Member No.");
                        begin
                            SuretyHeld.Init();
                            SuretyHeld."Record No." := Rec."Surety No";
                            SuretyHeld."Member No." := Rec."Account No";
                            SuretyHeld."Account No." := Rec."BOSA Acc No.";
                            SuretyHeld.Total := Rec."Surety Amount";
                            SuretyHeld."Funds Status" := SuretyHeld."Funds Status"::WithHeld;
                            SuretyHeld.Type := SuretyHeld.Type::Surety;
                            SuretyHeld."Entry Date" := CurrentDateTime;
                            SuretyHeld."Created By" := UserId;
                            SuretyHeld."Responsibility Center" := Rec."Responsibility Center";
                            SuretyHeld."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                            SuretyHeld."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                            SuretyHeld.Insert();
                        end;
                        REc.Posted := true;
                        Rec.Modify;
                        Members.RESET;
                        Members.SETRANGE("No.", Rec."Account No");
                        if Members.Find('-') then begin
                            if Members."Phone No." <> '' then begin
                                if Confirm('Do you want to send an SMS to the Member?') then
                                    msg := 'Dear, ' + Rec."Member Name" + ', this is to formally inform you that the request for surety to be placed for ' + Rec.Accused + ' has been approved. Please visit the nearest branch for more information.';
                                SendSMS.SendSms(Source::"Surety", Members."Phone No.", msg, ' ', ' ', false, 0, false, 'CBS', Rec."Surety No", 'CBS', Rec."Date");
                            end
                            else begin
                                msg := 'Dear, ' + Rec."Member Name" + ', \this is to formally inform you that the ';
                                SendSMS.SendSms(Source::"Surety", Members."Transactional Mobile Number", msg, ' ', ' ', false, 0, false, 'CBS', Rec."Surety No", 'CBS', Rec."Date");
                            end
                        end;

                        Message('Surety Posted Successfully!');
                        Rec."SMS Sent" := true;
                        Rec.Modify;
                    end;
                }
                //action("Unblock Deposits")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Unblock Deposits';
                //     Image = Post;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     trigger OnAction()
                //     var
                //         myInt: Integer;
                //         GlobalFunctions: Codeunit "Global Functions";
                //         HoldType: Enum "Funds Witheld Types";
                //         SuretyHeld: Record "One Month Installment";
                //     begin
                //         Rec.Testfield(Status, Rec.Status::Approved);
                //         REc.TestField(Posted, true);
                //         SuretyHeld.Reset();
                //         SuretyHeld.SetRange("Record No.", Rec."Account No");
                //         SuretyHeld.SetRange(Type, HoldType::Surety);
                //         if SuretyHeld.Find('-') then begin
                //             //GlobalFunctions.HoldSurety(rec."Surety No",rec."Account No", rec."Account No", 0, 0, rec."Surety Amount");
                //         end
                //     end;
                // }
            }
            // group("Document Forwarding")
            // {
            //     Caption = 'Document Forwarding';
            //     action("Document Comments")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Image = ViewComments;
            //         Promoted = true;
            //         PromotedCategory = Category5;

            //         RunObject = page "Comments List";
            //         RunPageLink = "Header No." = field("Surety No");
            //         RunPageView = where(Types = CONST(comment));
            //     }
            //     action("Send Case")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Image = SendTo;
            //         Promoted = true;
            //         PromotedCategory = Category5;
            //         // Visible = SendCaseVisible;

            //         trigger OnAction()
            //         var
            //         begin
            //             if Rec."Send/Forward to" = Rec."Current Departmrnt" then Error('You cannot send this document to %1 while its already in %1', Rec."Send/Forward to");
            //             Comments.Reset();
            //             Comments.SetRange("Header No.", Rec."Surety No");
            //             if Comments.FindLast() then begin
            //                 if Comments."Commented By" <> UserId then Error('Kindly leave a comment');
            //                 if Comments.Comment = '' then Error('Kindly leave a comment');
            //             end else
            //                 Error('Kindly add a comment');
            //             if not Confirm('Are you sure you want to send this case?') then exit;
            //             // Rec."Originator Status" := Rec."Originator Status"::Sent;
            //             // Rec."Recepient Status" := Rec."Recepient Status"::New;
            //             Rec."Current Departmrnt" := Rec."Send/Forward to";

            //             // if (CurrentUsersDept <> Rec."Originating Department") and (Rec."Send/Forward to" = Rec."Originating Department") then begin
            //             //     Rec."Originator Status" := Rec."Originator Status"::Returned;
            //             //     Rec."Recepient Status" := Rec."Recepient Status"::Returned;
            //             // end;
            //             CFPage.InsertTracker(Rec."Surety No", Rec."Send/Forward to", true, UserId, CurrentDateTime);
            //             Rec.Modify();
            //             Message('Case sent successfully');
            //         end;
            //     }
            //     action("Case Tracker")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Image = History;
            //         Promoted = true;
            //         PromotedCategory = Category5;

            //         RunObject = page "CF Tracker List";
            //         RunPageLink = "Header No." = field("Surety No");
            //     }
            // }
        }
    }
    trigger OnOpenPage();
    begin
        if UserSetup.Get(Rec."Created By") then begin
            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec."Responsibility Center" := UserSetup."Responsibility Centre";
            Rec."Created By" := UserId;
            Rec.SystemCreatedAt := CURRENTDATETIME;
            Rec.Modify;
        end;
        begin
            UpdatePageControls;
        end;
    end;



    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdatePageControls;
    end;


    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        Member: Record Members;
        SuretyHeld: Record "One Month Installment";
        SavingsAccounts: Record "Savings Accounts";
        UserSetup: Record "User Setup";
        Surety: Record "Surety Management";
        SuretyEditable: Boolean;
        EditableApproved: Boolean;
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
        ForwardingEditable: Boolean;
        VisibleOnPosting: Boolean;
        Members: Record Members;
        SendSMS: Codeunit SendSms;
        msg: Text;
        Source: enum "SMS Source";



    procedure UpdatePageControls()
    begin
        if Rec.Status = Rec.Status::Open then begin
            SuretyEditable := True;
            EditableApproved := True;
            ForwardingEditable := False;
        end
        else begin
            if Rec.Status = Rec.Status::Pending then begin
                SuretyEditable := True;
                EditableApproved := True;
                ForwardingEditable := False;
            end
            else begin
                if Rec.Status = Rec.Status::Approved then begin
                    SuretyEditable := False;
                    EditableApproved := True;
                    ForwardingEditable := True;
                end;
            end;
        end;
        begin
            if Rec.Posted = True then
                VisibleOnPosting := True
            else
                VisibleOnPosting := False;
        end;
    end;

    // begin
    //     if Rec.Status = Rec.Status::Open then begin
    //     SuretyEditable := True;
    //     end
    // else 
    // begin
    //     if Rec.Status = Rec.Status::Pending then begin
    //     SuretyEditable :=  True;
    //     end
    // end;
    // else
    // begin
    //     if Rec.Status = Rec.Status::Approved then begin
    //     SuretyEditable :=  False;
    //     end;
    // end;
    // end;
}

