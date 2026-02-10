page 52186407 "Product Factory Appl. Card"
{
    PageType = Card;
    SourceTable = "Product Factory Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = DocumentEdit;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product ID"; Rec."Product ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Description"; Rec."Product Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Class Type"; Rec."Product Class Type")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        DocumentControl;
                    end;
                }
                field("Min. Customer Age"; Rec."Min. Customer Age")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Max.Customer Age"; Rec."Max.Customer Age")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Rate (Min.)"; Rec."Interest Rate (Min.)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Rate (Max.)"; Rec."Interest Rate (Max.)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = InterestEdit;
                }
                field("Dormancy Period"; Rec."Dormancy Period")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Customer Segment"; Rec."Customer Segment")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Account No. Prefix"; Rec."Account No. Prefix")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No. Suffix"; Rec."Account No. Suffix")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Statement Charge"; Rec."Statement Charge")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Closure Fee"; Rec."Closure Fee")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Category"; Rec."Member Category")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Applicable To member category';
                }
            }
            group(Financials)
            {
                Editable = DocumentEdit;
                Visible = FinancialsVisible;
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Posting Group"; Rec."Product Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan  Account [G/L]"; Rec."Loan  Account [G/L]")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Interest Account [G/L]"; Rec."Loan Interest Account [G/L]")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Receivable Account[G/L]"; Rec."Loan Receivable Account[G/L]")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bill Account"; Rec."Bill Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Billed Account"; Rec."Billed Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Penalty Paid Account"; Rec."Penalty Paid Account")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Savings Product")
            {
                Editable = DocumentEdit;
                Visible = SavingsProductVisible;
                field("Loan Disbursement Account"; Rec."Loan Disbursement Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Category"; Rec."Product Category")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Auto Open Account"; Rec."Auto Open Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Security Inclination"; Rec."Loan Security Inclination")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Allow Multiple Accounts"; Rec."Allow Multiple Accounts")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Contribution"; Rec."Minimum Contribution")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Balance"; Rec."Minimum Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Notice; Rec.Notice)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withdrawal Interval"; Rec."Withdrawal Interval")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maximum No. of Withdrawal"; Rec."Maximum No. of Withdrawal")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Earns Interest"; Rec."Earns Interest")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Calc Min Balance"; Rec."Interest Calc Min Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Expense Account"; Rec."Interest Expense Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Payable Account"; Rec."Interest Payable Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Suspend Interest Account [G/L]"; Rec."Suspend Interest Account [G/L]")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dividend Calc. Method"; Rec."Dividend Calc. Method")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withholding Tax Account"; Rec."Withholding Tax Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("WithHolding Tax"; Rec."WithHolding Tax")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Allow Over Draft"; Rec."Allow Over Draft")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Credit Limit(Overdraft)"; Rec."Credit Limit(Overdraft)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Automatic Overdraft"; Rec."Automatic Overdraft")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Over Draft Interest %"; Rec."Over Draft Interest %")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Over Draft Interest Account"; Rec."Over Draft Interest Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Allow Multiple Over Draft"; Rec."Allow Multiple Over Draft")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Credit Product")
            {
                Editable = DocumentEdit;
                Visible = CreditProductVisible;
                field("Maximum Guarantors"; Rec."Maximum Guarantors")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Guarantors"; Rec."Minimum Guarantors")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Min. Re-application Period"; Rec."Min. Re-application Period")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Loan Amount"; Rec."Minimum Loan Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maximum Loan Amount"; Rec."Maximum Loan Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Prefferential Default installm"; Rec."Prefferential Default installm")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Ordinary Default Intallments"; Rec."Ordinary Default Intallments")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Repay Mode"; Rec."Repay Mode")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Use Cycle"; Rec."Use Cycle")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Grace Period - Interest"; Rec."Grace Period - Interest")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Grace Period - Principle"; Rec."Grace Period - Principle")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Installment Repayment Interval"; Rec."Installment Repayment Interval")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Compute Interest Due on Postin"; Rec."Compute Interest Due on Postin")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Fixed Loan Term"; Rec."Fixed Loan Term")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Ordinary Share Multiplier"; Rec."Ordinary Share Multiplier")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Preferential Share Multiplier"; Rec."Preferential Share Multiplier")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Span"; Rec."Loan Span")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Recovery Priority"; Rec."Recovery Priority")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Search Code"; Rec."Search Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Nature of Loan Type"; Rec."Nature of Loan Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Type of Discounting"; Rec."Type of Discounting")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Discounting %"; Rec."Discounting %")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Computation %"; Rec."Computation %")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control81; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control82; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control83; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Action96)
            {
                action("Product Charges")
                {
                    ApplicationArea = Basic, Suite;
                    Image = SetupPayment;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Product Charge Appl.";
                    RunPageLink = "Document No." = FIELD("No.");
                }
                action("Appraisal Parameters")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Evaluate;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "DCS Parameter Matrix Appl.";
                    RunPageLink = "Document No." = FIELD("No.");
                }
                action("Related Product")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Relatives;
                    Promoted = true;
                    RunObject = Page "Related Product Appl. List";
                    RunPageLink = "Document No." = FIELD("No.");
                }
            }
        }
        area(navigation)
        {
            action("Product Application Document")
            {
                ApplicationArea = Basic, Suite;
                Image = Documents;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Product Application Document";
                RunPageLink = "Document No." = FIELD("No.");
            }
        }
        area(processing)
        {
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
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);
                        // ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
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
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);
                        // // ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
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
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);
                        // ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
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
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        JuniorError: Label 'You must specify either %1 %2 for %3';
                        IDJunior: Code[20];
                        ProductDocuments: Record "Product Application Documents";
                        RelatedProduct: Record "Related Product Application";
                        DCSParameter: Record "DCS Parameter Matrix Appl.";
                        DCSMatrixTxt: Label 'Ensure Appraisal parameters are defines for this product.';
                    begin
                        Rec.TestField(Status, Rec.Status::Open);

                        Rec.TestField("Product ID");
                        Rec.TestField("Product Description");
                        Rec.TestField("Account No. Prefix");
                        Rec.TestField("Product Posting Group");

                        case Rec."Product Class Type" of
                            Rec."Product Class Type"::Savings:
                                begin
                                    Rec.TestField("Interest Rate (Min.)");
                                end;

                            Rec."Product Class Type"::Loan:
                                begin
                                    Rec.TestField("Interest Rate (Min.)");
                                    Rec.TestField("Loan  Account [G/L]");
                                    Rec.TestField("Loan Interest Account [G/L]");
                                    Rec.TestField("Loan Receivable Account[G/L]");
                                    Rec.TestField("Bill Account");

                                    DCSParameter.Reset;
                                    DCSParameter.SetRange(DCSParameter."Document No.", Rec."No.");
                                    if not DCSParameter.FindFirst then begin
                                        Error(DCSMatrixTxt);
                                    end;
                                    /*TESTfield(); TESTFIELD(); TESTFIELD(); TESTFIELD(); TESTFIELD(); Rec.TESTFIELD();*/
                                end;
                        end;

                        VarVariant := Rec;
                        // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        // CustomApprovals.OnSendDocForApproval(VarVariant);

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
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);
                        VarVariant := Rec;
                        // CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                    // // //ApprovalEntries: Page "Approval Entries";
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // // ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;

        DocumentControl;
    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        FinancialsVisible: Boolean;
        SavingsProductVisible: Boolean;
        CreditProductVisible: Boolean;
        DocumentEdit: Boolean;
        InterestEdit: Boolean;

    //[Scope('OnPrem')]
    procedure SetControlAppearance()
    var
    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    //[Scope('OnPrem')]
    procedure DocumentControl()
    begin
        FinancialsVisible := true;

        if Rec."Product Class Type" = Rec."Product Class Type"::" " then begin
            FinancialsVisible := false;
            SavingsProductVisible := false;
            CreditProductVisible := false;
        end;

        if Rec."Product Class Type" = Rec."Product Class Type"::Loan then begin
            InterestEdit := true;
            CreditProductVisible := true;
        end else begin
            InterestEdit := false;
            CreditProductVisible := false;
        end;

        if Rec."Product Class Type" = Rec."Product Class Type"::Savings then
            SavingsProductVisible := true
        else
            SavingsProductVisible := false;

        case Rec.Status of
            Rec.Status::Open:
                begin
                    DocumentEdit := true;
                end;
            Rec.Status::Pending, Rec.Status::Approved, Rec.Status::Rejected, Rec.Status::Converted:
                begin
                    DocumentEdit := false;
                end;
        end;
    end;
}

