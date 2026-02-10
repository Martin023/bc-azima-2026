page 52185854 "Member withdrawal Notice"
{
    PageType = Card;
    SourceTable = "Member withdrawal Notice";
    PromotedActionCategories = 'New,Process,Reports,Approvals,Member,Cancellation,Category7_caption,Reopen Document,Approval request,,File Upload';
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            // group(CRM)
            // {
            //     Visible = false;
            //     Caption = 'CRM Information';
            //     field("CRM Application No."; Rec."CRM Application No.")
            //     {
            //         Editable = false;
            //     }
            //     field("CRM Created By"; Rec."CRM Created By")
            //     {
            //         Editable = false;
            //     }
            //     field("CRM Originating Branch"; Rec."CRM Originating Branch")
            //     {
            //         Editable = false;
            //     }
            //     field("CRM Notes"; Rec."CRM Notes")
            //     {
            //         Editable = false;
            //         MultiLine = true;
            //     }
            //     field("Sent Back to CRM"; Rec."Sent Back to CRM")
            //     {
            //         Editable = false;
            //     }
            // }
            group(General)
            {
                Editable = MemNoEdit;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = MemNoEdit;

                    trigger OnValidate()
                    begin
                        Rec."Date Entered" := Today;
                        Rec."Date Modified" := Today;
                        Rec."Entered By" := UserId;
                        Rec."Time Entered" := Time;
                        Rec."Withdrawal Notice Date" := Today;
                        Rec.Validate("Withdrawal Notice Date");
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Notice Type"; Rec."Notice Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = NotTypeEdit;
                    Showmandatory = true;

                    trigger OnValidate()
                    begin
                        if Rec."Notice Type" = Rec."Notice Type"::"Withdrawal - Normal" then begin
                            PercEdit := false;
                            rec.Validate(Percentage, 100.00);

                        end
                        else begin
                            PercEdit := true;
                            rec.Validate(Percentage, 0.00);
                            rec."Amount To Refund" := 0;
                        end;
                    end;
                }
                field("Amount Refundable"; Rec."Amount Refundable")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Early Withdrawal"; Rec."Early Withdrawal")
                {
                    Editable = not PercEdit;
                    ApplicationArea = Basic, Suite;
                }
                field("Deposit At First Withdrwal"; rec."Deposit At First Withdrwal")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Total Partial Withdrawn Amount"; Rec."Total Partial Withdrawn Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    // Editable = NotTypeEdit;
                }
                field("Amount To Refund"; Rec."Amount To Refund")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = PercEdit;
                    // Editable = NotTypeEdit;
                }


                field("Employer Liability"; Rec."Employer Liability")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = MemNoEdit;

                    // Editable = NotTypeEdit;
                }
                field("Withdrawal Notice Date"; Rec."Withdrawal Notice Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = WithNotDate;
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("No. of Days Remaining"; Rec."No. of Days Remaining")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Reason for withdrawal"; Rec."Reason for withdrawal")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ROWEdit;
                    ShowMandatory = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Loans Outstanding Balance"; Rec."Loans Outstanding Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loans Outstanding Interest"; Rec."Loans Outstanding Interest")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Deposit"; Rec."Member Deposit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Closure Charges"; Rec."Closure Charges")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Branch Code';
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Activity Code';
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = RemarksEdit;
                    ShowMandatory = true;
                }
                field("Rejection Remarks"; Rec."Rejection Remarks")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = RejStatus;
                }
                field("Notice Finalized"; Rec."Notice Finalized")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notice Finalized field.';
                }
                field("Clossure Created"; Rec."Clossure Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Clossure Created field.';
                }
                field("Finalized By"; Rec."Finalized By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Finalized By field.';
                }
                field("DateTime Finalized"; Rec."DateTime Finalized")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DateTime Finalized field.';
                }
                // field(SLA; Rec.SLA)
                // {
                // }
            }
            // part("Attached Documents List"; "Doc. Attachment List Factbox")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Attached Documents';
            //     UpdatePropagation = Both;
            //     SubPageLink = "Table ID" = const(Database::"Member withdrawal Notice"),
            //                   "No." = field("No.");
            //     //"Document TyMem pe" = field("Document Type");
            // }
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
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = Rec."Clossure Created" = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Rejected) then
                            Error(DocMustbeOpen);

                        Rec.TestField("Reason for withdrawal");
                        Rec.TestField("Withdrawal Notice Date");
                        Rec.TestField("Notice Type");

                        // SavingsAccounts.RESET;
                        // SavingsAccounts.SETRANGE("Member No.", Rec."Member No.");
                        // SavingsAccounts.SETRANGE("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                        // IF SavingsAccounts.FIND('-') THEN BEGIN
                        //     LoanGuarantorsandSecurity.RESET;
                        //     LoanGuarantorsandSecurity.SETRANGE("Savings Account No./Member No.", SavingsAccounts."No.");
                        //     LoanGuarantorsandSecurity.SETRANGE(Substituted, FALSE);
                        //     LoanGuarantorsandSecurity.SETRANGE("Self Guarantee", FALSE);
                        //     IF LoanGuarantorsandSecurity.FIND('-') THEN BEGIN
                        //         REPEAT
                        //             IF Loans.GET(LoanGuarantorsandSecurity."Loan No") THEN BEGIN
                        //                 IF Loans."Member No." <> Rec."Member No." THEN BEGIN
                        //                     Loans.CALCFIELDS("Outstanding Balance");
                        //                     IF Loans."Outstanding Balance" > 0 THEN
                        //                         ERROR(Err001, LoanGuarantorsandSecurity."Loan No");
                        //                 END;
                        //             END;
                        //         UNTIL LoanGuarantorsandSecurity.NEXT = 0;
                        //     END;
                        // END;

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);

                        if Members.Get(Rec."Member No.") then begin
                            Members.Subflag := Members.Subflag::"Pending Withdrawal";
                            Members.Modify;
                            LogMemberSubStatus(Rec."Member No.", Members.Subflag::"Pending Withdrawal");
                        end;

                        CurrPage.close;


                        //delete Remarks
                        // Notice.Reset;
                        // Notice.SetRange(Notice."Member No.", Rec."Member No.");
                        // Notice.SetFilter(Notice.Status, '<>%1', Notice.Status::Rejected);
                        // if Notice.Find('-') then begin
                        //     Notice.Remarks := '';
                        //     Notice.Modify(true);
                        // end;

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
                    PromotedIsBig = true;
                    Visible = Rec."Clossure Created" = false;
                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        if Rec.Status <> Rec.Status::Pending then
                            Error(DocMustbePending);

                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        //// //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action(Cancel)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel/Archive';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Enabled = Rec."Clossure Created" = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        MemberSubflagLogs: Record "Member Sub-Status Tracker";
                    begin
                        Rec.TestField("Notice Finalized", false);

                        if Confirm('Are you sure you wish to archive this notice?', false) then begin
                            rec.Validate(Status, Rec.Status::Cancelled);
                            //rec.Status := rec.Status::Cancelled;
                            rec.Modify(true);
                            RevertPreviousSubflag(Rec."Member No.");
                            Message('Document Cancelled successfuly');
                            CurrPage.Close();
                        end;
                    end;
                    // end;
                }
                action(Commentss)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    Caption = 'Cancel/Archive Comments';
                    PromotedCategory = Category4;
                    Enabled = Rec.Status <> rec.Status::Cancelled;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }
                // action("Stop Advice")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Image = StopPayment;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     Visible = false;

                //     trigger OnAction()
                //     begin
                //         //Advice Stop

                //         if Rec.Status = Rec.Status::Approved then begin
                //             Loans.Reset;
                //             Loans.SetRange("Member No.", Rec."Member No.");
                //             Loans.SetRange("Recovery Mode", Loans."Recovery Mode"::Checkoff);
                //             Loans.SetFilter("Outstanding Balance", '>0');
                //             if Loans.Find('-') then begin
                //                 repeat
                //                     LoansProcess.AdviceLoan(Loans."Loan No.", true, Rec."No.");
                //                 until Loans.Next = 0;
                //             end;

                //             SavingsAccounts.Reset;
                //             SavingsAccounts.SetRange(SavingsAccounts."Member No.", Rec."Member No.");
                //             if SavingsAccounts.Find('-') then begin
                //                 repeat
                //                     if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"BOSA Deposits" then begin
                //                         //PeriodicAcc.EmplyerSavingAdvice(SavingsAccounts, SavingsAccounts."Monthly Contribution", 0);
                //                     end else
                //                         if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"Benevolent (BBF)" then begin
                //                             //PeriodicAcc.EmplyerSavingAdvice(SavingsAccounts, SavingsAccounts."Monthly Contribution", 0);
                //                         end;
                //                     if SavingsAccounts."Product Category" <> SavingsAccounts."Product Category"::"Share Capital" then begin
                //                         if SavingsAccounts."Loan Disbursement Account" = false then begin
                //                             SavingsAccounts.Status := SavingsAccounts.Status::Closed;
                //                             SavingsAccounts.Blocked := SavingsAccounts.Blocked::All;
                //                             ///  SavingsAccounts.MODIFY;
                //                         end;
                //                     end;
                //                 until SavingsAccounts.Next = 0;
                //             end;
                //         end else
                //             Error('Apprication must be approved');
                //     end;
                // }
                action("Override Notice Period")//here
                {
                    ApplicationArea = Basic, Suite;
                    Image = ResetStatus;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = Rec."Clossure Created" = false;

                    trigger OnAction()
                    var
                        StatusChangePermissions: Record "Status Change Permissions.";
                    begin
                        StatusChangePermissions.Reset;
                        StatusChangePermissions.SetRange("User ID", UserId);
                        StatusChangePermissions.SetRange("Reset Notice Date", true);
                        if StatusChangePermissions.Find('-') then begin
                            Notice.Reset;
                            Notice.SetRange(Notice."No.", Rec."No.");
                            Notice.SetRange(Status, Notice.Status::Approved);
                            if Notice.Find('-') then begin
                                //Rec."Withdrawal Notice Date" := (Today - 61);
                                Rec."Maturity Date" := Today;
                                //Rec."Early Withdrawal" := true;
                                Rec.Modify(true);
                            end
                            else
                                Error('the notice must be approved to reset the notice date');
                        end
                        else
                            Error('You do not have permission to reset the notice date');
                    end;
                }

                /* action("Approve")
                {
                    ApplicationArea = Basic, Suite;
                    Image = ResetStatus;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        StatusChangePermissions: Record "Status Change Permissions.";
                    begin
                        Notice.Reset;
                        Notice.SetRange(Notice."No.", Rec."No.");
                        Notice.SetRange(Status, Notice.Status::Open);
                        if Notice.Find('-') then begin
                            Notice.Status := Notice.Status::Approved;
                            Notice.Modify;
                        end;
                    end;
                } */

                action("Create Membership Closure")
                {
                    ApplicationArea = Basic, Suite;
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    Visible = Rec.Status = Rec.Status::Approved;
                    trigger OnAction()
                    var
                        MembershipClosure: Record "Membership Closure";
                        LblCnfm: Label 'Are you sure you want to create a membership closure for this member?';
                        MsgSuccess: Label 'Membership Closure %1 Successfully Created, Do you want to open the document?';
                        Member: Record Members;
                        LoanGuar: Record "Loan Guarantors and Security";
                    begin

                        if not Confirm(LblCnfm, false) then
                            exit;

                        Rec.TestField("Sent Back to CRM", false);
                        Rec.TestField("Member No.");
                        Rec.TestField("Notice Type");
                        Rec.TestField("Reason for withdrawal");
                        Rec.TestField("Notice Finalized", false);
                        if rec."No. of Days Remaining" > 0 then
                            Error('The notice has not matured yet');

                        //Rec.Status := Rec.Status::Approved;
                        Rec."Clossure Created" := true;
                        Rec.Modify(true);

                        if Rec."Notice Type" = Rec."Notice Type"::"Withdrawal - Normal" then begin
                            Member.Reset();
                            Member.SetRange("No.", Rec."Member No.");
                            if Member.FindFirst() then begin
                                LogMemberSubStatus(Member."No.", Member.Subflag);
                                Member.Subflag := Member.Subflag::"Pending Withdrawal";
                                Member.Modify();
                            end;
                        end;

                        LoanGuar.Reset;
                        LoanGuar.SetRange("Member No", rec."Member No.");
                        LoanGuar.SetRange(Substituted, false);
                        LoanGuar.SetRange("Self Guarantee", false);
                        if LoanGuar.Find('-') then begin
                            repeat
                                if Loans.Get(LoanGuar."Loan No") then begin
                                    if Members.Get(Loans."Member No.") then begin
                                        if Members.Status <> Members.Status::Deceased then begin
                                            Loans.CalcFields("Outstanding Balance");
                                            if Loans."Member No." <> rec."Member No." then begin
                                                if Loans."Outstanding Balance" > 0 then begin
                                                    Error(Err001, Loans."Loan No.");
                                                    //NoLoanGua := NoLoanGua + '-' + Format(Loans."Loan No.");
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            until LoanGuar.Next = 0;
                        end;

                        MembershipClosure.Init();
                        MembershipClosure."Closure Type" := Rec."Notice Type";
                        MembershipClosure.Insert(true);
                        if rec."Notice Type" = rec."Notice Type"::"Withdrawal - Normal" then
                            InsertLoanLines(Rec, MembershipClosure);
                        MembershipClosure.Validate("Notice Number", Rec."No.");
                        MembershipClosure.Modify(true);

                        if not confirm(MsgSuccess, false, MembershipClosure."No.") then begin
                            exit;
                            CurrPage.Close();
                        end;

                        Page.Run(Page::"Membership Closure", MembershipClosure);
                    end;
                }


                action("Member Card")
                {
                    ApplicationArea = Basic, Suite;
                    Image = CreditCard;
                    Promoted = true;
                    PromotedCategory = category5;
                    RunObject = Page "Member Single";
                    RunPageLink = "No." = FIELD("Member No.");
                }
                action("Update")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Refresh;
                    Promoted = true;
                    PromotedIsBig = true;
                    trigger OnAction()
                    begin
                        if (Rec.Status = Rec.Status::Open) and (not Rec."Clossure Created") then
                            rec.Validate("Member No.")
                        else
                            Error('This record cannot be updated because the status is not open');
                        Message('Member Withdrawal Notice Successfully Updated');
                        Currpage.Update();
                    end;
                }
                action("Reject Withdrawal Notice")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Rec."Notice Type" <> Rec."Notice Type"::"Withdrawal - Normal" then Error('One can only reject a notice when the notice type is a Normal Withdrawal');

                        DatePaid := 0D;
                        AmntRefunded := 0;
                        PaymentStatus := '';
                        Mclosure.Reset;
                        Mclosure.SetRange(Mclosure."Member No.", Rec."Member No.");
                        Mclosure.SetRange(Posted, true);
                        Mclosure.SetRange(Status, Mclosure.Status::Approved);
                        if Mclosure.Find('+') then begin
                            repeat
                                AmntRefunded := Mclosure."Deposit Refundable";
                                PaymentStatus := 'Paid'
                            until Mclosure.Next = 0;
                        end else
                            PaymentStatus := 'Pending';

                        if PaymentStatus <> 'Pending' then
                            Error('This notice cannot be rejected since the member has already been refunded')
                        else begin
                            if Rec."Rejection Remarks" = '' then Error('Kindly fill in the Rejection Reason');
                            if Confirm('Are you sure you want to reject the withdrawal notice?', false) = true then begin
                                Rec.Status := Rec.Status::Rejected;
                                Rec.Modify(true);
                                Message('Member Withdrawal Notice Successfully Rejected');
                            end;
                        end;
                    end;
                }
                action("Re-Open ")
                {
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;
                    Visible = Rec."Clossure Created" = false;

                    trigger OnAction()
                    begin
                        Rec.TestField("Notice Finalized", false);
                        // if rec.Status = rec.Status::Approved then begin
                        rec.Status := rec.Status::Open;
                        rec.Modify(true);
                        Message('Document open successfuly');
                        // end;
                    end;
                }
            }
            // group("CRM Integration")
            // {
            //     Caption = 'CRM Actions';
            //     action("CRM Comment")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Image = Comment;
            //         Promoted = true;
            //         PromotedCategory = Category10;

            //         RunObject = page "Comments List";
            //         RunPageLink = "Header No." = field("No.");
            //         RunPageView = where(Types = CONST(comment));
            //         // RunPageMode = Create;

            //         Visible = IsNotSentBackToCRM;
            //     }
            //     action("Send Back to CRM")
            //     {
            //         ApplicationArea = all;
            //         Image = Return;
            //         Promoted = true;
            //         PromotedCategory = Category10;

            //         Visible = IsNotSentBackToCRM;

            //         trigger OnAction()
            //         var
            //             Comments: Record Comments;
            //         begin
            //             // Rec.TestField(Status, Rec.Status::Open);
            //             if not ((Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Approved)) then begin
            //                 Error('Cannot send back to CRM record at status %1', Rec.Status);
            //             end;

            //             Comments.Reset;
            //             Comments.SetRange("Header No.", Rec."No.");
            //             Comments.SetAscending("Entry No.", true);

            //             if Comments.FindLast then begin
            //                 if (Comments."Commented By" <> UserId) then begin
            //                     Error('Comment is required before sending the application back to CRM');
            //                 end else begin
            //                     if Confirm('This application will be sent back to CRM for editing. Are you sure you want to proceed?') then begin
            //                         Rec."Sent Back to CRM" := true;
            //                         Rec.Status := Rec.Status::Open;
            //                         Rec.Modify(true);

            //                         Message('Comment has been sent back to CRM');

            //                         CurrPage.Close();
            //                     end;
            //                 end;
            //             end else begin
            //                 Error('Comment is required before sending the application back to CRM');
            //             end;
            //             ;
            //         end;
            //     }
            // }

            group("File Integration")
            {
                // action("Import")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Import File';
                //     Promoted = true;
                //     PromotedCategory = Category11;
                //     Image = Import;
                //     Visible = Rec."Clossure Created" = false;

                //     trigger OnAction()
                //     var
                //         Base64Convert: Codeunit "Base64 Convert";
                //         TempBlob: Codeunit "Temp Blob";
                //         InStr: InStream;
                //         ApplicantMember: Record Members;

                //         EDMSFunctions: Codeunit "EDMS Functions";
                //         FileName: Text;
                //         FileContentsB64: Text;

                //         IDNumber: Text;
                //         ApplicationType: Label 'MW'; // Member Withdrawal
                //         PFNumber: Text;
                //     begin
                //         if Rec."No." <> '' then begin
                //             FileName := EDMSFunctions.PickEDMSFile(TempBlob);

                //             TempBlob.CreateInStream(InStr);
                //             FileContentsB64 := Base64Convert.ToBase64(InStr);

                //             if FileContentsB64 <> '' then begin
                //                 UploadToEDMS(Rec, FileName, FileContentsB64);
                //             end;
                //         end else begin
                //             Error('Application No. is required for EDMS document upload');
                //         end;
                //     end;
                // }
                // action("EDMS File List")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Image = Documents;
                //     Promoted = true;
                //     PromotedCategory = Category11;

                //     RunObject = page "EDMS Files List";
                //     RunPageLink = "Application No." = field("No.");
                //     // RunPageMode = Create;
                // }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //IF (Status=Status::Approved) OR (Status=Status::Pending) THEN
        //CurrPage.EDITABLE:=FALSE;
        EditControls;
        SetControlAppearance;
        if not (rec."Clossure Created") and (rec.status = rec.status::Approved) then
            If Rec."Withdrawal Notice Date" <> 0D THEN begin
                noofdays := Rec."Maturity Date" - TODAY;
                rec."No. of Days Remaining" := noofdays;
                Rec.Modify(true);
            end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        MemberwithdrawalNotice.Reset;
        MemberwithdrawalNotice.SetRange(Status, MemberwithdrawalNotice.Status::Open);
        MemberwithdrawalNotice.SetFilter("Notice Type", '%1|%2', MemberwithdrawalNotice."Notice Type"::"Withdrawal - Normal", MemberwithdrawalNotice."Notice Type"::" ");
        if MemberwithdrawalNotice.count > 3 then Error('Kindly make use the open cards');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        MemberwithdrawalNotice.Reset;
        MemberwithdrawalNotice.SetRange(Status, MemberwithdrawalNotice.Status::Open);
        MemberwithdrawalNotice.SetFilter("Notice Type", '%1|%2', MemberwithdrawalNotice."Notice Type"::"Withdrawal - Normal", MemberwithdrawalNotice."Notice Type"::" ");
        if MemberwithdrawalNotice.count > 3 then Error('Kindly make use the open cards');

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        If Rec."Withdrawal Notice Date" <> 0D THEN begin
            noofdays := Rec."Maturity Date" - TODAY;
            rec."No. of Days Remaining" := noofdays;
            Rec.Modify(true);
        end;
    end;


    trigger OnOpenPage()
    begin
        // DefinedSLA.Reset();
        // DefinedSLA.SetRange("Origination Type", DefinedSLA."Origination Type");
        // if DefinedSLA."Origination Type" = DefinedSLA."Origination Type"::"Membership Withdrawal" then
        //     rec.SLA := DefinedSLA.SLA;
        //IF (Status=Status::Approved) OR (Status=Status::Pending) THEN
        //CurrPage.EDITABLE:=FALSE;
        EditControls;

        if Rec."Sent Back to CRM" then begin
            IsNotSentBackToCRM := false;
        end else begin
            IsNotSentBackToCRM := true;
        end;
        If Rec."Withdrawal Notice Date" <> 0D THEN begin
            noofdays := Rec."Maturity Date" - Today;
            rec."No. of Days Remaining" := noofdays;
            Rec.Modify(true);
        end;

        CurrPage.update;
    end;

    procedure UploadToEDMS(Rec: Record "Member Withdrawal Notice"; FileName: Text; FileContentsB64: Text)
    var
        EDMSFunctions: Codeunit "EDMS Functions";
        ApplicantMember: Record Members;

        IDNumber: Text;
        ApplicationType: Label 'MW'; // Member Withdrawal
        PFNumber: Text;
    begin
        ApplicantMember.Reset;

        ApplicantMember.SetRange("No.", Rec."Member No.");

        if ApplicantMember.FindFirst then begin
            if ApplicantMember."Primary Identification Type" = ApplicantMember."Primary Identification Type"::"ID Number" then begin
                IDNumber := ApplicantMember."Primary Identification";
            end else
                if ApplicantMember."Secondary Identification Type" = ApplicantMember."Secondary Identification Type"::"ID Number" then begin
                    IDNumber := ApplicantMember."Secondary Identification";
                end else begin
                    IDNumber := ApplicantMember."Primary Identification";
                end;

            if ApplicantMember."Payroll/Staff No." <> '' then begin
                PFNumber := ApplicantMember."Payroll/Staff No.";
            end else begin
                PFNumber := IDNumber;
            end;

            EDMSFunctions.EDMSMemberFileUpload(
                IDNumber,
                ApplicantMember.Name,
                ApplicationType,
                PfNumber,
                ApplicantMember."No.",
                Rec."No.",
                FileName,
                FileContentsB64
            );
        end;
    end;

    var
        DefinedSLA: Record "Defined SLA";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        DocMustbeOpen: Label 'This application request must be open';
        DocMustbePending: Label 'This application request must be Pending';
        Loans: Record Loans;
        noofdays: Integer;
        PeriodicAcc: Codeunit "Periodic Activities";
        LoansProcess: Codeunit "Loans Process";
        SavingsAccounts: Record "Savings Accounts";
        Notice: Record "Member withdrawal Notice";
        LoanGuarantorsandSecurity: Record "Loan Guarantors and Security";
        Err001: Label 'This member has guranteen loan No %1';
        DatePaid: Date;
        AmntRefunded: Decimal;
        PaymentStatus: Text;
        Mclosure: Record "Membership closure";
        RejStatus: Boolean;
        EditableStatus: Boolean;
        RemarksEdit: Boolean;
        NotTypeEdit: Boolean;
        ROWEdit: Boolean;
        MemNoEdit: Boolean;
        WithNotDate: Boolean;
        Members: Record Members;
        MemberwithdrawalNotice: Record "Member withdrawal Notice";
        IsNotSentBackToCRM: Boolean;
        PercEdit: Boolean;



    local procedure SetControlAppearance()
    var
    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin

        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    local procedure EditControls()
    begin
        if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Pending) or (Rec.Status = Rec.Status::Rejected) then begin

            EditableStatus := false;
            RemarksEdit := false;
            if Rec.Status <> Rec.Status::Rejected then RejStatus := true else RejStatus := false;
            ROWEdit := false;
            NotTypeEdit := false;
            WithNotDate := false;
            MemNoEdit := false;
        end else begin
            EditableStatus := true;
            RemarksEdit := true;
            RejStatus := true;
            ROWEdit := true;
            NotTypeEdit := true;
            WithNotDate := true;
            MemNoEdit := true;
        end;
    end;

    procedure InsertLoanLines(WithdrawalNotice: Record "Member withdrawal Notice"; Closure: Record "Membership Closure")
    var
        RecoveryHeader: Record "Loan Recovery Header";
        LoanLines: Record "Loan Closure Line";

        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;
    begin
        Loans.Reset();
        Loans.SetRange("Member No.", WithdrawalNotice."Member No.");
        Loans.CalcFields("Total Loan Balance");
        Loans.SetFilter("Total Loan Balance", '>0');
        if Loans.Find('-') then begin
            repeat
                RecoveryHeader.GetLoanBalances(Loans."Loan No.", OutInt, OutBal, TotalBal);
                LoanLines.Init();
                LoanLines."No." := Closure."No.";
                LoanLines."Product Type" := Loans."Loan Product Type";
                LoanLines."Loan No." := Loans."Loan No.";
                LoanLines.Name := Loans."Member Name";
                LoanLines."Outstanding Balance" := OutBal;
                LoanLines."Outstanding Interest" := OutInt;
                LoanLines."Member No." := Loans."Member No.";
                LoanLines."Total Loan Balance" := TotalBal;
                LoanLines.Insert();
                Clear(LoanLines);
            until Loans.Next() = 0;
        end;
    end;

    procedure LogMemberSubStatus(MembNo: Code[20]; Subflag: Enum "Member Status Sub Flags")
    var
        MemberSubStatusTracker: Record "Member Sub-Status Tracker";
        Members: Record Members;
    begin
        if Members.get(MembNo) then begin
            MemberSubStatusTracker.reset;
            MemberSubStatusTracker.Init();
            MemberSubStatusTracker."Member No." := MembNo;
            MemberSubStatusTracker.Status := Members.Status;
            MemberSubStatusTracker."Sub-Status" := Subflag;
            MemberSubStatusTracker."Modified By" := UserId;
            MemberSubStatusTracker."Date Modified" := Today;
            MemberSubStatusTracker.Insert(true);
        end;
    end;

    procedure RevertPreviousSubflag(MembNo: Code[20])
    var
        MemberSubflagLogs: Record "Member Sub-Status Tracker";
        Members: Record Members;
    begin
        if Members.get(MembNo) then begin
            MemberSubflagLogs.reset;
            MemberSubflagLogs.SetCurrentKey("Date Modified");
            MemberSubflagLogs.SETRANGE("Member No.", MembNo);
            if MemberSubflagLogs.FINDLAST then begin
                // Members.Get(Rec."Member No.");
                if Members.Subflag = Members.Subflag::"Pending Withdrawal" then begin
                    Members.Subflag := MemberSubflagLogs."Sub-Status";
                    Members.Modify;
                    MemberSubflagLogs."Current Subflag" := true;
                    MemberSubflagLogs.Modify();
                end;
            end;
        end;
    end;
}

