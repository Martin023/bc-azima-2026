page 52185943 "Imprest Request Header"
{
    Caption = 'Imprest Application';
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Refresh,Category8_caption,Approvals,Category10_caption,EDMS,Teller Details';
    RefreshOnActivate = true;
    SourceTable = "Imprest Header";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    Editable = DateEditable;

                    trigger OnValidate()
                    begin
                        // Rec."Payment Release Date" := Rec.Date;
                        // Rec.Modify();
                        // CurrPage.Update;
                    end;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = GlobalDimension1CodeEditable;
                }
                field("Function Name"; Rec."Function Name")
                {
                    Caption = 'Description';
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = ShortcutDimension2CodeEditable;
                }
                field("Budget Center Name"; Rec."Budget Center Name")
                {
                    Caption = 'Description';
                    Editable = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    Editable = AccountNoEditable;
                }
                field(Payee; Rec.Payee)
                {
                    Editable = false;
                }
                field("PF/Staff No"; Rec."PF/Staff No")
                {
                    Editable = false;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    Editable = (rec.Status = rec.Status::Approved) and (rec.Posted = false);
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    Editable = false;
                }
                field(Purpose; Rec.Purpose)
                {
                    Caption = 'Purpose/ Description';
                    ShowMandatory = true;
                    Editable = GlobalDimension1CodeEditable;
                }
                // field("Purpose 2"; rec."Purpose 2")
                // {
                //     Caption = 'Purpose 2';
                //     Editable = GlobalDimension1CodeEditable;
                // }
                field(Cashier; Rec.Cashier)
                {
                    Caption = 'Requestor ID';
                    Editable = false;
                }
                field("Recommender ID"; Rec."Recommender ID")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                }
                field("Total Net Amount LCY"; Rec."Total Net Amount LCY")
                {
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    Caption = 'Posting Date';
                    Editable = (rec.Status = rec.Status::Approved) and (rec.Posted = false);
                    ShowMandatory = true;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    // Editable = "Pay ModeEditable";
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = GlobalDimension1CodeEditable;
                }
                field("Bankers Cheque No"; Rec."Bankers Cheque No")
                {
                    Editable = "Cheque No.Editable";
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    Caption = 'Cheque/EFT No.';
                    Editable = "Cheque No.Editable";
                    Visible = DocEdit;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                }
            }
            part(PVLines; "Imprest Request Details")
            {
                SubPageLink = No = FIELD("No.");
                Editable = rec.Status = rec.Status::Pending;
            }
            systempart(Control5; Links)
            {
                Visible = true;
            }
            systempart(Control3; Notes)
            {
                Visible = true;
            }
        }
        area(factboxes)
        {
            part(Control7; "Imprest FactBox")
            {
                Provider = PVLines;
                SubPageLink = No = FIELD(No),
                              "Line No." = FIELD("Line No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Post Payment")
                {
                    Caption = 'Post Payment';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //Visible = Not (rec.Status = rec.Status::Pending);

                    trigger OnAction()
                    begin
                        rec.TestField(Posted, false);
                        rec.TestField(Status, rec.Status::Approved);
                        Rec.TestField("Pay Mode");
                        Rec.TestField("Payment Release Date");
                        if Rec."Pay Mode" = Rec."Pay Mode"::Cheque then
                            Rec.TestField("Bankers Cheque No");

                        CheckImprestRequiredItems(Rec);
                        PostImprest(Rec);
                    end;
                }
                separator(Action1102755026)
                {
                }
                action(Refresh)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = Category7;
                    trigger OnAction()
                    begin
                        //Rec.UpdateBBFLines();
                        CurrPage.Update();
                    end;
                }

                // action("Reset Posting Date")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Reset Posting Date';
                //     Image = Refresh;
                //     Promoted = true;
                //     PromotedCategory = Category7;

                //     trigger OnAction() 
                //     begin
                //         Rec."Payment Release Date" := Today;
                //         Rec.Modify;
                //         Message('Posting Date has been reset to today');
                //     end;
                // }

                // action("Check Budget Commitment")
                // {
                //     Caption = 'Check Budget Commitment';
                //     Image = Balance;
                //     Promoted = true;
                //     PromotedCategory = Category5;
                //     PromotedIsBig = true;

                //     trigger OnAction()
                //     var
                //         BCSetup: Record "Budgetary Control Setup";
                //     begin

                //         BCSetup.Get;
                //         if not BCSetup.Mandatory then
                //             exit;

                //         if not LinesExists then
                //             Error('There are no Lines created for this Document');

                //         if not AllFieldsEntered then
                //             Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                //         //First Check whether other lines are already committed.
                //         Commitments.Reset;
                //         Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::Imprest);
                //         Commitments.SetRange(Commitments."Document No.", Rec."No.");
                //         if Commitments.Find('-') then begin
                //             if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then begin exit end;
                //             Commitments.Reset;
                //             Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::Imprest);
                //             Commitments.SetRange(Commitments."Document No.", Rec."No.");
                //             Commitments.DeleteAll;
                //         end;

                //         //here//
                //         CheckBudgetAvail.CheckImprest(Rec);
                //     end;
                // }
                // action("Cancel Budget Commitment")
                // {
                //     Caption = 'Cancel Budget Commitment';
                //     Image = Cancel;
                //     Promoted = true;
                //     PromotedCategory = Category5;
                //     PromotedIsBig = true;

                //     trigger OnAction()
                //     begin
                //         if Confirm('Do you Wish to Cancel the Commitment entries for this document', false) = false then begin exit end;

                //         Commitments.Reset;
                //         Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::Imprest);
                //         Commitments.SetRange(Commitments."Document No.", Rec."No.");
                //         Commitments.DeleteAll;

                //         PayLine.Reset;
                //         PayLine.SetRange(PayLine.No, Rec."No.");
                //         if PayLine.Find('-') then begin
                //             repeat
                //                 PayLine.Committed := false;
                //                 PayLine.Modify;
                //             until PayLine.Next = 0;
                //         end;
                //     end;
                // }
                separator(Action1102755033)
                {
                }
                action("Print/Preview")
                {
                    Caption = 'Print/Preview';
                    Image = ConfirmAndPrint;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if (Rec.Status <> Rec.Status::Approved) and (Rec.Status <> Rec.Status::Posted) then
                            Error('You can only print after the document is Approved or Posted');
                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        REPORT.Run(REPORT::"Imprest Requisition Report", true, true, Rec);
                        Rec.Reset;
                    end;
                }
                separator(Action1102756006)
                {
                }
                action(Action25)
                {
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text000: Label 'Are you sure you want to Cancel this Document?';
                        Text001: Label 'You have selected not to Cancel this Document';
                    begin

                        if (Rec.Status <> Rec.Status::Pending) and (Rec.Status <> Rec.Status::"Pending Approval") then Error('Status must either be pending or pending approval');
                        if Confirm(Text000, true) then begin
                            //Post Committment Reversals
                            Doc_Type := Doc_Type::Imprest;
                            BudgetControl.ReverseEntries(Doc_Type, Rec."No.");
                            Rec.Status := Rec.Status::Cancelled;
                            Rec.Modify;
                        end else
                            Error(Text001);
                    end;
                }
                action("Cancel Document")
                {
                    Caption = 'Cancel Document';
                    Enabled = false;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        Text000: Label 'Are you sure you want to Cancel this Document?';
                        Text001: Label 'You have selected not to Cancel this Document';
                    begin
                        //TESTFIELD(Status,Status::Approved);
                        if Confirm(Text000, true) then begin

                            if rec.status <> rec.status::Approved then
                                error('You cannot cancel an open/pending document. Kindly cancel approval request');
                            //Post Committment Reversals
                            Doc_Type := Doc_Type::Imprest;
                            BudgetControl.ReverseEntries(Doc_Type, Rec."No.");
                            Rec.Status := Rec.Status::Cancelled;
                            Rec.Modify;
                        end else
                            Error(Text001);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        Customer: Record Customer;
                    begin
                        //Rec.TestField("Paying Bank Account");
                        Rec.TestField(Date);
                        Rec.TestField("Pay Mode");
                        if Rec.Status <> Rec.Status::Pending then
                            error('You can only send for approval when the document is in pending status');


                        if not LinesExists then
                            Error('There are no Lines created for this Document');

                        if not AllFieldsEntered then
                            Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                        // PayLine.Reset;
                        // PayLine.SetRange(PayLine.No, Rec."No.");
                        // if PayLine.Find('-') then
                        //     repeat
                        //     //PayLine.TESTFIELD(Committed);
                        //     until PayLine.Next = 0;
                        Rec.CalcFields("Total Net Amount");
                        Customer.Reset;
                        if Customer.Get(Rec."Account No.") then begin
                            //Check CreditLimit Here In cases where you have a credit limit set for employees
                            Customer.CalcFields(Customer."Balance (LCY)");
                            if (Customer."Balance (LCY)" + Rec."Total Net Amount") > Customer."Credit Limit (LCY)" then
                                Error('The allowable unaccounted balance of %1 has been exceeded', Customer."Credit Limit (LCY)");
                        end;
                        //if (Rec.Status = Rec.Status::Pending) then
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                // action(CancelApprovalRequest)
                // {
                //     Caption = 'Cancel Approval Re&quest';
                //     Image = Cancel;
                //     Promoted = true;
                //     PromotedCategory = Category9;

                //     trigger OnAction()
                //     var
                //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //         GlobalFunctions: Codeunit "Global Functions";
                //     begin
                //         if Rec.Status = Rec.Status::Posted then
                //             Error('You cannot cancel  an Posted document');
                //         VarVariant := Rec;
                //         GlobalFunctions.CommentsManagement(Rec."No.");
                //         CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                //     end;
                // }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Visible = true;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        GlobalFunctions: Codeunit "Global Functions";
                    begin
                        VarVariant := Rec;

                        if Rec.Status = Rec.Status::Posted then
                            Error('You cannot cancel  a Posted document');
                        VarVariant := Rec;
                        //GlobalFunctions.CommentsManagement(Rec."No.");
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }

                action("Re-Open")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                    Promoted = true;
                    PromotedCategory = Category9;
                    Image = ReOpen;

                    trigger OnAction()
                    begin
                        //Rec.TestField(Status, Rec.Status::Deffered);
                        if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Cancelled) then begin
                            if Confirm('Are you sure you want to re-open this document?', false) = true then begin
                                Rec.Status := Rec.Status::Pending;
                                Rec.Modify(true);
                                Message('Document reopened successfully.');
                            end;
                        end
                        else
                            error('Document only can be re-opened if it is approved or cancelled');
                    end;
                }

                action(Commentss)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    Caption = 'Comment';
                    PromotedCategory = Category9;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }
            }
            group(Navigate)
            {
                Caption = 'Navigate';
                // action(Approvals)
                // {
                //     Caption = 'Approvals';
                //     Image = Approvals;
                //     Promoted = true;
                //     PromotedCategory = Category9;

                //     trigger OnAction()
                //     var
                //         ApprovalEntries: Page "Approval Entries";
                //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //     begin
                //         DocumentType := DocumentType::"Payment Voucher";
                //         ApprovalEntries.SetRecordFilters(DATABASE::"Payments Header", rec."Document Type", rec."No.");
                //         ApprovalEntries.RUN;
                //         ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                //     end;
                // }

                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;
                    trigger OnAction()
                    var
                        //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
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
                        if Rec.Status = Rec.Status::Posted then
                            Error('You cannot Approve Posted document');
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Reject)
                {
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
                        if Rec.Status = Rec.Status::Posted then
                            Error('You cannot reject Posted document');
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Delegate)
                {
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Comment)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    RunPageLink = "Table ID" = CONST(52185909),
                                  "Document No." = FIELD("No.");
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }

            // group("EDMS Integration")
            // {
            //     action("Import")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Import File';
            //         Promoted = true;
            //         PromotedCategory = Category11;
            //         Image = Import;

            //         trigger OnAction()
            //         var
            //             Base64Convert: Codeunit "Base64 Convert";
            //             TempBlob: Codeunit "Temp Blob";
            //             InStr: InStream;

            //             EDMSFunctions: Codeunit "EDMS Functions";
            //             FileName: Text;
            //             FileContentsB64: Text;

            //             IDNumber: Text;
            //             ApplicationType: Label 'MA'; // Member Application
            //             PFNumber: Text;
            //         begin
            //             if Rec."No." <> '' then begin
            //                 FileName := EDMSFunctions.PickEDMSFile(TempBlob);

            //                 TempBlob.CreateInStream(InStr);
            //                 FileContentsB64 := Base64Convert.ToBase64(InStr);

            //                 if FileContentsB64 <> '' then begin
            //                     // UploadToEDMS(Rec, FileName, FileContentsB64);
            //                 end;
            //             end else begin
            //                 Error('Application No. is required for EDMS document upload');
            //             end;
            //         end;
            //     }
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

            // }
            group("Teller Account Details")
            {
                action("Reset Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Image = DateRange;
                    Promoted = true;
                    PromotedCategory = Category12;
                    trigger OnAction()
                    begin
                        if not Rec.Posted then begin
                            rec."Payment Release Date" := Today;
                            rec.modify;
                            Message('The release date has been updated Successfully')
                        end
                        else
                            error('You cannot Reset a document that has already been posted');
                    end;
                }
                action("Set Paying Bank")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Bank;
                    Promoted = true;
                    PromotedCategory = Category12;
                    trigger OnAction()
                    var
                        BankingUserTemplate: record "Banking User Template";
                    begin
                        if not Rec.Posted then begin
                            if BankingUserTemplate.get(UserId) then begin
                                rec."Paying Bank Account" := BankingUserTemplate."Default  Bank";
                                rec.validate("Paying Bank Account");
                                rec.Modify;
                            end
                            else
                                error('You must be set up as a teller to perform this action')
                        end
                        else
                            error('This record has already been posted')
                    end;

                }
            }
        }
    }


    trigger OnAfterGetRecord()
    begin
        OnAfGetCurrRecord;
        SetControlAppearance;
    end;

    trigger OnInit()
    begin
        "Currency CodeEditable" := true;
        DateEditable := true;
        ShortcutDimension2CodeEditable := true;
        GlobalDimension1CodeEditable := true;
        AccountNoEditable := true;
        "Cheque No.Editable" := true;
        DocEdit := true;
        "Pay ModeEditable" := true;
        PayingBankAccountEditable := true;
        "Payment Release DateEditable" := true;
        UpdateControls;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        BankingUserTemplate.Reset;
        BankingUserTemplate.SetRange(UserID, UserId);
        if BankingUserTemplate.FindFirst then MaxiPages := BankingUserTemplate."No of Open Transactions";
        //check if the documenent has been added while another one is still pending
        TravReqHeader.Reset;
        TravReqHeader.SetFilter(Status, '%1|%2|%3', TravReqHeader.Status::Pending, TravReqHeader.Status::Approved, TravReqHeader.Status::"Pending Approval");
        TravReqHeader.SetRange(TravReqHeader.Cashier, UserId);
        TravReqHeader.SetRange(Posted, false);
        //TravReqHeader.SETFILTER(TravReqHeader.Status,'<>%1',TravReqHeader.Status::Posted);
        // if TravReqHeader.FindFirst then begin
        //     if TravReqHeader.Count >= MaxiPages then begin
        //         Error('There are still some pending document(s) on your account. Please list & select the pending document to use.  ');
        //     end;
        // end;
        //*********************************END ****************************************//


        Rec."Payment Type" := Rec."Payment Type"::Imprest;
        Rec."Account Type" := Rec."Account Type"::Customer;
        //CurrPage.UPDATE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
        // //Add dimensions if set by default here
        // Rec."Global Dimension 1 Code" := 'FINANCE';//UserMgt.GetSetDimensions(USERID,1);
        // Rec.Validate("Global Dimension 1 Code");
        // Rec."Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(UserId, 2);
        // Rec.Validate("Shortcut Dimension 2 Code");
        // Rec."Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(UserId, 3);
        // Rec.Validate("Shortcut Dimension 3 Code");
        // Rec."Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(UserId, 4);
        // Rec.Validate("Shortcut Dimension 4 Code");
        //OnAfGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        if rec.Status = rec.Status::Approved then
            CurrPage.Editable := false;

        UpdateControls;
        SetDocNoVisible;
        SetControlAppearance;

    end;

    var
        BankLed: Record "Bank Account Ledger Entry";
        PayLine: Record "Imprest Lines";
        PVUsers: Record "W/P Budget Buffer";
        strFilter: Text[250];
        IntC: Integer;
        IntCount: Integer;
        Payments: Record "Payments Header";
        RecPayTypes: Record "Receipts and Payment Types";
        TarriffCodes: Record "Tariff Code s";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Cash Office User Template";
        LineNo: Integer;
        Temp: Record "Cash Office User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        strText: Text[100];
        PVHead: Record "Payments Header";
        BankAcc: Record "Bank Account";
        CheckBudgetAvail: Codeunit "Budgetary Control";
        Commitments: Record Committment;
        UserMgt: Codeunit "User Setup Management BR";
        JournlPosted: Codeunit "Journal Post Successful";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,Loan,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","MSacco Applications","MSacco PinChange","MSacco PhoneChange","MSacco TransChange",BulkSMS,"Payment Voucher","Petty Cash",Imp,Requisition,ImpSurr,Interbank,Receipt,"Staff Claim","Staff Adv",AdvSurr,OT;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash;
        BudgetControl: Codeunit "Budgetary Control";
        ImprestHdr: Record "Imprest Header";

        "Payment Release DateEditable": Boolean;

        PayingBankAccountEditable: Boolean;

        "Pay ModeEditable": Boolean;

        "Cheque No.Editable": Boolean;

        GlobalDimension1CodeEditable: Boolean;

        ShortcutDimension2CodeEditable: Boolean;

        ShortcutDimension3CodeEditable: Boolean;

        ShortcutDimension4CodeEditable: Boolean;
        AccountNoEditable: Boolean;

        DateEditable: Boolean;

        "Currency CodeEditable": Boolean;
        TravReqHeader: Record "Imprest Header";
        DocNoVisible: Boolean;
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        PayingBankEditable: Boolean;
        Text001: Label 'This Document no %1 has printed Cheque No %2 which will have to be voided first before reposting.';
        Text000: Label 'Do you want to Void Check No %1';
        Text002: Label 'You have selected post and generate a computer cheque ensure that your cheque printer is ready do you want to continue?';
        Err00001: Label 'This Document has  to be posted before you can print the Cheque.';
        DocEdit: Boolean;
        BankingUserTemplate: Record "Banking User Template";
        MaxiPages: Integer;

    //[Scope('OnPrem')]
    procedure LinesCommitmentStatus() Exists: Boolean
    var
        BCsetup: Record "Budgetary Control Setup";
    begin
        if BCsetup.Get() then begin
            if not BCsetup.Mandatory then begin
                Exists := false;
                exit;
            end;
        end else begin
            Exists := false;
            exit;
        end;
        Exists := false;
        PayLine.Reset;
        PayLine.SetRange(PayLine.No, Rec."No.");
        PayLine.SetRange(PayLine.Committed, false);
        PayLine.SetRange(PayLine."Budgetary Control A/C", true);
        if PayLine.Find('-') then
            Exists := true;
    end;

    procedure PostImprest(Rec: Record "Imprest Header")
    var
        BRegister: Record "Bankers Cheques Register";
        BankingUser: Record "Banking User Template";
        BankAcc: record "Bank Account";
    begin
        //Prevenet Non Till Holder from posting transaction.
        BankingUser.Reset();
        BankingUser.SetRange("Default  Bank", Rec."Paying Bank Account");
        if BankingUser.Find('-') then begin
            if BankingUser.UserID <> UserId then
                Error('This transaction can only be posted by %1.', BankingUser.UserID);

            // if BankingUser.Type <> BankingUser.Type::Cashier then
            //     Error('This transaction can only be posted by a teller');
        end
        else
            error('This transaction can only be posted by a teller!');

        if Rec."Approved By" = UserId then
            Error('You cannot post a document that you have approved');

        Bankacc.get(rec."Paying Bank Account");
        BankAcc.CalcFields("Balance (LCY)");
        if Rec."Total Net Amount" > BankAcc."Balance (LCY)" then
            Error('Bank Balance is not enough to make this payment. Kindly replenish to proceed.');

        BankLed.Reset;
        BankLed.SetRange("Document No.", Rec."No.");
        BankLed.SetRange(BankLed."Posting Date", Rec."Payment Release Date");
        if BankLed.Find('-') then begin
            Rec.Posted := true;
            Rec.Status := Payments.Status::Posted;
            Rec."Posted By" := UserId;
            Rec."Date Posted" := Today;
            Rec."Time Posted" := Time;
            Rec.Modify;
            Message('Transaction Posted succesfully');
            exit;
        end;

        //Modify Bankers Register
        BRegister.Reset;
        BRegister.SetRange(BRegister."Cheque No.", Rec."Bankers Cheque No");
        if BRegister.Find('-') then begin
            BRegister.Status := BRegister.Status::Approved;
            BRegister.Modify;
        end;
        if Temp.Get(UserId) then begin
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            GenJnlLine.DeleteAll;
        end;



        LineNo := LineNo + 1000;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Rec."Payment Release Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Invoice;
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."External Document No." := Rec."Cheque No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := Rec."Account No.";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine.Description := Rec.Purpose;// 'Imprest: ' + Rec."Account No." + ':' + Rec.Payee;
        Rec.CalcFields("Total Net Amount");
        GenJnlLine.Amount := Rec."Total Net Amount";
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
        GenJnlLine."Bal. Account No." := Rec."Paying Bank Account";
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        //Added for Currency Codes
        GenJnlLine."Currency Code" := Rec."Currency Code";
        GenJnlLine.Validate("Currency Code");
        GenJnlLine."Currency Factor" := Rec."Currency Factor";
        GenJnlLine.Validate("Currency Factor");
        /*
        GenJnlLine."Currency Factor":=Payments."Currency Factor";
        GenJnlLine.VALIDATE("Currency Factor");
        */
        GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;


        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post New", GenJnlLine);

        Post := false;
        //Post := JournlPosted.PostedSuccessfully();
        Post := JournlPosted.CheckPosted(Rec."No.");
        // if Post then begin
        Rec.Posted := true;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;
        Rec.Status := Rec.Status::Posted;
        Rec.Modify;
        // end;

    end;

    //[Scope('OnPrem')]
    procedure CheckImprestRequiredItems(Rec: Record "Imprest Header")
    begin

        Rec.TestField("Payment Release Date");
        Rec.TestField("Paying Bank Account");
        Rec.TestField("Account No.");
        Rec.TestField("Account Type", Rec."Account Type"::Customer);

        if Rec.Posted then begin
            Error('The Document has already been posted');
        end;

        Rec.TestField(Status, Rec.Status::Approved);

        /*Check if the user has selected all the relevant fields*/

        Temp.Get(UserId);
        JTemplate := Temp."Imprest Template";
        JBatch := Temp."Imprest  Batch";

        if JTemplate = '' then begin
            Error('Ensure the Imprest Template is set up in Cash Office Setup');
        end;

        if JBatch = '' then begin
            Error('Ensure the Imprest Batch is set up in the Cash Office Setup')
        end;

        if not LinesExists then
            Error('There are no Lines created for this Document');


    end;

    //[Scope('OnPrem')]
    procedure UpdateControls()
    begin
        if Rec.Status <> Rec.Status::Approved then begin
            "Payment Release DateEditable" := true;
            PayingBankAccountEditable := true;
            "Pay ModeEditable" := true;
            //CurrForm."Currency Code".EDITABLE:=FALSE;
            "Cheque No.Editable" := true;
            CurrPage.Update;
        end else begin
            "Payment Release DateEditable" := true;
            PayingBankAccountEditable := true;
            "Pay ModeEditable" := true;
            "Cheque No.Editable" := true;
            //CurrForm."Currency Code".EDITABLE:=TRUE;
            CurrPage.Update;
        end;

        if Rec."Pay Mode" <> Rec."Pay Mode"::Cheque then begin
            DocEdit := true
        end else begin
            DocEdit := false;
            CurrPage.Update;
        end;

        if Rec.Status = Rec.Status::Pending then begin
            GlobalDimension1CodeEditable := true;
            AccountNoEditable := true;
            ShortcutDimension2CodeEditable := true;
            //CurrForm.Payee.EDITABLE:=TRUE;
            ShortcutDimension3CodeEditable := true;
            ShortcutDimension4CodeEditable := true;
            DateEditable := true;
            //CurrForm."Account No.".EDITABLE:=TRUE;
            "Currency CodeEditable" := true;
            //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
            CurrPage.Update;
        end else begin
            GlobalDimension1CodeEditable := false;
            AccountNoEditable := false;
            ShortcutDimension2CodeEditable := false;
            //CurrForm.Payee.EDITABLE:=FALSE;
            ShortcutDimension3CodeEditable := false;
            ShortcutDimension4CodeEditable := false;
            DateEditable := false;
            //CurrForm."Account No.".EDITABLE:=FALSE;
            "Currency CodeEditable" := false;
            CurrPage.Update;
        end
    end;

    //[Scope('OnPrem')]
    procedure LinesExists(): Boolean
    var
        PayLines: Record "Imprest Lines";
    begin
        HasLines := false;
        PayLines.Reset;
        PayLines.SetRange(PayLines.No, Rec."No.");
        if PayLines.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;

    procedure AllFieldsEntered(): Boolean
    var
        PayLines: Record "Imprest Lines";
    begin
        AllKeyFieldsEntered := true;
        PayLines.Reset;
        PayLines.SetRange(PayLines.No, Rec."No.");
        if PayLines.Find('-') then begin
            repeat
                if (PayLines."Account No:" = '') or (PayLines.Purpose = '') or (PayLines.Amount <= 0) then
                    AllKeyFieldsEntered := false;
            until PayLines.Next = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;

    local procedure OnAfGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControls();
    end;

    local procedure SetDocNoVisible()
    var
        // DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Requisition","Transport Requisition",JV,"Grant Task","Concept Note",Proposal,"Job Approval","Disciplinary Approvals",GRN,Clearence,Donation,Transfer,PayChange,Budget,GL,"Cash Purchase","Leave Reimburse",Appraisal,Inspection,Closeout,"Lab Request",ProposalProjectsAreas,"Leave Carry over","IB Transfer",EmpTransfer,LeavePlanner,HrAssetTransfer;
    begin
        //DocNoVisible := DocumentNoVisibility.FundsMgtDocumentNoIsVisible(DocType::Imprest,"No.");
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

