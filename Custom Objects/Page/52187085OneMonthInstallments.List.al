page 52187085 "One Month Installments"
{
    ApplicationArea = All;
    PageType = List;
    Caption = 'Withheld Funds List';
    SourceTable = "One Month Installment";
    InsertAllowed = false;
    Editable = false;
    DeleteAllowed = false;
    UsageCategory = Lists;
    PromotedActionCategories = 'Home, Process, Navigate, Reports, Approvals, Help';

    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                field("Record No."; Rec."Record No.")
                {

                }
                field("Member No."; Rec."Member No.")
                {

                }
                field("Account No."; Rec."Account No.")
                {
                }
                field("Total"; Rec.Total) { }
                field("Funds Status"; Rec."Funds Status")
                {

                }
                field(Status; Rec.Status)
                {

                }
                field("Type"; Rec."Type")
                {

                }
                field("Held Funds Comments"; Rec."Held Funds Comments")
                { }
                field("Created By"; Rec."Created By")
                {

                }
                field("Entry Date"; Rec."Entry Date")
                {

                }
                field("Released By"; Rec."Released By")
                {

                }
                field("Time Released"; Rec."Time Released")
                {

                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';

                }
                field("Branch Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Branch Code';

                }
                field("Activity Code"; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Activity Code';

                }

            }
        }
    }

    actions
    {


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

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then begin
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                        end;
                    end;
                }
                action(Reaopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reaopen Card';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var

                    begin
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                        CurrPage.Update();
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

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Rec.Status, Rec.Status::Pending);
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category5;

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
                action("Release to FOSA")
                {
                    ApplicationArea = Basic, Suite;
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var

                    begin
                        Rec.TestField(Status, Rec.Status::Approved);

                        Rec."Funds Status" := Rec."Funds Status"::Released;
                        Rec."Released By" := UserId;
                        Rec."Time Released" := CurrentDateTime;
                        Rec."Released To" := Rec."Released To"::Savings;

                        Rec.Modify;

                        Message('One month installments released successfully');

                    end;
                }
                action("Post To Loan")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Jtemplate: Code[20];
                        JBatch: Code[20];
                        DocNo: Code[20];
                        PDate: Date;
                        AcctType: Enum "Gen. Journal Account Type";
                        AcctNo: Code[20];
                        Desc: Text[150];
                        BalAcctType: Enum "Gen. Journal Account Type";
                        BalAcctNo: Code[20];
                        Amt: Decimal;
                        ExtDocNo: Code[20];
                        Loan: Code[20];
                        TransType: enum "Transaction Types";
                        Dim1: Code[20];
                        Dim2: Code[20];
                        SystemCreated: Boolean;
                        SaccoTrans: Codeunit "Sacco Transactions";

                        Temp: Record "Banking User Template";
                        Loans: Record Loans;
                        IntAmount: Decimal;
                        PrAmount: Decimal;
                        GlobalFunctions: Codeunit "Global Functions";
                        CapitalisedInterest: Decimal;
                        RecoveryHeader: Record "Loan Recovery Header";
                        OutBal: Decimal;
                        OutInt: Decimal;
                        TotalBal: Decimal;
                        LoansProcess: Codeunit "Loans Process";
                        RunBal: Decimal;
                    begin
                        if Loans.Get(Rec."Record No.") then begin
                            RunBal := Rec.Total;
                            RecoveryHeader.GetLoanBalances(Loans."Loan No.", OutInt, OutBal, TotalBal);

                            LoansProcess.CapitalizeDailyInterest(Loans."Loan No.");

                            Temp.Get(UserId);

                            Jtemplate := Temp."Loans Template";
                            JBatch := Temp."Loans Batch";

                            if Jtemplate = '' then begin
                                Error('Ensure the Loans Template is set up in Banking User Setup');
                            end;
                            if JBatch = '' then begin
                                Error('Ensure the Loans Batch is set up in Banking User Setup')
                            end;
                            DocNo := Rec."Record No.";
                            PDate := Today;
                            AcctNo := Loans."Loan Account";
                            Desc := 'One Month Installment Posting';
                            ExtDocNo := DocNo;
                            Loan := Loans."Loan No.";

                            Dim1 := Loans."Global Dimension 1 Code";
                            Dim2 := Loans."Global Dimension 2 Code";

                            IntAmount := OutInt;

                            if IntAmount > RunBal then IntAmount := RunBal;

                            SaccoTrans.InitJournal(Jtemplate, JBatch);

                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Credit, AcctNo, Desc, BalAcctType::"G/L Account",
                                            '', -IntAmount, ExtDocNo, Loan, TransType::"Interest Paid", Dim1, Dim2, SystemCreated);

                            RunBal -= IntAmount;

                            if RunBal > 0 then begin
                                PrAmount := RunBal;
                                if RunBal > OutBal then
                                    PrAmount := OutBal;
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Credit, AcctNo, Desc, BalAcctType::"G/L Account",
                                            '', -PrAmount, ExtDocNo, Loan, TransType::Repayment, Dim1, Dim2, SystemCreated);
                            end;

                            AcctNo := Rec."Account No.";
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Savings, AcctNo, Desc, BalAcctType::"G/L Account",
                                            '', (PrAmount + IntAmount), ExtDocNo, '', TransType::" ", Dim1, Dim2, SystemCreated);

                            Rec."Funds Status" := Rec."Funds Status"::Released;
                            Rec."Released By" := UserId;
                            Rec."Time Released" := CurrentDateTime;
                            Rec."Released To" := Rec."Released To"::Loan;
                            Rec.Modify;

                            SaccoTrans.PostJournal(Jtemplate, JBatch);

                            Message('One month installments posted and released successfully');

                        end else
                            Message('There is no loan associated with this money');
                    end;
                }

            }
        }
    }

    trigger OnOpenPage()
    begin

    end;

    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        RecRef: RecordRef;

        //ControlVaribales
        PostMoneyToLoan: Boolean;
        ReleaseToSavings: Boolean;

}
