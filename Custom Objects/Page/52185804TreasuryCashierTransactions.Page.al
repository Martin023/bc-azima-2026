page 52185804 "Treasury Cashier Transactions"
{
    DeleteAllowed = false;
    SourceTable = "Treasury Cashier Transactions";
    ApplicationArea = Basic, Suite;
    PromotedActionCategories = 'New,Process,Reports,Workflow Actions,Budgetary Control,Cancellation,References,Refresh';

    //USageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = HeaderA;
                    //OptionCaption = 'Teller Request,Return To Treasury,Issue From Treasury Control,Return To Bank,Inter Teller Transfers,Branch Treasury Transactions,End of Day Return to Treasury';
                }
                field("From Account"; Rec."From Account")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'From';
                    Editable = HeaderA;
                }
                field("From Till"; Rec."From Till")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("To Account"; Rec."To Account")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'To';
                    Editable = HeaderA;
                }
                field("To Till"; Rec."To Till")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Till/Treasury Balance"; Rec."Till/Treasury Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'End Of Day Till Balance';
                    Editable = false;
                    Visible = true;
                }
                // field(Balance; Rec.Balance)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Treasury Vault Balance';
                //     Editable = false;
                // }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = HeaderA;
                }
                // field("Currency Code"; Rec."Currency Code")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = Currr;
                // }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cheque/Document No.';
                    Editable = HeaderA;
                }
                field(Issued; Rec.Issued)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date Issued"; Rec."Date Issued")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Time Issued"; Rec."Time Issued")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Issued By"; Rec."Issued By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Received; Rec.Received)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date Received"; Rec."Date Received")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Received"; Rec."Time Received")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Received By"; Rec."Received By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = HeaderA;

                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Total Cash on Treasury Coinage"; Rec."Total Cash on Treasury Coinage")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Cash on Treasury/Teller Coinage';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = HeaderA;
                }
                field("Excess/Shortage Amount"; Rec."Excess/Shortage Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = HeaderA;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            part(Coinage; Coinage)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Coinage';
                Editable = HeaderA;
                SubPageLink = No = FIELD(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print/Preview.")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    Treasury.Reset;
                    Treasury.SetRange(No, Rec.No);
                    if Treasury.Find('-') then begin
                        REPORT.Run(Report::"Treasury Coinage.", true, false, Treasury);
                    end;
                end;
            }
            action("Treasury Issue")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Treasury Issue';
                Image = Interaction;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SaccoT: Codeunit "Sacco Transactions";
                    BankingSetup: record "Banking User Template";
                    BankAcc: record "Bank Account";
                begin

                    if Rec.Status <> Rec.Status::Approved then
                        Error('Transaction must be approved');

                    if Rec.Posted = true then
                        Error('The Transaction is already Posted.');
                    if rec."From Account" <> '' then begin
                        if BankingSetup.get(rec."From Account") then begin
                            if BankingSetup."Default  Bank" = '' then
                                error('Default treasury bank has to be set.');
                            if BankAcc.get(BankingSetup."Default  Bank") then
                                BankAcc.CalcFields("Balance (LCY)");
                            if BankAcc."Balance (LCY)" > BankingSetup."Maximum Withholding" then
                                Message('The trasury has exceeded the maximum withholding of %1', BankingSetup."Maximum Withholding");
                            if BankAcc."Balance (LCY)" < BankingSetup."Minimum Balance" then
                                Message('The trasury account has gone below minimum required balance of %1', BankingSetup."Minimum Balance");
                        end;
                    end;

                    SaccoT.PostTCIssue(Rec);
                end;
            }
            action("Cashier Return")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cashier Return';
                Image = Interaction;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SaccoT: Codeunit "Sacco Transactions";
                begin

                    if Rec.Status <> Rec.Status::Approved then
                        Error('Transaction must be approved');

                    if Rec.Posted = true then
                        Error('The Transaction is already Posted.');


                    SaccoT.PostTCIssue(Rec);
                end;
            }
            action("Return & Post")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cashier Return & Receive.';
                Image = ReceiveLoaner;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SaccoT: Codeunit "Sacco Transactions";
                begin
                    rec.TestField("Transaction Type", rec."Transaction Type"::"End of Day Return to Treasury");
                    rec.testfield(Issued, rec.Issued::No);
                    if rec.Posted then Error('This Document has already been Posted!');
                    if Rec.Status <> Rec.Status::Approved then
                        Error('Transaction must be approved');
                    if rec.Received = rec.Received::Yes then error('This document has already been received!');
                    SaccoT.ProcessEndOfDayReturnToTreasury(Rec);
                end;

            }
            separator(Action27)
            {
            }
            action(Receive)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Receive.';
                Image = ReceiveLoaner;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SaccoT: Codeunit "Sacco Transactions";
                begin
                    if rec.Posted then Error('This Document has already been Posted!');
                    if Rec.Status <> Rec.Status::Approved then
                        Error('Transaction must be approved');
                    if rec.Received = rec.Received::Yes then error('This document has already been received!');
                    SaccoT.PostTCReceive(Rec);
                end;
            }
            action("Till Balance")
            {
                ApplicationArea = Basic;
                Image = Balance;
                Promoted = true;
                PromotedCategory = "Report";
                Enabled = rec."Transaction Type" = rec."Transaction Type"::"Issue To Teller";
                Caption = 'Cashier Till Balance';
                trigger OnAction()
                var
                    BankAcc: Record "Bank Account";
                    BankUtemp: record "Banking User Template";
                begin
                    if Rec."Transaction Type" = rec."Transaction Type"::"Issue To Teller" then begin
                        if BankUtemp.get(rec."To Account") then begin
                            if BankUtemp."Default  Bank" <> '' then
                                if BankAcc.get(BankUtemp."Default  Bank") then
                                    page.run(page::"Bank Account Card", BankAcc);
                        end;
                    end;
                end;
            }
            group(Approval)
            {
                Caption = 'Approval';
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action("Print/Preview")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        Treasury.Reset;
                        Treasury.SetRange(No, Rec.No);
                        if Treasury.Find('-') then begin
                            //REPORT.Run(52185771, true, false, Treasury);
                        end;
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
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
                        SendSMS: codeunit SendSms;
                        BankingUSetup: Record "Banking User Template";
                        Source: enum "SMS Source";
                        Members: record Members;
                        TCTransactions: record "Treasury Cashier Transactions";
                    begin
                        if rec."Transaction Type" = rec."Transaction Type"::"Issue From Treasury Control" then begin
                            if rec."External Document No." = '' then Error('Ensure cheque no has been inserted before sending for approval')
                        end;

                        if Rec.Status <> Rec.Status::Open then
                            Error(DocMustbeOpen);
                        if rec.Amount <= 0 then
                            Error('Kindly Enter Amount');

                        //if rec.Status = Status::Approved then begin
                        if rec."Transaction Type" = rec."Transaction Type"::"Issue To Teller" then begin
                            BankingUSetup.get(rec."From Account");
                            if BankingUsetup."Member No." <> '' then
                                if Confirm('Do you wish to send an SMS to the treasury?') then begin
                                    Members.get(BankingUSetup."Member No.");
                                    //Send SMS--TODO
                                    //Message('Greetings, kindly approve & issue teller request from: ' + format(rec."To Till") + ' from your treasury');
                                    SendSMS.SendSms(Source::CASHIER_ABOVE_LIMIT, Members."Phone No.", 'Greetings, kindly approve & issue teller request from: ' + format(rec."To Till") + ' from your treasury', rec."To Account", '', true, 0, false, 'CBS', rec."From Account", 'CBS');
                                end;
                        end;

                        if rec."Transaction Type" = rec."Transaction Type"::"End of Day Return to Treasury" then begin
                            TCTransactions.reset;
                            TCTransactions.SetRange(Issued, TCTransactions.Issued::Yes);
                            TCTransactions.SetRange(Received, TCTransactions.Received::No);
                            if TCTransactions.Find('-') then begin
                                Error('You already have a pending EOD return to treasury request. kindly close that one first before proceeding');
                            end;
                        end;

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

                action("Re-Open ")
                {
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        if rec.Posted = false then begin
                            rec.Status := rec.Status::Open;
                            if rec.Issued = rec.Issued::Yes then begin
                                rec.Issued := Rec.Issued::No;
                                rec.Received := Rec.Received::No;
                                rec."Received By" := '';
                                rec."Issued By" := '';
                            end;
                            rec.Modify;
                            Message('Document open successfuly and this page will close. Kindly go back to open treasury cashier transactions list.');
                        end
                        else begin
                            Error('This document has already been posted!');
                        end;

                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }

            }
            action("Refresh")
            {
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                begin
                    if rec.Posted = false then begin
                        CurrPage.Update();
                    end;
                    Message('Document Refreshed.');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
        SetControlAppearance;
    end;

    trigger OnInit()
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Posted = true then
            CurrPage.Editable := false;

        // UserSetup.Reset;
        // UserSetup.SetRange("User ID", UserId);
        // if UserSetup.Find('-') then begin
        //     Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        //     Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        //     // MODIFY;
        // end;
    end;

    var
        TransType: Boolean;
        FrAccount: Boolean;
        ToAccount: Boolean;
        Amnt: Boolean;
        Currr: Boolean;
        ExternDoc: Boolean;
        Excess: Boolean;
        Cnage: Boolean;
        Typee: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        DocMustbeOpen: Label 'This application request must be open';
        DocMustbePending: Label 'This application request must be Pending';
        UserSetup: Record "User Setup";
        Treasury: Record "Treasury Cashier Transactions";
        HeaderA: Boolean;

    local procedure UpdateControls()
    begin
        if (Rec.Issued = Rec.Issued::Yes) or (Rec.Received = Rec.Received::Yes) then begin
            TransType := false;
            FrAccount := false;
            ToAccount := false;
            Amnt := false;
            Excess := false;
            Currr := false;
            Cnage := false;
            ExternDoc := false;
            Typee := false;
        end else begin
            TransType := true;
            FrAccount := true;
            ToAccount := true;
            Amnt := true;
            Excess := true;
            Currr := true;
            Cnage := true;
            ExternDoc := true;
            Typee := true;

        end;

        case rec.Status of
            rec.Status::Open:
                begin

                    HeaderA := true;
                end;

            rec.Status::Pending, rec.Status::Approved, rec.Status::Rejected:
                begin
                    HeaderA := false;
                end;
        end;
    end;

    local procedure SetControlAppearance()
    var
    // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin

        //    OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

