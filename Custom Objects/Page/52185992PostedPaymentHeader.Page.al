page 52185992 "Posted Payment Header"
{
    Caption = 'Payment Vouchers';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Payments Header";
    SourceTableView = WHERE("Payment Type" = FILTER(<> "Petty Cash"),
                            Posted = CONST(true));
    ApplicationArea = Basic, Suite;
    //  UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = DateEditable;
                    Importance = Promoted;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = GlobalDimension1CodeEditable;
                }
                field("Function Name"; Rec."Function Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Description';
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ShortcutDimension2CodeEditable;
                }
                field("Budget Center Name"; Rec."Budget Center Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Description';
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ShortcutDimension3CodeEditable;
                    Visible = false;
                }
                field(Dim3; Rec.Dim3)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Description';
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ShortcutDimension4CodeEditable;
                    Visible = false;
                }
                field(Dim4; Rec.Dim4)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Description';
                    Editable = false;
                    Visible = false;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = PaymodeEditable;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Currency CodeEditable";
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = bankeditabl;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment to';
                    Editable = PayeeEditable;
                    Importance = Promoted;
                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = OnBehalfEditable;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                }
                field("Cheque Type"; Rec."Cheque Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Cheque TypeEditable";
                }
                field("Invoice Currency Code"; Rec."Invoice Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Invoice Currency CodeEditable";
                    Visible = false;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Total Payment Amount"; Rec."Total Payment Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                }
                field("Total VAT Amount"; Rec."Total VAT Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                }
                field("Total Witholding Tax Amount"; Rec."Total Witholding Tax Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                }
                field("Total Retention Amount"; Rec."Total Retention Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                }
                field("""Total Payment Amount"" -( ""Total Witholding Tax Amount""+""Total VAT Amount""+""Total Retention Amount"")"; Rec."Total Payment Amount" - (Rec."Total Witholding Tax Amount" + Rec."Total VAT Amount" + Rec."Total Retention Amount"))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Net Amount';
                    Editable = false;
                    Importance = Promoted;
                }
                field("Total Payment Amount LCY"; Rec."Total Payment Amount LCY")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Net Amount LCY';
                    Editable = false;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cheque/EFT No.';
                    Editable = "Cheque No.Editable";
                }
                field("Bankers Cheque No"; Rec."Bankers Cheque No")
                {
                    ApplicationArea = Basic, Suite;
                    AssistEdit = false;
                    DrillDown = false;
                    Editable = true;
                    Enabled = true;
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Payment Release DateEditable";
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(PVLines; "Payment Lines")
            {
                SubPageLink = No = FIELD("No.");
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
                action("Print preview")
                {
                    ApplicationArea = Basic, Suite;
                    //RunObject = Report "Payment Voucher";
                }
                action(Print)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Print/Preview';
                    Image = ConfirmAndPrint;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    //Visible = false;

                    trigger OnAction()
                    var
                        Pvoucher: Record "Payments Header";
                    begin
                        // if Rec.Status <> Rec.Status::Approved then
                        //     Error('You can only print a Payment Voucher after it is fully Approved');
                        //IF Status=Status::Pending THEN
                        //ERROR('You cannot Print until the document is released for approval');
                        Pvoucher.Reset;
                        Pvoucher.SetFilter("No.", Rec."No.");
                        if Pvoucher.FindFirst() then
                            REPORT.Run(Report::"Normal/Petty Payment Voucher", true, true, Pvoucher);
                        Pvoucher.Reset;

                        CurrPage.Update;
                        CurrPage.SaveRecord;
                    end;
                }
                action("Cheque Print")
                {
                    ApplicationArea = Basic, Suite;
                    Image = PrintCheck;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Posted then begin
                            Rec.Reset;
                            Rec.SetFilter("No.", Rec."No.");
                            REPORT.Run(report::"Cheque Print", true, true, Rec);
                            Rec.Reset;
                        end;
                        /*END ELSE
                        ERROR(Err00001);*/

                    end;
                }
                action("Vendor Payment Advise")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor Payment Advise';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Pending then
                            Error('You cannot Print until the document is released for approval');
                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        //REPORT.Run(52185809, true, true, Rec);
                        Rec.Reset;
                    end;
                }
                action("Cheque Confirmation")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cheque Confirmation';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";

                    trigger OnAction()
                    var
                        FilterbyPayline: Record "Payment Line";
                    begin
                        if Rec.Status = Rec.Status::Pending then
                            Error('You cannot Print until the document is released for approval');
                        /*
                        FilterbyPayline.RESET;
                        FilterbyPayline.SETFILTER(FilterbyPayline.No,"No.");
                        */
                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        //REPORT.Run(52185830, true, true, Rec);
                        Rec.Reset;

                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Funds Mgt Comment List";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "Document No." = FIELD("No.");
                }
                separator(Action1102756005)
                {
                }
                action("Cancel Document")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text000: Label 'Are you sure you want to cancel this Document?';
                        Text001: Label 'You have selected not to Cancel the Document';
                        GLEntry: Record "G/L Entry";
                    begin
                        /*
                        TESTFIELD(Status,Status::Approved);
                        IF CONFIRM(Text000,TRUE) THEN  BEGIN
                        //Post Reversal Entries for Commitments
                        Doc_Type:=Doc_Type::"Payment Voucher";
                        CheckBudgetAvail.ReverseEntries(Doc_Type,"No.");
                        Status:=Status::Cancelled;
                        MODIFY;
                        END ELSE
                          ERROR(Text001);
                        */
                        if not Confirm(Text000, true) then exit;
                        //check if reversals exist
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."Document No.", Rec."No.");
                        GLEntry.SetRange(GLEntry.Reversed, true);
                        if not GLEntry.FindSet then
                            Error('Reverse The document entries first')
                        else begin
                            //Post Committment Reversals
                            Doc_Type := Doc_Type::"Payment Voucher";
                            CheckBudgetAvail.ReverseEntries(Doc_Type, Rec."No.");
                            Rec.Status := Rec.Status::Cancelled;
                            Rec.Modify;
                        end

                    end;
                }
            }
            group("Copy Documents")
            {
                Caption = 'Copy Documents';
                action("Copy Loan")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Copy Loan';
                    Image = GetLines;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /*prAssignEmp.RESET;
                        prAssignEmp.SETRANGE(prAssignEmp.Status,prAssignEmp.Status::"3");
                        IF prAssignEmp.FINDSET THEN
                        IF PAGE.RUNMODAL(39005545,prAssignEmp)=ACTION::LookupOK THEN
                        InsertPvLine(prAssignEmp);
                         */

                    end;
                }
                action("Copy Invoice")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Copy Invoice';
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
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                    //// //ApprovalEntries: Page "Approval Entries";
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*
                        DocumentType := DocumentType::"Payment Voucher";
                        ApprovalEntries.SetRecordFilters(DATABASE::"Payments Header","Document Type","No.");
                        ApprovalEntries.RUN;
                        */
                        // ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId)

                    end;
                }
            }
        }
    }

    var
        PayLine: Record "Payment Line";
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
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,Load,Discharge,"Express Pv";
        // DocPrint: Codeunit "Document-Print";
        CheckLedger: Record "Check Ledger Entry";
        Text001: Label 'This Document no %1 has printed Cheque No %2 which will have to be voided first before reposting.';
        CheckManagement: Codeunit CheckManagement;
        Text000: Label 'Do you want to Void Check No %1';
        Text002: Label 'You have selected post and generate a computer cheque ensure that your cheque printer is ready do you want to continue?';
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        // AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";

        "Cheque No.Editable": Boolean;

        "Payment Release DateEditable": Boolean;

        "Cheque TypeEditable": Boolean;

        "Invoice Currency CodeEditable": Boolean;

        "Currency CodeEditable": Boolean;

        GlobalDimension1CodeEditable: Boolean;

        "Payment NarrationEditable": Boolean;

        ShortcutDimension2CodeEditable: Boolean;

        PayeeEditable: Boolean;

        ShortcutDimension3CodeEditable: Boolean;

        ShortcutDimension4CodeEditable: Boolean;

        DateEditable: Boolean;

        PVLinesEditable: Boolean;
        StatusEditable: Boolean;
        PaymodeEditable: Boolean;
        BankEditabl: Boolean;
        OnBehalfEditable: Boolean;
        RespEditabl: Boolean;

    //[Scope('OnPrem')]
    procedure PostPaymentVoucher(Rec: Record "Payments Header")
    begin
    end;

    //[Scope('OnPrem')]
    procedure PostHeader(var Payment: Record "Payments Header")
    begin
    end;


    //[Scope('OnPrem')]
    procedure InsertApproval()
    begin
    end;

    //[Scope('OnPrem')]
    procedure LinesCommitmentStatus() Exists: Boolean
    var
        BCSetup: Record "Budgetary Control Setup";
    begin
    end;

    //[Scope('OnPrem')]
    procedure CheckPVRequiredItems(Rec: Record "Payments Header")
    begin
    end;

    //[Scope('OnPrem')]
    procedure PostPV(var Payment: Record "Payments Header")
    begin
    end;

    //[Scope('OnPrem')]
    procedure UpdatePageControls()
    begin
    end;

    //[Scope('OnPrem')]
    procedure LinesExists(): Boolean
    var
        PayLines: Record "Payment Line";
    begin
    end;

    //[Scope('OnPrem')]
    procedure AllFieldsEntered(): Boolean
    var
        PayLines: Record "Payment Line";
    begin
    end;

    //[Scope('OnPrem')]
    procedure CustomerPayLinesExist(): Boolean
    var
        PayLine: Record "Payment Line";
    begin
    end;

    local procedure CurrpageupdateOld()
    begin
    end;

    //[Scope('OnPrem')]
    procedure UpdateControls()
    begin
    end;

    //[Scope('OnPrem')]
    procedure CurrPageUpdate()
    begin
    end;

    //[Scope('OnPrem')]
    procedure InsertPvLine(prAssignEmpLoan: Record "Staff Claims Header")
    var
        PvLine: Record "Payment Line";
    begin
    end;
}

