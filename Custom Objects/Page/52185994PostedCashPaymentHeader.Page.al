page 52185994 "Posted Cash Payment Header"
{
    Caption = 'Petty Cash Payments';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption,EDMS';
    SourceTable = "Payments Header";
    SourceTableView = WHERE("Payment Type" = CONST("Petty Cash"),
                            Posted = CONST(true));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
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
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = DateEditable;
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
                }
                field(Dim3; Rec.Dim3)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Description';
                    Editable = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Currency CodeEditable";
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = Basic, Suite;
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
                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Payment NarrationEditable";
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
                }
                field("Total VAT Amount"; Rec."Total VAT Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Witholding Tax Amount"; Rec."Total Witholding Tax Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Retention Amount"; Rec."Total Retention Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("""Total Payment Amount"" - (""Total Witholding Tax Amount""+""Total VAT Amount""+""Total Retention Amount"")"; Rec."Total Payment Amount" - (Rec."Total Witholding Tax Amount" + Rec."Total VAT Amount" + Rec."Total Retention Amount"))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Net Amount';
                }
                field("Total Payment Amount LCY"; Rec."Total Payment Amount LCY")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Net Amount LCY';
                    Editable = false;
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
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            part(PVLines; "Cash Payment Lines")
            {
                Editable = PVLinesEditable;
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
                action("Print/Preview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Print/Preview';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        REPORT.Run(Report::"Normal/Petty Payment Voucher", true, true, Rec);
                        // Rec.Reset;
                    end;
                }
                separator(Action1102756004)
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
                    Visible = false;

                    trigger OnAction()
                    var
                        Text000: Label 'Are you sure you want to cancel this document?';
                        Text001: Label 'You have Selected not to cancle this document';
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        if Confirm(Text000, true) then begin
                            //Post Reversal Entries for Commitments
                            Doc_Type := Doc_Type::PettyCash;
                            CheckBudgetAvail.ReverseEntries(Doc_Type, Rec."No.");
                            Rec.Status := Rec.Status::Cancelled;
                            Rec.Modify;
                        end else
                            Error(Text001);
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
                    Visible = false;

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
            //     action("EDMS File List")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Image = Documents;
            //         Promoted = true;
            //         PromotedCategory = Category11;

            //         RunObject = page "EDMS Files List";
            //         RunPageLink = "Application No." = field("No.");
            //         // RunPageMode = Create;
            //     }
            // }
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
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        //  AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";

        "Payment Release DateEditable": Boolean;

        "Currency CodeEditable": Boolean;

        GlobalDimension1CodeEditable: Boolean;

        ShortcutDimension2CodeEditable: Boolean;

        "Payment NarrationEditable": Boolean;

        PayeeEditable: Boolean;

        ShortcutDimension3CodeEditable: Boolean;

        ShortcutDimension4CodeEditable: Boolean;

        DateEditable: Boolean;

        PVLinesEditable: Boolean;
        StatusEditable: Boolean;

    //[Scope('OnPrem')]
    procedure UpdatePageControl()
    var
        PvUser: Record "W/P Budget Buffer";
    begin
    end;

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
        BCsetup: Record "Budgetary Control Setup";
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

    local procedure OnCurrRecord()
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
}

