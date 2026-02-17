page 52187087 "Business Loan Clossure Card"
{
    ApplicationArea = All;
    PromotedActionCategories = 'New,Process,Reports,Activities,WorkFlows,Category7_caption,Category8_caption,Category9_caption,Approvals';
    PageType = Card;
    SourceTable = "Business Loan Clossure";
    Caption = 'Exit and Transfer';
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = PageEitable;
                field("No."; Rec."No.")
                {
                    Editable = false;
                }

                field("CRM Application No."; Rec."CRM Application No.")
                {
                    Editable = false;
                }
                field("Clossure Type"; Rec."Clossure Type")
                {

                }
                field("Member No."; Rec."Member No.")
                {


                }
                field("New Group No."; Rec."New Group No.")
                {
                    Editable = Rec."Clossure Type" = Rec."Clossure Type"::"Group Transfer";
                }

                field(Description; Rec.Description)
                {
                    //  MultiLine = true;
                }
                field("Transaction Type"; Rec."Transaction Type")
                { }


                field(Remarks; Rec.Remarks)
                {
                    MultiLine = true;
                }
                field("Group Account No."; Rec."Group Account No.")
                { }

            }

            group("Member Details")
            {

                field("FOSA Account No"; Rec."FOSA Account No")
                {
                    Editable = false;
                }

                field("BOSA Account No"; Rec."BOSA Account No")
                {
                    Editable = false;
                }

                field(Name; Rec.Name)
                {
                    Editable = false;
                }

                field("Identification Type"; Rec."Identification Type")
                {

                }

                field(Identification; Rec.Identification)
                {

                }

                field(Address; Rec.Address)
                {

                }

                field("Date of Birth"; Rec."Date of Birth")
                {

                }

                field("Employer Code"; Rec."Employer Code")
                {

                }

                field("Employer Name"; Rec."Employer Name")
                {

                }

                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {

                }

            }

            group("Balances")
            {
                Editable = false;
                // field("Calculate Net Bal"; Rec."Calculate Net Bal")
                // {

                // }

                // field("WSF Balances"; Rec."WSF Balances")
                // {

                // }

                // field("Business Loan Shares"; Rec."Business Loan Shares")
                // {

                // }

                // field("BOSA Shares"; Rec."BOSA Shares")
                // {

                // }

                field("Total Shares"; Rec."Total Shares")
                {
                    Caption = 'Total Savings';

                }

                field("Outstanding Loan Balance"; Rec."Outstanding Loan Balance")
                {

                }

                field("Outstanding Loan Interest"; Rec."Outstanding Loan Interest")
                {

                }

                field("Total Liabilities"; Rec."Total Liabilities")
                {

                }

                field("Net Balances"; Rec."Net Balances")
                {

                }
            }
            group(BusinessGroupClosure)
            {
                part(Control1000000000; "Business Group Closure Line")
                {
                    // Editable = statuseditable;
                    SubPageLink = "No." = FIELD("No.");
                }
            }

            group(Audit)
            {
                Editable = false;
                field(Status; Rec.Status)
                {

                }

                field("Created At"; Rec."Created At")
                {

                }

                field("Created By"; Rec."Created By")
                {

                }
                field(Posted; Rec.Posted)
                { }

                field("Posted At"; Rec."Posted At")
                {

                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {

                }

                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {

                }

                field("Responsibility Center"; Rec."Responsibility Center")
                {

                }

                field("Posted By"; Rec."Posted By")
                {

                }
            }
        }
    }
    actions
    {
        area(Creation)
        {
            action("Post")
            {
                ApplicationArea = all;
                Image = PostDocument;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var

                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    if not confirm('Are you sure you want to post this transaction?') then exit;
                    if Rec."Clossure Type" = Rec."Clossure Type"::"Individual Clossure" then begin
                        if Rec."Total Shares" <= 0 then Error('Total shares must be greater than zero.');
                        if Rec."Net Balances" <= 0 then Error('Total net refundable must be greater than zero.');
                    end;
                    PostBusinessClosure();

                end;

            }

            action("Group Members")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Group Members';
                Image = CustomerGroup;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Member Single List";
                RunPageLink = "Group Account No." = FIELD("Member No."), "Group Account No." = filter(<> '');
            }
        }


        area(processing)
        {

            group(Workflows)
            {
                Caption = 'Approval';

                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        JuniorError: Label 'You must specify either %1 %2 for %3';
                        IDJunior: Code[20];
                        ProductApplicationDocuments: Record "Product Documents";
                        ApplicationDocuments: Record "Application Documents";
                    begin
                        Rec.TestField("Transaction Type");
                        if Rec."Clossure Type" = Rec."Clossure Type"::"Individual Clossure" then begin
                            if Rec."Total Shares" <= 0 then Error('Total share refund must be greater than zero.');
                            if Rec."Net Balances" < 0 then Error('Total net refundable must be greater than zero.');
                        end;

                        if Rec."Clossure Type" = Rec."Clossure Type"::"Group Transfer" then begin
                            Rec.TestField("Member No.");
                            Rec.TestField("New Group No.");
                        end;

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then begin
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                        end;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }

                action(Approve)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }

                action("Re-Open")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category5;
                    Image = ReOpen;

                    trigger OnAction()
                    begin
                        //Rec.TestField(Status, Rec.Status::Deffered);
                        if (Rec.Status = Rec.Status::Deffered) or (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Pending) then begin
                            if Confirm('Are you sure you want to re-open this document?', false) = true then begin
                                Rec.Status := Rec.Status::Open;
                                Rec.Modify;
                            end;
                        end;
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }

                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        StatusControl;
    end;

    trigger OnAfterGetRecord()
    begin
        StatusControl
    end;

    trigger OnOpenPage()
    begin
        StatusControl
    end;


    procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    procedure PostBusinessClosure()
    var
        myInt: Integer;
        Interest: Decimal;
        LRepayment: Decimal;
        AvailableShares: Decimal;
        LineNo: Integer;
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Types";
        Amt: Decimal;
        AccNo: Code[10];
        BalAccNo: Code[10];
        GeneralSetUp: Record "General Set-Up";
        BankingUserTemplate: Record "Banking User Template";
        Jtemplate: Code[20];
        JBatch: Code[20];
        Totalrecovered: Decimal;
        TotalSaving: Decimal;
        Dim1: code[10];
        Dim2: code[10];
        Members: Record Members;
        NetAmount: decimal;
        UserSetup: Record "User Setup";
        Gnljnline: Record "Gen. Journal Line";
        msg: Text;
        SendSms: Codeunit SendSms;
        ProductFactory: Record "Product Factory";
        TotalSavings: Decimal;
        FOSAAccount: Code[20];
        SavingsAcc: Record "Savings Accounts";
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        TariffDetails: Record "Tiered Charges Lines";
        ChargeAmount: Decimal;
        Post: boolean;
        JournalPostingSucc: Codeunit "Journal Post Successful";
        AccountSignatories: Record "Account Signatories";
        AccountSignatoriesNew: Record "Account Signatories";
        OldGroupAccountNo: Code[50];
    begin
        if not Confirm('Are you sure you want to post this transaction?') then exit;
        Rec.CalcFields("FOSA Account No");
        if Rec."Clossure Type" = Rec."Clossure Type"::"Individual Clossure" then begin
            Members.Get(Rec."Member No.");
            SavingsAcc.Reset;
            SavingsAcc.SetRange(SavingsAcc."Loan Disbursement Account", true);
            SavingsAcc.SetRange(SavingsAcc."Member No.", Rec."Member No.");
            if SavingsAcc.Find('-') then begin
                FOSAAccount := SavingsAcc."No.";
            end;

            GeneralSetUp.get();
            if FOSAAccount = '' then FOSAAccount := Rec."FOSA Account No";
            Dim1 := Members."Global Dimension 1 Code";
            Dim2 := Members."Global Dimension 2 Code";

            GeneralSetUp.Get();
            BankingUserTemplate.Get(UserId);
            if UserSetup.Get(UserId) then begin
                Dim1 := UserSetup."Global Dimension 1 Code";
                Dim2 := UserSetup."Global Dimension 2 Code";
            end;

            Jtemplate := BankingUserTemplate."Transfer Journal Template";
            JBatch := BankingUserTemplate."Transfer Journal Batch";


            //delete journal line
            Gnljnline.Reset;
            Gnljnline.SetRange("Journal Template Name", Jtemplate);
            Gnljnline.SetRange("Journal Batch Name", JBatch);
            Gnljnline.DeleteAll;
            //end of deletion
            Interest := 0;
            AvailableShares := Rec."BOSA Shares";
            //Deposit account
            TotalSavings := 0;
            Totalrecovered := 0;
            TotalSaving := 0;
            SavingsAccounts.Reset;
            SavingsAccounts.SetRange(SavingsAccounts."Member No.", Rec."Member No.");
            SavingsAccounts.SetFilter("Product Category", '<>%1&<>%2&<>%3&<>%4', SavingsAccounts."Product Category"::"Entrance Fee", SavingsAccounts."Product Category"::"Benevolent (BBF)", SavingsAccounts."Product Category"::"Share Capital", SavingsAccounts."Product Category"::"Transfered Share Capital");
            if SavingsAccounts.Find('-') then begin
                repeat
                    ProductFactory.Get(SavingsAccounts."Product Type");
                    if ProductFactory."Source Unit" = ProductFactory."Source Unit"::"BUSINESS LOANS" then begin
                        TotalSavings += SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");

                        LineNo := LineNo + 10000;
                        AcctType := AcctType::Savings;
                        TransType := TransType::" ";
                        BalAccNo := '';
                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, Rec."No.",
                        Rec.Description, (SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.")), SavingsAccounts."No.", Today, BalAccType,
                        BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    end;
                until SavingsAccounts.Next = 0;
            end;

            NetAmount := 0;
            //Recover Through Saving the Balance
            //TotalSaving:=0;//TotalSaving-TCharges;
            Rec.CalcFields("FOSA Account No");
            SavingsAccounts.Reset;
            SavingsAccounts.SetRange(SavingsAccounts."Loan Disbursement Account", true);
            SavingsAccounts.SetRange(SavingsAccounts."Member No.", Rec."Member No.");
            if SavingsAccounts.Find('-') then begin
                LineNo := LineNo + 10000;
                AcctType := AcctType::Savings;
                TransType := TransType::" ";
                BalAccNo := '';

                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, Rec."No.",
                Rec.Description + Rec."No.", -(Rec."Net Balances"), Rec."FOSA Account No", today, BalAccType,
                BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
            end;

            AvailableShares := TotalSavings;
            TotalSaving := TotalSavings;
            if TotalSaving > 0 then begin
                Loans.Reset;
                Loans.SetRange(Loans."Member No.", Rec."Member No.");
                Loans.SetFilter("Outstanding Balance", '>%1', 0);
                if Loans.Find('-') then begin
                    repeat
                        ProdutFactory.Get(Loans."Loan Product Type");
                        if ProdutFactory."Source Unit" = ProdutFactory."Source Unit"::"BUSINESS LOANS" then begin
                            Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest", "Daily Interest");
                            if Loans."Daily Interest" > 0 then begin
                                If Loans."Outstanding Interest" < 0 then
                                    Loans."Outstanding Interest" := 0;
                                LoansProcess.CapitalizeDailyInterest(loans."Loan No.");
                            end;
                            //Recover Interest
                            if (Loans."Outstanding Interest" + Loans."Daily Interest") > 0 then begin
                                //**Interest:=0;
                                Interest := (Loans."Outstanding Interest" + Loans."Daily Interest");
                                LRepayment := Loans."Outstanding Balance";
                                if (AvailableShares > 0) and (Interest > 0) then begin
                                    //Interest Recovery
                                    LineNo := LineNo + 10000;
                                    AcctType := AcctType::Credit;
                                    TransType := TransType::"Interest Paid";
                                    if AvailableShares < Interest then
                                        Amt := -1 * AvailableShares
                                    else
                                        Amt := -1 * Interest;
                                    BalAccNo := '';
                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, Rec."No.",
                                    Rec.Description, Amt, Loans."Loan Account", Today, BalAccType,
                                    BalAccNo, Loans."Loan No.", Loans."Global Dimension 1 Code", loans."Global Dimension 2 Code", TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                    //LoanAmount:=LoanAmount-ABS(Amt);


                                    AvailableShares := AvailableShares - (Amt * -1);
                                    Totalrecovered := Totalrecovered + (Amt * -1);
                                    TotalSaving := TotalSaving + (Amt);
                                    Amt := 0;

                                end;
                            end;
                            //Recover Repayment
                            //**LRepayment:=0;
                            if Loans."Outstanding Balance" > 0 then
                                LRepayment := Loans."Outstanding Balance"
                            else
                                LRepayment := 0;

                            if (AvailableShares > 0) and (LRepayment > 0) then begin
                                LineNo := LineNo + 10000;
                                AcctType := AcctType::Credit;
                                TransType := TransType::Repayment;
                                BalAccNo := '';
                                if AvailableShares < LRepayment then
                                    Amt := -1 * AvailableShares
                                else
                                    Amt := -1 * LRepayment;

                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, Rec."No.",
                                Rec.Description, Amt, Loans."Loan Account", Today, BalAccType,
                                BalAccNo, Loans."Loan No.", Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                AvailableShares := AvailableShares - (Amt * -1);
                                Totalrecovered := Totalrecovered + (Amt * -1);
                                TotalSaving := TotalSaving + (Amt);
                                Amt := 0;
                            end;
                        end;
                    until Loans.Next = 0;
                end;


                // GeneralSetUp.get();
                // //Withdrawal Fee
                // if GeneralSetUp."Withdrawal Fee" > 0 then begin
                //     LineNo := LineNo + 10000;
                //     AcctType := AcctType::"G/L Account";
                //     TransType := TransType::" ";
                //     BalAccNo := '';
                //     GeneralSetUp.TestField(GeneralSetUp."Withdrawal Fee Account");

                //     JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, Rec."No.",
                //     Rec.Description + Rec."No.", -GeneralSetUp."Withdrawal Fee", GeneralSetUp."Withdrawal Fee Account", Today, BalAccType,
                //     BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                //     TotalSaving := TotalSaving - (GeneralSetUp."Withdrawal Fee");

                // end;

                //Charges
                TCharges := 0;


                TransactionCharges.Reset;
                TransactionCharges.SetRange(TransactionCharges."Transaction Type", Rec."Transaction Type");
                if TransactionCharges.Find('-') then begin
                    repeat

                        if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) or
                        (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::"Stamp Duty") then begin

                            LineNo := LineNo + 10000;

                            ChargeAmount := 0;
                            if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                ChargeAmount := (AvailableShares * TransactionCharges."Percentage of Amount") * 0.01
                            else
                                ChargeAmount := TransactionCharges."Charge Amount";

                            if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin

                                TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                                TariffDetails.Reset;
                                TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                if TariffDetails.Find('-') then begin
                                    repeat
                                        if (AvailableShares >= TariffDetails."Lower Limit") and (AvailableShares <= TariffDetails."Upper Limit") then begin
                                            if TariffDetails."Use Percentage" = true then begin
                                                ChargeAmount := AvailableShares * TariffDetails.Percentage * 0.01;
                                            end else begin
                                                ChargeAmount := TariffDetails."Charge Amount";
                                            end;
                                        end;
                                    until TariffDetails.Next = 0;
                                end;
                            end;

                            LineNo := LineNo + 10000;
                            AcctType := AcctType::Savings;
                            TransType := TransType::" ";
                            BalAccNo := TransactionCharges."G/L Account";
                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, Rec."No.",
                            TransactionCharges.Description, ChargeAmount, FOSAAccount, Today, BalAccType,
                            BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                            if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                              (TransactionCharges."Recover Excise Duty" = true) then begin
                                //Excise Duty
                                LineNo := LineNo + 10000;
                                AcctType := AcctType::Savings;
                                TransType := TransType::" ";
                                BalAccNo := GeneralSetUp."Excise Duty G/L";
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, Rec."No.",
                                TransactionCharges.Description + ' Excise Duty', ((ChargeAmount * GeneralSetUp."Excise Duty (%)") * 0.01), FOSAAccount, Today, BalAccType,
                                BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                            end;
                        end;
                    until TransactionCharges.Next = 0;
                end;


            end;

            JournalPosting.CompletePosting(Jtemplate, JBatch);
            //Post New

            SavingsAccounts.Reset;
            SavingsAccounts.SetRange(SavingsAccounts."Member No.", Rec."Member No.");
            SavingsAccounts.SetFilter("Product Category", '<>%1&<>%2&<>%3&<>%4', SavingsAccounts."Product Category"::"Entrance Fee", SavingsAccounts."Product Category"::"Benevolent (BBF)", SavingsAccounts."Product Category"::"Share Capital", SavingsAccounts."Product Category"::"Transfered Share Capital");
            if SavingsAccounts.Find('-') then begin
                repeat
                    ProductFactory.Get(SavingsAccounts."Product Type");
                    if ProductFactory."Source Unit" = ProductFactory."Source Unit"::"BUSINESS LOANS" then begin
                        if SavingsAccounts."Loan Disbursement Account" = false then begin
                            SavingsAccounts.Status := SavingsAccounts.Status::Closed;
                            SavingsAccounts.Blocked := SavingsAccounts.Blocked::All;
                            SavingsAccounts.Modify;
                        end;
                    end;
                until SavingsAccounts.Next = 0;
            end;

            if Rec."Clossure Type" = Rec."Clossure Type"::"Individual Clossure" then begin
                //--------
                if Members.Get(Rec."Member No.") then begin
                    Members."Has Joined Business Loans" := false;
                    Members."Group Account No." := '';
                    Members.Modify;
                end;
                Rec.Posted := true;
                Rec."Posted At" := CurrentDateTime;
                Rec."Posted By" := UserId;
                rec.Modify;

                //SMS- Alert
                msg := Text0005 + Format(Round(NetAmount, 1, '=')) + Text0006;

                SendSMS.SendSms(Source::WITHDRAWAL, SavingsAccounts."Transactional Mobile No", msg, Format(SavingsAccounts."No."), '', true, 0, false, 'CBS', SavingsAccounts."No.", 'CBS');
            end;
            if Rec."Clossure Type" = Rec."Clossure Type"::"Individual Group Exit" then begin
                if Members.Get(Rec."Member No.") then begin
                    // Members."Has Joined Business Loans" := false;
                    if Members."Group Account No." <> '' then begin
                        if GroupAccount.Get(Members."Group Account No.") then begin
                            msg := 'Dear Member, You have successfully exited from a business loan group ' + GroupAccount.Name + '.';
                        end else begin
                            msg := 'Dear Member, You have successfully exited from a business loan group.';
                        end;
                    end else begin
                        msg := 'Dear Member, You have successfully exited from a business loan group.';
                    end;
                    Members."Group Account No." := '';
                    Members.Modify;
                end;
                Rec.Posted := true;
                Rec."Posted At" := CurrentDateTime;
                Rec."Posted By" := UserId;
                rec.Modify;

                SendSMS.SendSms(Source::WITHDRAWAL, SavingsAccounts."Transactional Mobile No", msg, Format(SavingsAccounts."No."), '', true, 0, false, 'CBS', SavingsAccounts."No.", 'CBS');
            end;
        end;
        
        if Rec."Clossure Type" = Rec."Clossure Type"::"Group Clossure" then begin
            Members.Get(Rec."Member No.");
            AccountClosureLines.reset;
            AccountClosureLines.SetRange("No.", Rec."No.");
            AccountClosureLines.SetFilter("Net Refundable", '>0');
            if AccountClosureLines.Find('-') then begin
                repeat
                    SavingsAcc.Reset;
                    SavingsAcc.SetRange(SavingsAcc."Loan Disbursement Account", true);
                    SavingsAcc.SetRange(SavingsAcc."Member No.", AccountClosureLines."Member No.");
                    if SavingsAcc.Find('-') then begin
                        FOSAAccount := SavingsAcc."No.";
                    end;
                    GeneralSetUp.get();

                    Dim1 := Members."Global Dimension 1 Code";
                    Dim2 := Members."Global Dimension 2 Code";

                    GeneralSetUp.Get();
                    BankingUserTemplate.Get(UserId);
                    if UserSetup.Get(UserId) then begin
                        Dim1 := UserSetup."Global Dimension 1 Code";
                        Dim2 := UserSetup."Global Dimension 2 Code";
                    end;

                    Jtemplate := BankingUserTemplate."Transfer Journal Template";
                    JBatch := BankingUserTemplate."Transfer Journal Batch";


                    //delete journal line
                    Gnljnline.Reset;
                    Gnljnline.SetRange("Journal Template Name", Jtemplate);
                    Gnljnline.SetRange("Journal Batch Name", JBatch);
                    Gnljnline.DeleteAll;
                    //end of deletion
                    Interest := 0;
                    AvailableShares := AccountClosureLines."Savings Balance";
                    //Deposit account
                    TotalSavings := 0;
                    Totalrecovered := 0;
                    TotalSaving := 0;
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", AccountClosureLines."Member No.");
                    SavingsAccounts.SetFilter("Product Category", '<>%1&<>%2&<>%3&<>%4', SavingsAccounts."Product Category"::"Entrance Fee", SavingsAccounts."Product Category"::"Benevolent (BBF)", SavingsAccounts."Product Category"::"Share Capital", SavingsAccounts."Product Category"::"Transfered Share Capital");
                    if SavingsAccounts.Find('-') then begin
                        repeat
                            ProductFactory.Get(SavingsAccounts."Product Type");
                            if ProductFactory."Source Unit" = ProductFactory."Source Unit"::"BUSINESS LOANS" then begin
                                TotalSavings += SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");

                                LineNo := LineNo + 10000;
                                AcctType := AcctType::Savings;
                                TransType := TransType::" ";
                                BalAccNo := '';
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, Rec."No.",
                                Rec.Description, (SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.")), SavingsAccounts."No.", Today, BalAccType,
                                BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                            end;
                        until SavingsAccounts.Next = 0;
                    end;
                    AvailableShares := TotalSavings;
                    TotalSaving := TotalSavings;
                    if TotalSaving > 0 then begin
                        Loans.Reset;
                        Loans.SetRange(Loans."Member No.", AccountClosureLines."Member No.");
                        Loans.SetFilter("Outstanding Balance", '>%1', 0);
                        if Loans.Find('-') then begin
                            repeat
                                ProdutFactory.Get(Loans."Loan Product Type");
                                if ProdutFactory."Source Unit" = ProdutFactory."Source Unit"::"BUSINESS LOANS" then begin
                                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
                                    //Recover Interest
                                    if Loans."Outstanding Interest" > 0 then begin
                                        //**Interest:=0;
                                        Interest := Loans."Outstanding Interest";
                                        LRepayment := Loans."Outstanding Balance";
                                        if (AvailableShares > 0) and (Interest > 0) then begin
                                            //Interest Recovery
                                            LineNo := LineNo + 10000;
                                            AcctType := AcctType::Credit;
                                            TransType := TransType::"Interest Paid";
                                            if AvailableShares < Interest then
                                                Amt := -1 * AvailableShares
                                            else
                                                Amt := -1 * Interest;
                                            BalAccNo := '';
                                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, Rec."No.",
                                            Rec.Description, Amt, Loans."Loan Account", Today, BalAccType,
                                            BalAccNo, Loans."Loan No.", Loans."Global Dimension 1 Code", loans."Global Dimension 2 Code", TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                            //LoanAmount:=LoanAmount-ABS(Amt);


                                            AvailableShares := AvailableShares - (Amt * -1);
                                            Totalrecovered := Totalrecovered + (Amt * -1);
                                            TotalSaving := TotalSaving + (Amt);
                                            Amt := 0;

                                        end;
                                    end;
                                    //Recover Repayment
                                    //**LRepayment:=0;
                                    if Loans."Outstanding Balance" > 0 then
                                        LRepayment := Loans."Outstanding Balance"
                                    else
                                        LRepayment := 0;

                                    if (AvailableShares > 0) and (LRepayment > 0) then begin
                                        LineNo := LineNo + 10000;
                                        AcctType := AcctType::Credit;
                                        TransType := TransType::Repayment;
                                        BalAccNo := '';
                                        if AvailableShares < LRepayment then
                                            Amt := -1 * AvailableShares
                                        else
                                            Amt := -1 * LRepayment;

                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, Rec."No.",
                                        Rec.Description, Amt, Loans."Loan Account", Today, BalAccType,
                                        BalAccNo, Loans."Loan No.", Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                        AvailableShares := AvailableShares - (Amt * -1);
                                        Totalrecovered := Totalrecovered + (Amt * -1);
                                        TotalSaving := TotalSaving + (Amt);
                                        Amt := 0;
                                    end;
                                end;
                            until Loans.Next = 0;
                        end;

                        NetAmount := 0;
                        Rec.CalcFields("FOSA Account No");
                        SavingsAccounts.Reset;
                        SavingsAccounts.SetRange(SavingsAccounts."Loan Disbursement Account", true);
                        SavingsAccounts.SetRange(SavingsAccounts."Member No.", AccountClosureLines."Member No.");
                        if SavingsAccounts.Find('-') then begin
                            LineNo := LineNo + 10000;
                            AcctType := AcctType::Savings;
                            TransType := TransType::" ";
                            BalAccNo := '';

                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, Rec."No.",
                            Rec.Description + Rec."No.", -(Rec."Net Balances"), Rec."FOSA Account No", today, BalAccType,
                            BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        end;

                        //Withdrawal Fee
                        // if GeneralSetUp."Withdrawal Fee" > 0 then begin
                        //     LineNo := LineNo + 10000;
                        //     AcctType := AcctType::"G/L Account";
                        //     TransType := TransType::" ";
                        //     BalAccNo := '';
                        //     GeneralSetUp.TestField(GeneralSetUp."Withdrawal Fee Account");

                        //     JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, Rec."No.",
                        //     Rec.Description + Rec."No.", -GeneralSetUp."Withdrawal Fee", GeneralSetUp."Withdrawal Fee Account", Today, BalAccType,
                        //     BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                        //     TotalSaving := TotalSaving - (GeneralSetUp."Withdrawal Fee");

                        //   end;

                        //Charges
                        TCharges := 0;
                        TransactionCharges.Reset;
                        TransactionCharges.SetRange(TransactionCharges."Transaction Type", Rec."Transaction Type");
                        if TransactionCharges.Find('-') then begin
                            repeat

                                if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) or
                                (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::"Stamp Duty") then begin

                                    LineNo := LineNo + 10000;

                                    ChargeAmount := 0;
                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                        ChargeAmount := (AvailableShares * TransactionCharges."Percentage of Amount") * 0.01
                                    else
                                        ChargeAmount := TransactionCharges."Charge Amount";

                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin

                                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                                        TariffDetails.Reset;
                                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                        if TariffDetails.Find('-') then begin
                                            repeat
                                                if (AvailableShares >= TariffDetails."Lower Limit") and (AvailableShares <= TariffDetails."Upper Limit") then begin
                                                    if TariffDetails."Use Percentage" = true then begin
                                                        ChargeAmount := AvailableShares * TariffDetails.Percentage * 0.01;
                                                    end else begin
                                                        ChargeAmount := TariffDetails."Charge Amount";
                                                    end;
                                                end;
                                            until TariffDetails.Next = 0;
                                        end;
                                    end;

                                    LineNo := LineNo + 10000;
                                    AcctType := AcctType::Savings;
                                    TransType := TransType::" ";
                                    BalAccNo := TransactionCharges."G/L Account";
                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, Rec."No.",
                                    TransactionCharges.Description, ChargeAmount, FOSAAccount, Today, BalAccType,
                                    BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                    if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                      (TransactionCharges."Recover Excise Duty" = true) then begin
                                        //Excise Duty
                                        LineNo := LineNo + 10000;
                                        AcctType := AcctType::Savings;
                                        TransType := TransType::" ";
                                        BalAccNo := GeneralSetUp."Excise Duty G/L";
                                        JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, Rec."No.",
                                        TransactionCharges.Description + ' Excise Duty', ((ChargeAmount * GeneralSetUp."Excise Duty (%)") * 0.01), FOSAAccount, Today, BalAccType,
                                        BalAccNo, '', Dim1, Dim2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                    end;
                                end;
                            until TransactionCharges.Next = 0;
                        end;


                    end;

                    if Members.Get(AccountClosureLines."Member No.") then begin
                        Members."Has Joined Business Loans" := false;
                        if Members."Group Account No." <> '' then begin
                            if GroupAccount.Get(Members."Group Account No.") then begin
                                msg := 'Dear Member, You have successfully exited from a business loan group ' + GroupAccount.Name + '.';
                            end else begin
                                msg := 'Dear Member, You have successfully exited from a business loan group.';
                            end;
                        end else begin
                            msg := 'Dear Member, You have successfully exited from a business loan group.';
                        end;

                        Members."Group Account No." := '';
                        Members.Modify;

                        if msg <> '' then
                            SendSMS.SendSms(Source::WITHDRAWAL, SavingsAccounts."Transactional Mobile No", msg, Format(SavingsAccounts."No."), '', true, 0, false, 'CBS', SavingsAccounts."No.", 'CBS');
                    end;

                until AccountClosureLines.Next = 0;
            end;

            JournalPosting.CompletePosting(Jtemplate, JBatch);
            //Post New

            //Post New
            Post := false;
            Post := JournalPostingSucc.PostedSuccessfully;
            if Post = true then begin
                AccountClosureLinesII.reset;
                AccountClosureLinesII.SetRange("No.", Rec."No.");
                if AccountClosureLinesII.find('-') then begin
                    repeat
                        SavingsAccounts.Reset;
                        SavingsAccounts.SetRange(SavingsAccounts."Member No.", Rec."Member No.");
                        SavingsAccounts.SetFilter("Product Category", '<>%1&<>%2&<>%3&<>%4', SavingsAccounts."Product Category"::"Entrance Fee", SavingsAccounts."Product Category"::"Benevolent (BBF)", SavingsAccounts."Product Category"::"Share Capital", SavingsAccounts."Product Category"::"Transfered Share Capital");
                        if SavingsAccounts.Find('-') then begin
                            repeat
                                ProductFactory.Get(SavingsAccounts."Product Type");
                                if ProductFactory."Source Unit" = ProductFactory."Source Unit"::"BUSINESS LOANS" then begin
                                    if SavingsAccounts."Loan Disbursement Account" = false then begin
                                        SavingsAccounts.Status := SavingsAccounts.Status::Closed;
                                        SavingsAccounts.Blocked := SavingsAccounts.Blocked::All;
                                        SavingsAccounts.Modify;
                                    end;
                                end;
                            until SavingsAccounts.Next = 0;
                        end;
                        if Members.Get(Rec."Member No.") then begin
                            Members."Has Joined Business Loans" := false;
                            Members."Group Account No." := '';
                            Members.Status := Members.Status::Closed;
                            Members.Subflag := Members.Subflag::Closed;
                            Members.Modify;
                        end;
                    until AccountClosureLinesII.Next = 0;
                end;
                Rec.Posted := true;
                Rec."Posted At" := CurrentDateTime;
                Rec."Posted By" := UserId;
                rec.Modify;
            end;
        end;

        if Rec."Clossure Type" = Rec."Clossure Type"::"Group Transfer" then begin
            if Members.Get(Rec."Member No.") then begin
                if GroupAccount.Get(Rec."New Group No.") then begin
                    AccountSignatories.Reset();
                    AccountSignatories.SetRange("Member No.", Members."No.");
                    if AccountSignatories.FindFirst() then begin
                        OldGroupAccountNo := AccountSignatories."Account No";
                        AccountSignatoriesNew.Init();
                        AccountSignatoriesNew."Account No" := GroupAccount."No.";
                        AccountSignatoriesNew."Account Type" := AccountSignatories."Account Type";
                        AccountSignatoriesNew."Date Of Birth" := AccountSignatories."Date Of Birth";
                        AccountSignatoriesNew."Staff/Payroll" := AccountSignatories."Staff/Payroll";
                        AccountSignatoriesNew."ID Number" := AccountSignatories."ID Number";
                        AccountSignatoriesNew."Member No." := AccountSignatories."Member No.";
                        AccountSignatoriesNew."F Name" := AccountSignatories."F Name";
                        AccountSignatoriesNew."S Name" := AccountSignatories."S Name";
                        AccountSignatoriesNew."L Name" := AccountSignatories."L Name";
                        AccountSignatoriesNew.Gender := AccountSignatories.Gender;
                        AccountSignatoriesNew."PIN Number" := AccountSignatories."PIN Number";
                        AccountSignatoriesNew."Phone No." := AccountSignatories."Phone No.";
                        AccountSignatories.CalcFields(Picture, Signature);
                        AccountSignatoriesNew.Picture := AccountSignatories.Picture;
                        AccountSignatoriesNew.Signature := AccountSignatories.Signature;
                        AccountSignatoriesNew.Insert(true);
                    end;
                    AccountSignatories.Reset();
                    AccountSignatories.SetRange("Member No.", Members."No.");
                    AccountSignatories.SetRange("Account No", OldGroupAccountNo);
                    if AccountSignatories.FindFirst() then AccountSignatories.Delete();

                    Members."Group Account No." := Rec."New Group No.";
                    Rec.Posted := true;
                    Rec."Posted At" := CurrentDateTime;
                    Rec."Posted By" := UserId;
                    rec.Modify;
                    Members.Modify();
                end;
            end;
        end;
    end;

    procedure StatusControl()
    begin
        case Rec.Status of
            Rec.Status::Open:
                begin
                    PageEitable := true;
                end;

            Rec.Status::Pending:
                begin
                    PageEitable := false;
                end;
            Rec.Status::Rejected:
                begin
                    PageEitable := false;
                end;
            Rec.Status::Approved:
                begin
                    PageEitable := false;
                end;

        end;
        if Rec.Posted = true then PageEitable := false;
    end;

    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        PageEitable: Boolean;
        SavingsAccounts: Record "Savings Accounts";
        Loans: Record Loans;
        JournalPosting: Codeunit "Journal Posting";
        ProdutFactory: Record "Product Factory";
        Text0005: Label 'Dear member, Your business loans refund of KES ';
        Text0006: Label ' has been credited to your FOSA account. Access via Mobile Banking or ATM';
        Source: Enum "SMS Source";
        AccountClosureLines: Record "Account Closure Line";
        AccountClosureLinesII: Record "Account Closure Line";
        GroupAccount: Record Members;
        LoansProcess: Codeunit "Loans Process";


}
