page 52185991 "Posted Payment Vouchers List"
{
    CardPageID = "Posted Payment Header";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Payments Header";
    SourceTableView = WHERE("Payment Type" = FILTER(<> "Petty Cash"),
                            Posted = CONST(true));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total VAT Amount"; Rec."Total VAT Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Witholding Tax Amount"; Rec."Total Witholding Tax Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bankers Cheque No"; Rec."Bankers Cheque No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755014; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control1102755015; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control1102755016; Outlook)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control1102755017; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    // actions
    // {
    //     area(processing)
    //     {
    //         group("<Action1102755006>")
    //         {
    //             Caption = '&Functions';
    //             action(Print)
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'Print/Preview';
    //                 Image = ConfirmAndPrint;
    //                 Promoted = true;
    //                 PromotedCategory = "Report";
    //                 PromotedIsBig = true;

    //                 trigger OnAction()
    //                 begin
    //                     // IF Status<>Status::Approved THEN
    //                     //   ERROR('You can only print a Payment Voucher after it is fully Approved');



    //                     //IF Status=Status::Pending THEN
    //                     //ERROR('You cannot Print until the document is released for approval');
    //                     Rec.Reset;
    //                     Rec.SetFilter("No.", Rec."No.");
    //                     //REPORT.Run(52185782, true, true, Rec);
    //                     Rec.Reset;

    //                     CurrPage.Update;
    //                     CurrPage.SaveRecord;
    //                 end;
    //             }
    //             // action("Vendor Payment Advise")
    //             // {
    //             //     ApplicationArea = Basic, Suite;
    //             //     Caption = 'Vendor Payment Advise';
    //             //     Image = "Report";
    //             //     Promoted = true;
    //             //     PromotedCategory = "Report";

    //             //     trigger OnAction()
    //             //     begin
    //             //         if Rec.Status = Rec.Status::Pending then
    //             //             Error('You cannot Print until the document is released for approval');
    //             //         Rec.Reset;
    //             //         Rec.SetFilter("No.", Rec."No.");
    //             //         //REPORT.Run(52185809, true, true, Rec);
    //             //         Rec.Reset;
    //             //     end;
    //             // }
    //             // action("Cheque Confirmation")
    //             // {
    //             //     ApplicationArea = Basic, Suite;
    //             //     Caption = 'Cheque Confirmation';
    //             //     Image = "Report";
    //             //     Promoted = true;
    //             //     PromotedCategory = "Report";

    //             //     trigger OnAction()
    //             //     var
    //             //         FilterbyPayline: Record "Payment Line";
    //             //     begin
    //             //         if Rec.Status = Rec.Status::Pending then
    //             //             Error('You cannot Print until the document is released for approval');
    //             //         /*
    //             //         FilterbyPayline.RESET;
    //             //         FilterbyPayline.SETFILTER(FilterbyPayline.No,"No.");
    //             //         */
    //             //         Rec.Reset;
    //             //         Rec.SetFilter("No.", Rec."No.");
    //             //         //REPORT.Run(52185830, true, true, Rec);
    //             //         Rec.Reset;

    //             //     end;
    //             // }
    //             separator(Action1102755019)
    //             {
    //             }
    //             // action("<Action1102756006>")
    //             // {
    //             //     ApplicationArea = Basic, Suite;
    //             //     Caption = 'Cancel Document';
    //             //     Image = Cancel;
    //             //     Promoted = true;
    //             //     PromotedCategory = Process;
    //             //     PromotedIsBig = true;
    //             //     Visible = false;

    //             //     trigger OnAction()
    //             //     var
    //             //         Text000: Label 'Are you sure you want to cancel this Document?';
    //             //         Text001: Label 'You have selected not to Cancel the Document';
    //             //     begin
    //             //         Rec.TestField(Status, Rec.Status::Approved);
    //             //         if Confirm(Text000, true) then begin
    //             //             //Post Reversal Entries for Commitments
    //             //             Doc_Type := Doc_Type::"Payment Voucher";
    //             //             CheckBudgetAvail.ReverseEntries(Doc_Type, Rec."No.");
    //             //             Rec.Status := Rec.Status::Cancelled;
    //             //             Rec.Modify;
    //             //         end else
    //             //             Error(Text001);
    //             //     end;
    //             // }
    //         }
    //         group(Navigate)
    //         {
    //             Caption = 'Navigate';
    //             action(Approvals)
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'Approvals';
    //                 Image = Approvals;
    //                 Promoted = true;
    //                 PromotedCategory = Category9;

    //                 trigger OnAction()
    //                 var
    //                 //// //ApprovalEntries: Page "Approval Entries";
    //                 // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    //                 begin
    //                     /*
    //                     DocumentType := DocumentType::"Payment Voucher";
    //                     ApprovalEntries.SetRecordFilters(DATABASE::"Payments Header","Document Type","No.");
    //                     ApprovalEntries.RUN;
    //                     */
    //                     // ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId)

    //                 end;
    //             }
    //         }
    //     }
    // }

    trigger OnOpenPage()
    begin
        if UserMgt.GetPurchasesFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FilterGroup(0);
        end;
    end;

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
        CheckManagement: Codeunit CheckManagement;
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
        Text001: Label 'This Document no %1 has printed Cheque No %2 which will have to be voided first before reposting.';
        Text000: Label 'Do you want to Void Check No %1';
        Text002: Label 'You have selected post and generate a computer cheque ensure that your cheque printer is ready do you want to continue?';

    //[Scope('OnPrem')]
    procedure PostPaymentVoucher()
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
    procedure CheckPVRequiredItems()
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

    local procedure OnAfGetCurrRecord()
    begin
    end;
}

